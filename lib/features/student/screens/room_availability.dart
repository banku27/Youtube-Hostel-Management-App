import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/student/screens/change_room_screen.dart';
import 'package:hostel_management/models/room_availability_model.dart';
import 'package:provider/provider.dart';

class RoomAvailabilityScreen extends StatefulWidget {
  const RoomAvailabilityScreen({super.key});

  @override
  State<RoomAvailabilityScreen> createState() => _RoomAvailabilityScreenState();
}

class _RoomAvailabilityScreenState extends State<RoomAvailabilityScreen> {
  RoomAvailability? roomAvailabile;

  Future<void> fetchData() async {
    try {
      final apiProvider = Provider.of<ApiProvider>(context, listen: false);
      final roomAvailability =
          await apiProvider.getRequest(ApiUrls.roomAvailability);

      if (roomAvailability.statusCode == 200) {
        final Map<String, dynamic> room = json.decode(roomAvailability.body);
        print(roomAvailability.body);

        roomAvailabile = RoomAvailability.fromJson(room);
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
      appBar: buildAppBar(context, 'Room Availabilities'),
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return roomAvailabile == null
                ? const Center(
                    child: Text(
                      "No Availability",
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: roomAvailabile!.result.length,
                      itemBuilder: (context, index) {
                        final room = roomAvailabile!.result[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: RoomCard(room: room),
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

class RoomCard extends StatelessWidget {
  final Result room;

  const RoomCard({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFF007B3B)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
            bottomLeft: Radius.circular(30.r),
          ),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x4C007B3B),
            blurRadius: 8,
            offset: Offset(1, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Image.asset(
                AppConstants.bed,
                height: 70.h,
                width: 70.w,
              ),
              Text(
                'Room no. - ${room.roomNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          widthSpacer(15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block ${room.blockId.block}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                'Capacity: ${room.roomCapacity}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              Text(
                'Current Capacity: ${room.roomCurrentCapacity}',
                style: TextStyle(
                  color: const Color(0xFF333333),
                  fontSize: 16.sp,
                ),
              ),
              heightSpacer(5),
              if (room.roomType != null)
                Text(
                  'Type: ${room.roomType!.roomType}',
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 16.sp,
                  ),
                ),
              heightSpacer(5),
              Row(
                children: [
                  Text(
                    'Status: ',
                    style: TextStyle(
                      color: const Color(0xFF333333),
                      fontSize: 16.sp,
                    ),
                  ),
                  Container(
                    height: 30.h,
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    decoration: ShapeDecoration(
                      color: room.roomCurrentCapacity == 5
                          ? Colors.amber
                          : const Color(0xFF2ECC71),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 8,
                          offset: Offset(1, 3),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: room.roomCurrentCapacity == 5
                        ? Text(
                            'Unavailable',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) =>
                                      const ChangeRoomScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Available',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
