import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/base_button.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/ui/widget/base_text_input.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  File? _selectedImage;
  String? _currentAvatarUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() {
    final authCubit = context.read<AuthCubit>();
    authCubit.getProfile();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      customAppBar: BaseAppBar(
        title: AppLocalizations.current.updateProfile,
        backgroundColor: AppColors.baseColor,
      ),
      body: BlocListener<AuthCubit, BaseState>(
        listener: (context, state) {
          if (state is LoadedState) {
            if (state.data is UserModel) {
              final userModel = state.data as UserModel;
              _fullNameController.text = userModel.fullName ?? '';
              _emailController.text = userModel.email ?? '';
              _currentAvatarUrl =
                  ApiConstant.storageHost + (userModel.picture ?? '');
              setState(() {});
            }
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isLoading = false;
            });
          } else if (state is LoadingState) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.SIZE_16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatarSection(),
            const SizedBox(height: AppDimens.SIZE_16),
            _buildFormFields(),
            const SizedBox(height: AppDimens.SIZE_32),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Container(
      width: double.infinity,
      height: AppDimens.SIZE_162,
      decoration: BoxDecoration(
        color: AppColors.baseColor,
        borderRadius: BorderRadius.circular(AppDimens.SIZE_16),
      ),
      padding: const EdgeInsets.all(AppDimens.SIZE_16),
      child: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              Assets.images.checkeredPattern,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: _showImagePicker,
                      child: Container(
                        width: AppDimens.SIZE_120,
                        height: AppDimens.SIZE_120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.baseColor,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: _selectedImage != null
                              ? Image.file(_selectedImage!, fit: BoxFit.cover)
                              : _currentAvatarUrl != null &&
                                    _currentAvatarUrl!.isNotEmpty
                              ? Image.network(
                                  _currentAvatarUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildDefaultAvatar();
                                  },
                                )
                              : _buildDefaultAvatar(),
                        ),
                      ),
                    ),
                    Positioned(
                      right: AppDimens.SIZE_16,
                      bottom: 0,
                      child: Container(
                        width: AppDimens.SIZE_20,
                        height: AppDimens.SIZE_20,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(
                            AppDimens.SIZE_10,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.baseColor,
                          size: AppDimens.SIZE_16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: AppColors.gray.withOpacity(0.3),
      child: Icon(Icons.person, size: AppDimens.SIZE_60, color: AppColors.gray),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel.renderBaseTitle(
          title: AppLocalizations.current.fullName,
          isRequired: true,
        ),
        CustomTextInput(
          textController: _fullNameController,
          hintText: AppLocalizations.current.pleaseEnterFullName,
          validator: (value) {
            if (value.trim().isEmpty) {
              return AppLocalizations.current.pleaseEnterFullName;
            }
            return null;
          },
        ),
        const SizedBox(height: AppDimens.SIZE_16),
        CustomTextLabel.renderBaseTitle(
          title: AppLocalizations.current.email,
          isRequired: true,
        ),
        CustomTextInput(
          textController: _emailController,
          hintText: AppLocalizations.current.plsInputEmail,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.trim().isEmpty) {
              return AppLocalizations.current.plsInputEmail;
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return AppLocalizations.current.pleaseEnterValidEmail;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return BaseButton(
      title: AppLocalizations.current.save,
      onTap: _isLoading ? null : _saveProfile,
      backgroundColor: AppColors.baseColor,
      width: double.infinity,
      height: AppDimens.SIZE_48,
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: CustomTextLabel(AppLocalizations.current.camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: CustomTextLabel(AppLocalizations.current.gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: CustomTextLabel(AppLocalizations.current.cancel),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      // Handle permission denied or other errors
      String errorMessage = 'Không thể chọn ảnh';
      if (e.toString().contains('permission')) {
        errorMessage =
            'Vui lòng cấp quyền truy cập camera/thư viện ảnh trong cài đặt';
      } else if (e.toString().contains('camera')) {
        errorMessage = 'Không thể truy cập camera';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();

      // Convert image to base64 if selected
      String? urlPicture;
      if (_selectedImage != null) {
        urlPicture = null;
      }
      // upload image to server
      final mediaCubit = context.read<MediaCubit>();
      final media = await mediaCubit.uploadMedia(_selectedImage!);
      urlPicture = media.publicRelativePath;
      authCubit.updateProfile(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        picture: urlPicture,
      );

      // Listen for success
      authCubit.stream.listen((state) {
        if (state is LoadedState && state.data is UserModel) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.current.profileUpdated),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      });
    }
  }
}
