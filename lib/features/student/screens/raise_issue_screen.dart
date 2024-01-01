import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/auth/widgets/custom_button.dart';
import 'package:hostel_management/features/auth/widgets/custom_text_field.dart';
import 'package:hostel_management/theme/text_theme.dart';

class RaiseIssueScreen extends StatefulWidget {
  const RaiseIssueScreen({super.key});

  @override
  State<RaiseIssueScreen> createState() => _RaiseIssueScreenState();
}

class _RaiseIssueScreenState extends State<RaiseIssueScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController roomNumber = TextEditingController();
  TextEditingController block = TextEditingController();
  TextEditingController issue = TextEditingController();
  TextEditingController studentComment = TextEditingController();
  TextEditingController studentEmailId = TextEditingController();
  TextEditingController studentContactNumber = TextEditingController();
  ApiCall apiCall = ApiCall();

  String? selectedIssue;
  List<String> issues = [
    'Bathroom',
    'Bedroom',
    'Water',
    'Furniture',
    'Kitchen'
  ];

  @override
  void dispose() {
    roomNumber.dispose();
    block.dispose();
    issue.dispose();
    studentComment.dispose();
    studentEmailId.dispose();
    studentContactNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Create Issue"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacer(15),
                Text('Room Number', style: AppTextTheme.kLabelStyle),
                // CustomTextField(
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Room Number is required';
                //     }
                //     return null;
                //   },
                //   controller: roomNumber,
                //   enabledBorder: OutlineInputBorder(
                //     borderSide: const BorderSide(color: Color(0xFFD1D8FF)),
                //     borderRadius: BorderRadius.circular(14),
                //   ),
                //   // inputHint: "",
                // ),
                heightSpacer(15),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      ApiUrls.roomNumber,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text('Block Number', style: AppTextTheme.kLabelStyle),
                heightSpacer(15),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      ApiUrls.blockNumber,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),

                // CustomTextField(
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Block is required';
                //     }
                //     return null;
                //   },
                //   controller: block,
                //   enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Color(0xFFD1D8FF)),
                //       borderRadius: BorderRadius.circular(14)),
                // ),
                heightSpacer(15),
                Text('Your Email ID', style: AppTextTheme.kLabelStyle),
                heightSpacer(15),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      ApiUrls.email,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),

                heightSpacer(15),
                Text('Phone Number', style: AppTextTheme.kLabelStyle),
                heightSpacer(15),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      ApiUrls.phoneNumber,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ),
                heightSpacer(15),
                Text('Issue you are facing?', style: AppTextTheme.kLabelStyle),
                heightSpacer(15),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: double.maxFinite,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF2E8B57)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: DropdownButton<String>(
                    // elevation: 0,
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: selectedIssue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedIssue = newValue;
                      });
                    },
                    items: issues.map((String issue) {
                      return DropdownMenuItem<String>(
                        value: issue,
                        child: Text(issue),
                      );
                    }).toList(),
                  ),
                ),
                heightSpacer(15),
                Text('Comment', style: AppTextTheme.kLabelStyle),
                heightSpacer(15),
                CustomTextField(
                  controller: studentComment,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Comment is required';
                    }
                    return null;
                  },
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFFD1D8FF)),
                      borderRadius: BorderRadius.circular(14)),
                ),
                heightSpacer(40),
                CustomButton(
                  buttonText: "Submit",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      print('validated');
                      await apiCall.createAnIssue(
                        ApiUrls.roomNumber,
                        ApiUrls.blockNumber,
                        selectedIssue ?? "",
                        studentComment.text,
                        ApiUrls.email,
                        ApiUrls.phoneNumber,
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
