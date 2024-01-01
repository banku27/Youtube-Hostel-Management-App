import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/admin/screens/create_staff.dart';
import 'package:hostel_management/features/admin/screens/issue_details_screen.dart';
import 'package:hostel_management/features/admin/screens/room_change_requests_screen.dart';
import 'package:hostel_management/features/admin/screens/staff_display_screen.dart';
import 'package:hostel_management/features/student/screens/hostel_fees.dart';
import 'package:hostel_management/features/student/screens/profile_screen.dart';
import 'package:hostel_management/features/student/screens/raise_issue_screen.dart';
import 'package:hostel_management/features/student/screens/room_availability.dart';
import 'package:hostel_management/models/student_info_model.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:hostel_management/theme/text_theme.dart';
import 'package:hostel_management/widgets/category_card.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StudentInfoModel? studentInfoModel;

  List<ChartData>? _chartData;

  Future<void> fetchStudentDetails(String emailId) async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final studentInfo =
          await apiProvider.getRequest('${ApiUrls.studentDetails}$emailId');

      if (studentInfo.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(studentInfo.body);
        print(studentInfo.body);

        studentInfoModel = StudentInfoModel.fromJson(room);
        ApiUrls.email = studentInfoModel!.result[0].studentProfileData.emailId;
        ApiUrls.phoneNumber = studentInfoModel!
            .result[0].studentProfileData.phoneNumber
            .toString();
        ApiUrls.roomNumber = studentInfoModel!
            .result[0].studentProfileData.roomNumber
            .toString();
        ApiUrls.username =
            studentInfoModel!.result[0].studentProfileData.userName;
        ApiUrls.blockNumber =
            studentInfoModel!.result[0].studentProfileData.block;
        ApiUrls.firstName =
            studentInfoModel!.result[0].studentProfileData.firstName;
        ApiUrls.lastName =
            studentInfoModel!.result[0].studentProfileData.lastName;
        ApiUrls.roleId =
            studentInfoModel!.result[0].studentProfileData.roleId.roleId;
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchPieChartData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiUrls.baseUrl}${ApiUrls.fetchPieChartData}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final roomChangeChart = data['result'][0]['roomChangeIssueChart'];

        setState(() {
          _chartData = [
            ChartData(
                label: 'Approved',
                value: roomChangeChart['totalRoomChangeRequestsApproved']
                    .toDouble(),
                color: Colors.green),
            ChartData(
                label: 'Rejected',
                value: roomChangeChart['totalRoomChangeRequestsRejected']
                    .toDouble(),
                color: Colors.red),
            ChartData(
                label: 'Pending',
                value: (roomChangeChart['totalNumberRoomChangeRequest'] -
                        roomChangeChart['totalRoomChangeRequestsApproved'] -
                        roomChangeChart['totalRoomChangeRequestsRejected'])
                    .toDouble(),
                color: Colors.grey),
          ];
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error appropriately
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudentDetails(ApiUrls.email);
    fetchPieChartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Dashboard",
          style: AppTextTheme.kLabelStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: AppColors.kGreenColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProfileScreen(
                      roomNumber: studentInfoModel
                              ?.result[0].studentProfileData.roomNumber
                              .toString() ??
                          "No Data",
                      blockNumber: studentInfoModel
                              ?.result[0].studentProfileData.block
                              .toString() ??
                          "No Data",
                      username: studentInfoModel
                              ?.result[0].studentProfileData.userName
                              .toString() ??
                          "No Data",
                      emailId: studentInfoModel
                              ?.result[0].studentProfileData.emailId
                              .toString() ??
                          "No Data",
                      phoneNumber: studentInfoModel
                              ?.result[0].studentProfileData.phoneNumber
                              .toString() ??
                          "No Data",
                      firstName: studentInfoModel
                              ?.result[0].studentProfileData.firstName
                              .toString() ??
                          "No Data",
                      lastName: studentInfoModel
                              ?.result[0].studentProfileData.lastName
                              .toString() ??
                          "No Data",
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                AppConstants.profile,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              heightSpacer(20),
              ApiUrls.email == ''
                  ? const SizedBox()
                  : Container(
                      height: 140.h,
                      width: double.maxFinite,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2, color: Color(0xFF007B3B)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(2),
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x332E8B57),
                            blurRadius: 8,
                            offset: Offset(2, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180.w,
                                  child: Text(
                                    '${ApiUrls.firstName} ${ApiUrls.lastName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF333333),
                                      fontSize: 24.sp,
                                    ),
                                  ),
                                ),
                                heightSpacer(15),
                                Text(
                                  "Room No. : ${ApiUrls.roomNumber}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Text(
                                  'Block No. :  ${ApiUrls.blockNumber}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 15.sp,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const RaiseIssueScreen(),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(AppConstants.createIssue),
                                  Text(
                                    'Create issues',
                                    style: TextStyle(
                                      color: const Color(0xFF153434),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              heightSpacer(30),
              Container(
                width: double.maxFinite,
                color: const Color(0x262E8B57),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightSpacer(20),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    heightSpacer(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CategoryCard(
                          category: 'Room\nAvailability',
                          image: AppConstants.roomAvailability,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const RoomAvailabilityScreen(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'All\nIssues',
                          image: AppConstants.allIssues,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const IssueScreen(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'Staff\nMembers',
                          image: AppConstants.staffMember,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const StaffInfoScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    heightSpacer(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CategoryCard(
                          category: 'Create\nStaff',
                          image: AppConstants.createStaff,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const CreateStaff(),
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          category: 'Hostel\nFee',
                          image: AppConstants.hostelFee,
                          onTap: () {
                            ApiUrls.roleId != 2
                                ? () {}
                                : Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => HostelFee(
                                        blockNumber: studentInfoModel!
                                            .result[0].studentProfileData.block,
                                        roomNumber: studentInfoModel!.result[0]
                                            .studentProfileData.roomNumber
                                            .toString(),
                                        maintenanceCharge: studentInfoModel!
                                            .result[0]
                                            .roomChargesModel
                                            .maintenanceCharges
                                            .toString(),
                                        parkingCharge: studentInfoModel!
                                            .result[0]
                                            .roomChargesModel
                                            .parkingCharges
                                            .toString(),
                                        waterCharge: studentInfoModel!.result[0]
                                            .roomChargesModel.roomWaterCharges
                                            .toString(),
                                        roomCharge: studentInfoModel!.result[0]
                                            .roomChargesModel.roomAmount
                                            .toString(),
                                        totalCharge: studentInfoModel!.result[0]
                                            .roomChargesModel.totalAmount
                                            .toString(),
                                      ),
                                    ),
                                  );
                          },
                        ),
                        CategoryCard(
                          category: 'Change\nRequests',
                          image: AppConstants.roomChange,
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    const RoomChangeRequestScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    heightSpacer(20),
                  ],
                ),
              ),
              _chartData == null
                  ? const CircularProgressIndicator()
                  : ApiUrls.roleId == 2 || ApiUrls.roleId == 3
                      ? const SizedBox.shrink()
                      : SfCircularChart(
                          series: <CircularSeries>[
                            PieSeries<ChartData, String>(
                              dataSource: _chartData,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.value,
                              dataLabelMapper: (ChartData data, _) =>
                                  '${data.label}\n${data.value}',
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({required this.label, required this.value, required this.color});
}
