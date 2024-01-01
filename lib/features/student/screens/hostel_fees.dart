import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/common/app_bar.dart';
import 'package:hostel_management/common/constants.dart';
import 'package:hostel_management/common/spacing.dart';

class HostelFee extends StatelessWidget {
  String blockNumber;
  String roomNumber;
  String maintenanceCharge;
  String parkingCharge;
  String waterCharge;
  String roomCharge;
  String totalCharge;
  HostelFee({
    Key? key,
    required this.blockNumber,
    required this.roomNumber,
    required this.maintenanceCharge,
    required this.parkingCharge,
    required this.waterCharge,
    required this.roomCharge,
    required this.totalCharge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'Hostel Fees',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightSpacer(20),
              SvgPicture.asset(
                AppConstants.hostel,
                height: 200.h,
              ),
              heightSpacer(40),
              Container(
                width: double.maxFinite,
                decoration: ShapeDecoration(
                  color: const Color(0x4C2E8B57),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF2E8B57),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x332E8B57),
                      blurRadius: 8,
                      offset: Offset(1, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpacer(20),
                      Text(
                        'Hostel details',
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Block no.',
                                style: TextStyle(
                                  color: const Color(0xFF464646),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '- $blockNumber',
                                style: const TextStyle(
                                  color: Color(0xFF464646),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Room no.',
                                style: TextStyle(
                                  color: const Color(0xFF464646),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                '- $roomNumber',
                                style: const TextStyle(
                                  color: Color(0xFF464646),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      const Text(
                        'Payment details ',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Maintenance charge - ',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ $maintenanceCharge',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Parking charge - ',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ $parkingCharge',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Room water charge - ',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ $waterCharge',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Room charge - ',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ $roomCharge',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(20),
                      const Divider(
                        color: Colors.black,
                      ),
                      heightSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount - ',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$ $totalCharge',
                            style: TextStyle(
                              color: const Color(0xFF464646),
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      heightSpacer(30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
