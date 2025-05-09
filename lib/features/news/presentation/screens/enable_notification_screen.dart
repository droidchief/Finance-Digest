import 'dart:io';

import 'package:fin_hub/core/theme/app_colors.dart';
import 'package:fin_hub/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

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
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          "assets/images/message-notification.svg"),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get the most out of Blott ✅ ",
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        "Allow notifications to stay in the loop with your payments, requests and groups.",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.gray3,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                PrimaryButton(text: "Continue", onPressed: () {
                  _checkAndRequestNotificationPermission(context);
                }),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkAndRequestNotificationPermission(BuildContext context) async {
    var status = await Permission.notification.status;
    debugPrint("Notification status: $status");

    if (status.isGranted) {
      _navigateToNewsFeed(context);
    } else if (status.isDenied) {
      // Show default system dialog once
      var result = await Permission.notification.request();
      if (result.isGranted) {
        _navigateToNewsFeed(context);
      } else if (result.isPermanentlyDenied) {
        // Open settings since user denied with "Don't ask again"
        await openAppSettings();
        _navigateToNewsFeed(context);
      } else {
        // If still denied after prompt
        _navigateToNewsFeed(context);
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      _navigateToNewsFeed(context);
    } else {
      // Just fallback
      _navigateToNewsFeed(context);
    }
  }

  void _navigateToNewsFeed(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/news-feed');
  }

}
