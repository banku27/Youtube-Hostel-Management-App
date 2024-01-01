import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/auth/widgets/custom_button.dart';
import 'package:hostel_management/features/auth/widgets/custom_text_field.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';

class CreateStaff extends StatefulWidget {
  const CreateStaff({super.key});

  @override
  State<CreateStaff> createState() => _CreateStaffState();
}

class _CreateStaffState extends State<CreateStaff> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController jobRole = TextEditingController();
  ApiCall apiCall = ApiCall();
  @override
  void dispose() {
    userName.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    jobRole.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context, "Create Staff"),
      backgroundColor: AppColors.kBackgroundColor,
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text("You don't have permission to view this page"),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        controller: userName,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(15),
                      Text('First Name', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'First Name is required';
                          }
                          return null;
                        },
                        controller: firstName,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xFFD1D8FF)),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      heightSpacer(15),
                      Text('Last Name', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Last Name is required';
                          }
                          return null;
                        },
                        controller: lastName,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(15),
                      Text('Job Role', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Job Role is required';
                          }
                          return null;
                        },
                        controller: jobRole,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(15),
                      Text('Email', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (!emailRegex.hasMatch(value)) {
                            return 'Invalid email address';
                          }
                          return null;
                        },
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(15),
                      Text('Password', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        controller: password,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(15),
                      Text('Phone Number', style: AppTextTheme.kLabelStyle),
                      CustomTextField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number is required';
                          }
                          return null;
                        },
                        controller: phoneNumber,
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD1D8FF)),
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      heightSpacer(40),
                      CustomButton(
                        buttonText: "Create Staff",
                        press: () async {
                          if (_formKey.currentState!.validate()) {
                            print('validated');
                            await apiCall.createStaff(
                              userName.text,
                              firstName.text,
                              lastName.text,
                              password.text,
                              email.text,
                              phoneNumber.text,
                              jobRole.text,
                              context,
                            );
                          }
                        },
                      ),
                      heightSpacer(20),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$');
}
