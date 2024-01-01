import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/models/staff_info_model.dart';
import 'package:provider/provider.dart';

class StaffInfoScreen extends StatefulWidget {
  const StaffInfoScreen({super.key});

  @override
  State<StaffInfoScreen> createState() => _StaffInfoScreenState();
}

class _StaffInfoScreenState extends State<StaffInfoScreen> {
  StaffInfoModel? staffInfoModel;

  ApiCall apicall = ApiCall();

  Future<void> fetcAllStaff() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final allstaff = await apiProvider.getRequest(ApiUrls.allStaff);

      if (allstaff.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(allstaff.body);
        print(allstaff.body);

        staffInfoModel = StaffInfoModel.fromJson(room);
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'All Staff'),
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text("You don't have permission to view this page"),
            )
          : FutureBuilder(
              future: fetcAllStaff(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return staffInfoModel == null
                      ? const Center(
                          child: Text(
                            "No Staff is Registered yet.",
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 2 / 1.2,
                              crossAxisSpacing: 16.0,
                              mainAxisSpacing: 16.0,
                            ),
                            itemCount: staffInfoModel!.result.length,
                            itemBuilder: (context, index) {
                              final staff = staffInfoModel!.result[index];
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 2, color: Color(0xFF007B3B)),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x4C007B3B),
                                      blurRadius: 8,
                                      offset: Offset(1, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                AppConstants.person,
                                                width: 90.w,
                                                height: 90.h,
                                              ),
                                              heightSpacer(20),
                                              Text(
                                                '${staff.jobRole}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xFF333333),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          widthSpacer(10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                heightSpacer(10.0),
                                                Text(
                                                  'Name: ${staff.firstName}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF333333),
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                heightSpacer(8.0),
                                                Text(
                                                  'Email: ${staff.emailId}',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF333333),
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                heightSpacer(8.0),
                                                Text(
                                                    'Contact: ${staff.phoneNumber}'),
                                                heightSpacer(8.0),
                                                Text(
                                                    'First Name: ${staff.firstName}'),
                                                // heightSpacer(8.0),
                                                // Text('Last Name: ${staff.lastName}'),

                                                // const Spacer(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        apicall.deleteStaff(
                                            context, staff.emailId);
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: double.maxFinite,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFEC6977),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Delete',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                }
              },
            ),
    );
  }
}
