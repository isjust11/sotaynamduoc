import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sotaynamduoc/helpers/gravatar.dart';
import 'package:sotaynamduoc/models/user_model.dart';
import 'package:sotaynamduoc/ui/auth/sign_in_ui.dart';
import 'package:sotaynamduoc/ui/components/loading.dart';
import 'package:sotaynamduoc/ui/home_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  // API configuration
  static const String baseUrl = "http://10.59.91.131:4000";
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String profileEndpoint = '/auth/profile';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  
  Rxn<UserModel> currentUser = Rxn<UserModel>();
  final RxBool admin = false.obs;
  final RxBool isAuthenticated = false.obs;
  String? authToken;
  String? refreshToken;

  @override
  void onReady() async {
    await loadTokens();
    await checkAuthStatus();
    super.onReady();
  }

  Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('accessToken');
    refreshToken = prefs.getString('refreshToken');
  }

  Future<void> saveTokens(String? accessToken, String? refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    if (accessToken != null) {
      await prefs.setString('accessToken', accessToken);
    }
    if (refreshToken != null) {
      await prefs.setString('refreshToken', refreshToken);
    }
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Check authentication status on app start
  Future<void> checkAuthStatus() async {
    // You can store token in SharedPreferences or secure storage
    // For now, we'll assume no stored authentication
    if (authToken != null) {
      await getCurrentUser();
    } else {
      Get.offAll(SignInUI());
    }
  }

  // Get current user from API
  Future<UserModel?> getCurrentUser() async {
    if (authToken == null) return null;
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$profileEndpoint'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        currentUser.value = UserModel.fromMap(userData);
        isAuthenticated.value = true;
        await checkAdminStatus();
        Get.offAll(HomeUI());
        return currentUser.value;
      } else if (response.statusCode == 401 && refreshToken != null) {
        // Token expired, try refresh
        final refreshed = await refreshAccessToken();
        if (refreshed) {
          return await getCurrentUser();
        } else {
          await signOut();
          return null;
        }
      } else {
        await signOut();
        return null;
      }
    } catch (e) {
      print('Error getting current user: $e');
      return null;
    }
  }

  Future<bool> refreshAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh-token'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refreshToken': refreshToken}),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['accessToken'] ?? data['token'];
        refreshToken = data['refreshToken'] ?? refreshToken;
        await saveTokens(authToken, refreshToken);
        return true;
      }
    } catch (e) {
      print('Error refreshing token: $e');
    }
    return false;
  }

  // Sign in with email and password
  Future<void> signInWithUsernameAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$loginEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );
      hideLoadingIndicator();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        authToken = data['accessToken'] ?? data['token'];
        refreshToken = data['refreshToken'];
        await saveTokens(authToken, refreshToken);
        currentUser.value = UserModel.fromMap(data['user']);
        isAuthenticated.value = true;
        usernameController.clear();
        passwordController.clear();
        await checkAdminStatus();
        Get.offAll(HomeUI());
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
          'auth.signInErrorTitle'.tr, 
          errorData['message'] ?? 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
      }
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'auth.signInErrorTitle'.tr, 
        'auth.signInError'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 7),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // User registration
  Future<void> registerWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      Gravatar gravatar = Gravatar(emailController.text);
      String gravatarUrl = gravatar.imageUrl(
        size: 200,
        defaultImage: GravatarImage.retro,
        rating: GravatarRating.pg,
        fileExtension: true,
      );
      final response = await http.post(
        Uri.parse('$baseUrl$registerEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'fullName': nameController.text,
          'email': emailController.text,
          'username': usernameController.text,
          'password': passwordController.text,
          'photoUrl': gravatarUrl,
        }),
      );
      hideLoadingIndicator();
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['accessToken'] ?? data['token'];
        refreshToken = data['refreshToken'];
        await saveTokens(authToken, refreshToken);
        currentUser.value = UserModel.fromMap(data['user']);
        isAuthenticated.value = true;
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        await checkAdminStatus();
        Get.offAll(HomeUI());
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
          'auth.signUpErrorTitle'.tr, 
          errorData['message'] ?? 'Registration failed',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
      }
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'auth.signUpErrorTitle'.tr, 
        'Registration failed: $error',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // Update user profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail, String password) async {
    String authUpdateUserNoticeTitle = 'auth.updateUserSuccessNoticeTitle'.tr;
    String authUpdateUserNotice = 'auth.updateUserSuccessNotice'.tr;
    
    try {
      showLoadingIndicator();
      
      final response = await http.put(
        Uri.parse('$baseUrl$profileEndpoint'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'fullName': user.fullName,
          'email': user.email,
          'oldEmail': oldEmail,
          'password': password,
        }),
      );

      hideLoadingIndicator();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        currentUser.value = UserModel.fromMap(data['user']);
        update();
      } else {
        final errorData = json.decode(response.body);
        authUpdateUserNoticeTitle = 'auth.updateUserErrorTitle'.tr;
        authUpdateUserNotice = errorData['message'] ?? 'auth.updateUserError'.tr;
      }

      Get.snackbar(
        authUpdateUserNoticeTitle, 
        authUpdateUserNotice,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'auth.updateUserErrorTitle'.tr, 
        'auth.unknownError'.tr,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(BuildContext context) async {
    showLoadingIndicator();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$resetPasswordEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': emailController.text,
        }),
      );

      hideLoadingIndicator();

      if (response.statusCode == 200) {
        Get.snackbar(
          'auth.resetPasswordNoticeTitle'.tr, 
          'auth.resetPasswordNotice'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
          'auth.resetPasswordFailed'.tr, 
          errorData['message'] ?? 'Password reset failed',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor,
        );
      }
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar(
        'auth.resetPasswordFailed'.tr, 
        'Password reset failed: $error',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Get.theme.snackBarTheme.backgroundColor,
        colorText: Get.theme.snackBarTheme.actionTextColor,
      );
    }
  }

  // Check if user is admin
  Future<void> checkAdminStatus() async {
    if (currentUser.value == null) return;
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/check-admin'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        admin.value = data['isAdmin'] ?? false;
      } else {
        admin.value = false;
      }
      update();
    } catch (e) {
      print('Error checking admin status: $e');
      admin.value = false;
      update();
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      if (refreshToken != null) {
        await http.post(
          Uri.parse('$baseUrl$logoutEndpoint'),
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
          body: json.encode({'refreshToken': refreshToken}),
        );
      }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      await clearTokens();
      authToken = null;
      refreshToken = null;
      currentUser.value = null;
      isAuthenticated.value = false;
      admin.value = false;
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Get.offAll(SignInUI());
    }
  }

  // Đăng nhập bằng Google
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoadingIndicator();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        hideLoadingIndicator();
        return; // Người dùng huỷ
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;
      if (idToken == null) {
        hideLoadingIndicator();
        Get.snackbar('auth.signInErrorTitle'.tr, 'Google sign in failed');
        return;
      }
      // Gửi idToken lên backend
      final response = await http.get(
        Uri.parse('$baseUrl/auth/google?token=$idToken'),
        headers: {'Content-Type': 'application/json'},
      );
      hideLoadingIndicator();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        authToken = data['accessToken'] ?? data['token'];
        refreshToken = data['refreshToken'];
        await saveTokens(authToken, refreshToken);
        currentUser.value = UserModel.fromMap(data['user']);
        isAuthenticated.value = true;
        await checkAdminStatus();
        Get.offAll(HomeUI());
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar('auth.signInErrorTitle'.tr, errorData['message'] ?? 'Google sign in failed');
      }
    } catch (e) {
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'Google sign in failed: $e');
    }
  }

  // Đăng nhập bằng Facebook
  Future<void> signInWithFacebook(BuildContext context) async {
    showLoadingIndicator();
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken?.tokenString;
        if (accessToken == null) {
          hideLoadingIndicator();
          Get.snackbar('auth.signInErrorTitle'.tr, 'Facebook sign in failed');
          return;
        }
        // Gửi accessToken lên backend
        final response = await http.get(
          Uri.parse('$baseUrl/auth/facebook?token=$accessToken'),
          headers: {'Content-Type': 'application/json'},
        );
        hideLoadingIndicator();
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          authToken = data['accessToken'] ?? data['token'];
          refreshToken = data['refreshToken'];
          await saveTokens(authToken, refreshToken);
          currentUser.value = UserModel.fromMap(data['user']);
          isAuthenticated.value = true;
          await checkAdminStatus();
          Get.offAll(HomeUI());
        } else {
          final errorData = json.decode(response.body);
          Get.snackbar('auth.signInErrorTitle'.tr, errorData['message'] ?? 'Facebook sign in failed');
        }
      } else {
        hideLoadingIndicator();
        Get.snackbar('auth.signInErrorTitle'.tr, 'Facebook sign in cancelled');
      }
    } catch (e) {
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'Facebook sign in failed: $e');
    }
  }
}
