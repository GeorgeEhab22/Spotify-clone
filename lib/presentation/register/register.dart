import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/app_bar/appBar.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/common/snack_bar/snack_bar.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/presentation/home/pages/home.dart';
import 'package:spotify_project/presentation/signin/signin.dart';
import 'package:spotify_project/service_locator.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Declare the TextEditingControllers here
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(
                height: 60,
              ),
              _fullNameField(context),
              const SizedBox(
                height: 20,
              ),
              _emailField(context),
              const SizedBox(
                height: 20,
              ),
              _passwordField(context),
              const SizedBox(
                height: 40,
              ),
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
                    var result = await serviceLocator<SignupUseCase>().call(
                        params: CreateUserReq(
                            fullName: _fullNameController.text.toString(),
                            email: _emailController.text.toString(),
                            password: _passwordController.text.toString()));
                    result.fold((l) {
                      Navigator.of(context, rootNavigator: true).pop();
                      showCustomSnackBar(context, l);
                    }, (r) {
                      showCustomSnackBar(context, 'Register success !');

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const Root()),
                          (route) => false);
                    });
                  },
                  title: 'Create Account'),
              const SizedBox(
                height: 40,
              ),
              _orSection(context),
              _haveAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Center(
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return Center(
        child: TextField(
      controller: _fullNameController,
      decoration: const InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    ));
  }

  Widget _emailField(BuildContext context) {
    return Center(
        child: TextField(
      controller: _emailController, // Use the correct controller
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    ));
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
              // Toggle icon based on password visibility
              Signin.isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                Signin.isPasswordVisible = !Signin.isPasswordVisible;
              });
            },
          )).applyDefaults(Theme.of(context).inputDecorationTheme),
    ));
  }

  Widget _orSection(BuildContext context) {
    return Row(
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
        const SizedBox(
          width: 10,
        ),
        const Text(
          'Or',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          width: 10,
        ),
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
    );
  }

  Widget _haveAccount(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you have an account?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Signin())),
              child: const Text('Sign In',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)))
        ],
      ),
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: AnimatedSnackBar(message: message),
      ),
    );

    overlay.insert(overlayEntry);

    // Automatically remove the Snackbar after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
