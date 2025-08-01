import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static final apiHost = dotenv.env['API_URL'] ?? 'http://localhost:4000';
  static final login = "$apiHost/auth/login";
  static final getUserInfo = "$apiHost/auth/profile";
  static final getCategories = "$apiHost/categories";
  static final getCategoriesByCategoryTypeCode = "$apiHost/categories/get-by-category-type";
  static final getFolkMedicines = "$apiHost/folk-medicine";
}
