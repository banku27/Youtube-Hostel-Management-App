import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget heightSpacer(double height) {
  return SizedBox(
    height: height.h,
  );
}

Widget widthSpacer(double width) {
  return SizedBox(
    width: width.w,
  );
}
