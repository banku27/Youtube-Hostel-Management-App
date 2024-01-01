import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_calls.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/spacing.dart';
import 'package:hostel_management/features/auth/widgets/custom_button.dart';
import 'package:hostel_management/features/auth/widgets/custom_text_field.dart';

class ChangeRoomScreen extends StatefulWidget {
  const ChangeRoomScreen({super.key});

  @override
  State<ChangeRoomScreen> createState() => _ChangeRoomScreenState();
}

class _ChangeRoomScreenState extends State<ChangeRoomScreen> {
  ApiCall apiCall = ApiCall();
  String? selectedBlock;
  String? selectedRoom;
  TextEditingController reason = TextEditingController();
  List<String> blockOptions = ['A', 'B'];
  List<String> roomOptionsA = ['101', '102', '103'];
  List<String> roomOptionsB = ['201', '202', '203'];

  @override
  void dispose() {
    super.dispose();
    reason.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'Change Room'),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpacer(20),
                  Text(
                    'Current block and Room no.',
                    style: TextStyle(
                      color: const Color(0xFF464646),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  heightSpacer(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF2E8B57)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Room No - ${ApiUrls.roomNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                      widthSpacer(30),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF2E8B57)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            'Block No - ${ApiUrls.blockNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF333333),
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSpacer(20),
                  Text(
                    'Shift to block and Room no.',
                    style: TextStyle(
                      color: const Color(0xFF464646),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  heightSpacer(10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF2E8B57)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: DropdownButton<String>(
                            // elevation: 0,
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: selectedBlock,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedBlock = newValue;
                                selectedRoom = null;
                              });
                            },
                            items: blockOptions.map((String block) {
                              return DropdownMenuItem<String>(
                                value: block,
                                child: Text(block),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      widthSpacer(20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          width: double.maxFinite,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFF2E8B57)),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: DropdownButton<String>(
                            // elevation: 0,
                            underline: const SizedBox(),
                            isExpanded: true,
                            value: selectedRoom,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedRoom = newValue;
                              });
                            },
                            items: (selectedBlock == 'A'
                                    ? roomOptionsA
                                    : roomOptionsB)
                                .map((String room) {
                              return DropdownMenuItem<String>(
                                value: room,
                                child: Text(room),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heightSpacer(20),
                  Text(
                    'Reason for change',
                    style: TextStyle(
                      color: const Color(0xFF464646),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  heightSpacer(10),
                  CustomTextField(
                    controller: reason,
                    inputHint: 'Write your reason',
                  ),
                  heightSpacer(40),
                  CustomButton(
                    press: () {
                      apiCall.roomChangeRequest(
                        selectedRoom!,
                        selectedBlock!,
                        reason.text,
                        context,
                      );
                    },
                    buttonText: 'Submit',
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
