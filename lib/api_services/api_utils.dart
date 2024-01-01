import 'package:flutter/material.dart';

class ApiUrls {
  static const String baseUrl = 'https://unt-house-management.onrender.com/unt';

  static const String login = '/student/login';
  static const String register = '/student/saveStudent';
  static const String createIssue = '/maintenance/createIssue';
  static const String roomAvailability = '/room/getRooms/AVAILABLE';
  static const String studentDetails =
      '/student/getStudentDetails?studentEmailId=';
  static const String createStaff = '/admin/create/staff';
  static const String allStaff = '/admin/fetch/allStaff';
  static const String deleteStaff = '/admin/delete/staff';
  static const String allIssues = '/maintenance/fetch/issue/open';
  static const String roomChangeRequests = '/room/fetch/roomChange/requests';
  static const String fetchPieChartData = '/admin/getChartDetails';
  static const String closeIssue = '/maintenance/close/issue';
  static const String closeRoomRequest = '/admin/approveOrReject';
  static const String changeRoomRequest = '/room/change/request';
  static const String updateProfile = '/student/updateStudent';

  static String email = '';
  static String roomNumber = '';
  static String blockNumber = '';
  static String username = '';
  static String firstName = '';
  static String lastName = '';
  static String phoneNumber = '';
  static int? roleId;
}

class ApiUtils {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      ),
    );
  }

  static void showSucessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
