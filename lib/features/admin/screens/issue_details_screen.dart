import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/models/issue_model.dart';
import 'package:provider/provider.dart';

class IssueScreen extends StatefulWidget {
  const IssueScreen({super.key});

  @override
  State<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends State<IssueScreen> {
  IssueModel? issueModel;

  Future<void> fetchIssues() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final issueResponse = await apiProvider.getRequest(ApiUrls.allIssues);

      if (issueResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(issueResponse.body);
        issueModel = IssueModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch issues');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Student Issues'),
      body: FutureBuilder(
        future: fetchIssues(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Result> issues = issueModel!.result;
            return issueModel == null
                ? const Center(
                    child: Text(
                      "No Issues found",
                    ),
                  )
                : ListView.builder(
                    itemCount: issues.length,
                    itemBuilder: (context, index) {
                      final issue = issues[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IssueCard(issue: issue),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final Result issue;

  const IssueCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    ApiCall apiCall = ApiCall();
    return Container(
      width: double.maxFinite,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(),
      ),
      child: Column(
        children: [
          heightSpacer(20),
          Container(
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: const Alignment(0.00, -1.00),
                end: const Alignment(0, 1),
                colors: [
                  const Color(0xFF2E8B57).withOpacity(0.5),
                  const Color(0x002E8B57),
                ],
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    heightSpacer(20),
                    Image.asset(
                      AppConstants.person,
                      height: 70.h,
                      width: 70.w,
                    ),
                    heightSpacer(10),
                    Text(
                      '${issue.studentDetails.firstName} ${issue.studentDetails.lastName}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    heightSpacer(20),
                  ],
                ),
                widthSpacer(20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(10.0),
                    Text(
                      'Username: ${issue.studentDetails.firstName}',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Room Number: ${issue.roomDetails.roomNumber}'),
                    heightSpacer(8.0),
                    SizedBox(
                      width: 160.w,
                      child: Text(
                        'Email Id: ${issue.studentDetails.emailId}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Phone No.: ${issue.studentDetails.phoneNumber}'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 160.h,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Issue :',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  issue.issue,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            heightSpacer(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Student comment :',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                heightSpacer(12),
                                Text(
                                  '“${issue.studentComment}”',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                            heightSpacer(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    apiCall.closeAnIssue(
                                      issue.issueId,
                                      'Considered',
                                      context,
                                    );
                                  },
                                  child: Container(
                                    width: 120.w,
                                    padding: const EdgeInsets.all(8),
                                    decoration: ShapeDecoration(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 8,
                                          offset: Offset(1, 3),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Resolve',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            heightSpacer(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Container(
                //   width: double.maxFinite,
                //   height: 40.h,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Container(
                //           height: double.infinity,
                //           padding: const EdgeInsets.all(4),
                //           decoration: ShapeDecoration(
                //             color: const Color(0xFF2ECC71),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(8)),
                //             shadows: const [
                //               BoxShadow(
                //                 color: Color(0x3F000000),
                //                 blurRadius: 8,
                //                 offset: Offset(1, 3),
                //                 spreadRadius: 0,
                //               )
                //             ],
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Accept ',
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16.sp,
                //                   fontWeight: FontWeight.w700,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       const SizedBox(width: 32),
                //       Expanded(
                //         child: Container(
                //           height: double.infinity,
                //           padding: const EdgeInsets.all(4),
                //           decoration: ShapeDecoration(
                //             color: const Color(0xFFED6A77),
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(8)),
                //             shadows: const [
                //               BoxShadow(
                //                 color: Color(0x3F000000),
                //                 blurRadius: 8,
                //                 offset: Offset(1, 3),
                //                 spreadRadius: 0,
                //               )
                //             ],
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Reject',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16.sp,
                //                   fontWeight: FontWeight.w700,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
