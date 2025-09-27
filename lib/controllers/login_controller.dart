import 'package:get/get.dart';
import 'package:news_app/views/home_screen.dart';
import 'package:news_app/views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoggedIn = false.obs;

  var obscurePassword = true.obs;
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void login(String emailInput, String passwordInput) async {
    if (emailInput.isNotEmpty && passwordInput.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('email', emailInput);
      isLoggedIn(true);
      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar('Error', 'Email and Password required');
    }
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('isLoggedIn');
    if (loggedIn != null && loggedIn) {
      isLoggedIn(true);
      Get.offAll(() => const HomeScreen());
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn(false);
    Get.offAll(() => LoginScreen());
  }
}
