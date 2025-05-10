import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/user_model.dart';

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  State<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends State<EnterNameScreen> {
  final _formKey = GlobalKey<FormState>();
  User? user;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    firstNameController.addListener(_validateForm);
    lastNameController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty;
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Your legal name",
            style: TextStyle(
              fontSize: 30,
              height: 1.25,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                "We need to know a bit about you so that we can create your account.",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.gray3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Gap(20),
              TextFormField(
                controller: firstNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'First name',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.gray2,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                ),
              ),
              const Gap(40),
              TextFormField(
                controller: lastNameController,
                keyboardType: TextInputType.name,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Last name',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.gray2,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray),
                  ),
                ),
              ),
            ],
          ),
        ),

        floatingActionButton: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 0,
          ),
          child: GestureDetector(
            onTap:
            _isFormValid
                ? _checkPermissionAndNavigate
                : null,
            child: Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: _isFormValid ? AppColors.primary : AppColors.primary.withOpacity(0.5),
                shape: BoxShape.circle
              ),
              child: Icon(Icons.arrow_forward_ios, color: AppColors.white, size: 20,),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkPermissionAndNavigate() async {
    // Check if permission is granted for notifications
    final permissionStatus = await Permission.notification.status;

    if (permissionStatus.isGranted) {
      Navigator.pushReplacementNamed(context, '/news-feed');
    } else {
      Navigator.pushReplacementNamed(context, '/enable-notification');
    }
  }

}
