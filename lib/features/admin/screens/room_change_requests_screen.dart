import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/models/room_change_model.dart';
import 'package:provider/provider.dart';

class RoomChangeRequestScreen extends StatefulWidget {
  const RoomChangeRequestScreen({super.key});

  @override
  State<RoomChangeRequestScreen> createState() =>
      _RoomChangeRequestScreenState();
}

class _RoomChangeRequestScreenState extends State<RoomChangeRequestScreen> {
  RoomChangeModel? roomModel;

  Future<void> fetchRequests() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);

      final requestResponse =
          await apiProvider.getRequest(ApiUrls.roomChangeRequests);

      if (requestResponse.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(requestResponse.body);
        roomModel = RoomChangeModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch requests');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Room change requests'),
      body: ApiUrls.roleId == 2 || ApiUrls.roleId == 3
          ? const Center(
              child: Text("You don't have permission to view this page"),
            )
          : FutureBuilder(
              future: fetchRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Result> room = roomModel!.result;
                  return roomModel == null
                      ? const Center(
                          child: Text(
                            "No change room requets found",
                          ),
                        )
                      : ListView.builder(
                          itemCount: room.length,
                          itemBuilder: (context, index) {
                            final request = room[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RoomCard(request: request),
                            );
                          },
                        );
                }
              },
            ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final Result request;

  const RoomCard({super.key, required this.request});

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
                      '${request.studentDetails.firstName} ${request.studentDetails.lastName}',
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
                      'Username: ${request.studentDetails.firstName}',
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontSize: 14.sp,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Current Room: ${request.currentRoomNumber}'),
                    heightSpacer(8.0),
                    Text('Current Block: ${request.currentBlock}'),
                    heightSpacer(8.0),
                    SizedBox(
                      width: 160.w,
                      child: Text(
                        'Email Id: ${request.studentDetails.emailId}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    heightSpacer(8.0),
                    Text('Phone No.: ${request.studentDetails.phoneNumber}'),
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
                                  'Asked For :',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Block : ${request.toChangeBlock}",
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                    widthSpacer(20),
                                    Text(
                                      "Room No : ${request.toChangeRoomNumber}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            heightSpacer(12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reason :  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF333333),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                heightSpacer(12),
                                Text(
                                  request.changeReason,
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 40.h,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            apiCall.approveOrRejectRequest(
                              request.roomChangeRequestId,
                              'REJECTED',
                              'REJECTED',
                              context,
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            padding: const EdgeInsets.all(4),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFED6A77),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Reject',
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
                      ),
                      widthSpacer(32),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            apiCall.approveOrRejectRequest(
                              request.roomChangeRequestId,
                              'APPROVED',
                              'APPROVED',
                              context,
                            );
                          },
                          child: Container(
                            height: double.infinity,
                            padding: const EdgeInsets.all(4),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2ECC71),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Approve ',
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
