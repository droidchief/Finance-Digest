import 'package:fin_hub/core/theme/app_colors.dart';
import 'package:fin_hub/shared/primary_button.dart';
import 'package:flutter/material.dart';

class EnableNotificationScreen extends StatefulWidget {
  const EnableNotificationScreen({super.key});

  @override
  State<EnableNotificationScreen> createState() =>
      _EnableNotificationScreenState();
}

class _EnableNotificationScreenState extends State<EnableNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            AppButton(
              text: "",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
