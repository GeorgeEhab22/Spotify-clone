import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/app_bar/basic_appBar.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/common/snack_bar/snack_bar.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/navigations.dart';
import 'package:spotify_project/presentation/register/register.dart';
import 'package:spotify_project/presentation/home/pages/home.dart';
import 'package:spotify_project/service_locator.dart';

class Signin extends StatefulWidget {
  static bool isPasswordVisible = false;

  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  // Declare controllers in the state class
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the tree
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool success=false;
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        isHome: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signinText(),
              const SizedBox(height: 60),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 40),
              BasicAppButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.primary,
                            )));
                    // Use the controllers to access the text values
                    var result = await serviceLocator<SigninUseCase>().call(
                        params: SigninUserReq(
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString()));
                    result.fold((l) {
                      Navigator.of(context, rootNavigator: true).pop();
                      showCustomSnackBar(context, l,success);
                    }, (r) {
                      success=true;
                      showCustomSnackBar(context, 'Sign in success!',success);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Navigation()),
                          (route) => false);
                    });
                  },
                  title: 'Sign In'),
              const SizedBox(height: 40),
              Row(
                children: [
                  context.isDarkMode
                      ? Align(
                          alignment: Alignment.bottomLeft,
                          child: SvgPicture.asset(AppVectors.darlLine),
                        )
                      : Align(
                          alignment: Alignment.bottomLeft,
                          child: SvgPicture.asset(AppVectors.lightLine),
                        ),
                  const SizedBox(width: 10),
                  const Text(
                    'Or',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(width: 10),
                  context.isDarkMode
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(AppVectors.darlLine),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: SvgPicture.asset(AppVectors.lightLine),
                        ),
                ],
              ),
              _newAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signinText() {
    return const Center(
      child: Text(
        'Sign in',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return Center(
      child: TextField(
        controller: _emailController, // Use the correct controller
        decoration: const InputDecoration(
          hintText: 'Enter username or email',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return Center(
      child: TextField(
        controller: _passwordController, // Use the correct controller
        obscureText: !Signin.isPasswordVisible,
        decoration: InputDecoration(
          hintText: 'Password',
          suffixIcon: IconButton(
            icon: Icon(
              Signin.isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                Signin.isPasswordVisible = !Signin.isPasswordVisible;
              });
            },
          ),
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
      ),
    );
  }

  Widget _newAccount(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Not A Member?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Register(),
              ),
            ),
            child: const Text(
              'Register Now',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showCustomSnackBar(BuildContext context, String message,bool success) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: AnimatedSnackBar(message: message,success:success ,),
      ),
    );

    overlay.insert(overlayEntry);

    // Automatically remove the Snackbar after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
