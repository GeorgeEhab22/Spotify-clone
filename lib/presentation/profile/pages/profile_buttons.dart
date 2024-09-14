import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/common/logout/logout.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/choose_mode/pages/choose_mode.dart';

import '../../choose_mode/bloc/theme_cubit.dart';

class ProfileButton extends StatelessWidget {
  final String button;

  final bool logout;

  const ProfileButton({
    super.key,
    required this.button,
    required this.logout,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    var mode = context.read<ThemeCubit>();

    return Align(
      alignment: Alignment.topLeft,
      child: ElevatedButton(
        onPressed: () {
          if (button == 'change mode') {
            context.isDarkMode ? mode.setLightMode() : mode.setDarkMode();
          } else if (button == 'Log out') {
            Logout().logout();
            Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ChooseMode()),
                          (route) => false);
          } else {
            showNewDialog(context, button.substring(7));
          }
        },
        style: const ButtonStyle(
          alignment: Alignment.topLeft,
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          elevation: WidgetStatePropertyAll(0),
        ),
        child: Row(
          children: [
            Text(
              button,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.isDarkMode
                      ? const Color(0xffD6D6D6)
                      : const Color(0xff222222)),
            ),
            const SizedBox(
              width: 20,
            ),
            Icon(
              button == 'change mode'
                  ? Icons.change_circle_outlined
                  : button == 'change name'
                      ? Icons.account_circle_outlined
                      : button == 'change email'
                          ? Icons.email_outlined
                          : Icons.logout_outlined,
              color: logout ? Colors.red : AppColors.primary,
            )
          ],
        ),
      ),
    );
  }

  void showNewDialog(BuildContext context, String field) {
    final TextEditingController textController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Change $field'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(hintText: 'Enter new $field'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newValue = textController.text;

              // Trigger the Cubit to update the user in Firebase

              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
