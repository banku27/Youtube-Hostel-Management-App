import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/features/auth/screens/login_screen.dart';
import 'package:hostel_management/features/home/screens/home_screen.dart';
import 'package:hostel_management/models/user_response.dart';
import 'package:hostel_management/theme/colors.dart';
import 'package:provider/provider.dart';

class ApiCall {
  Future<void> handleLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    final Map<String, dynamic> requestData = {
      "emailId": email,
      "password": password,
    };

    final response = await apiProvider.postRequest(
      ApiUrls.login,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
      includeBearerToken: false,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['status'] == 'FAILED') {
        print('heyyeyyy');
        ApiUtils.showErrorSnackBar(context, responseBody['error']);
      }
      final UserResponse userResponse = UserResponse.fromJson(responseBody);

      print("User ID: ${userResponse.result[0].emailId}");

      ApiUrls.email = userResponse.result[0].emailId!;
      ApiUrls.phoneNumber = userResponse.result[0].phoneNumber!.toString();
      ApiUrls.roomNumber = userResponse.result[0].roomNumber!.toString();
      ApiUrls.username = userResponse.result[0].userName;
      ApiUrls.blockNumber = userResponse.result[0].block!;
      ApiUrls.firstName = userResponse.result[0].firstName!;
      ApiUrls.lastName = userResponse.result[0].lastName!;
      ApiUrls.roleId = userResponse.result[0].roleId!.roleId;

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      final Map<String, dynamic> errorResponse = json.decode(response.body);
      final String errorMessage = errorResponse['msg'];
      print("Error message: $errorMessage");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.kGreenColor,
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<String?> registerStudent(
    String username,
    String firstName,
    String lastName,
    String password,
    String email,
    String phoneNumber,
    String block,
    String roomNumber,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "userName": username,
      "emailId": email,
      "password": password,
      "roleId": 2,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "roomNumber": roomNumber,
      "block": block
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.register,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['status'] == "Student created successfully") {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        // return responseBody['msg'];
      }
    }
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['status'] == "Student Already Exists") {
        ApiUtils.showSucessSnackBar(context, responseBody['status']);

        // return responseBody['msg'];
      }
    }

    return null;
  }

  Future<String?> createStaff(
    String username,
    String firstName,
    String lastName,
    String password,
    String email,
    String phoneNumber,
    String jobRole,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "userName": username,
      "emailId": email,
      "password": password,
      "roleId": 3,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "jobRole": jobRole
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.createStaff,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            CupertinoPageRoute(builder: (context) => const HomeScreen()));
        // return responseBody['msg'];
      }
    }
    return null;
  }

  Future<String?> roomChangeRequest(
    String changeRoomNumber,
    String changeBlockNumber,
    String reason,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "currentRoomNumber": ApiUrls.roomNumber,
      "toChangeRoomNumber": changeRoomNumber,
      "currentBlock": ApiUrls.blockNumber,
      "toChangeBlock": changeBlockNumber,
      "studentEmailId": ApiUrls.email,
      "changeReason": reason,
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.changeRoomRequest,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
    return null;
  }

  void updateProfile(
    BuildContext context,
    String userName,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final Map<String, dynamic> requestData = {
      "userName": userName,
      "emailId": ApiUrls.email,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    };

    try {
      final response = await apiProvider.putRequest(
        ApiUrls.updateProfile,
        headers: {
          "Content-Type": "application/json",
        },
        body: requestData,
        // includeBearerToken: true,
      );
      if (response.statusCode == 202) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        print(responseBody);
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, 'Profile Updated Successfully');
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final String errorMessage = errorResponse['msg'];
        print("Error message: $errorMessage");
        // ignore: use_build_context_synchronously
        ApiUtils.showErrorSnackBar(context, errorMessage);
      }
    } catch (e) {
      ApiUtils.showErrorSnackBar(context, e.toString());
    }
  }

  Future<String?> createAnIssue(
    String roomNumber,
    String block,
    String issue,
    String comment,
    String email,
    String phoneNumber,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "roomNumber": roomNumber,
      "block": block,
      "issue": issue,
      "studentComment": comment,
      "studentEmailId": email
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.createIssue,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        // return responseBody['msg'];
      }
    }
    return null;
  }

  Future<String?> closeAnIssue(
    int issueId,
    String staffComment,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "issueId": issueId,
      "staffComment": 'Resolved',
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.closeIssue,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

        // return responseBody['msg'];
      }
    }
    return null;
  }

  Future<String?> approveOrRejectRequest(
    int requestId,
    String adminComment,
    String action,
    BuildContext context,
  ) async {
    final Map<String, dynamic> requestData = {
      "roomChangeRequestId": requestId,
      "approveOrReject": action,
      "adminComment": adminComment,
    };
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    final response = await apiProvider.postRequest(
      ApiUrls.closeRoomRequest,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestData,
    );
    print(response.body);
    print(requestData);
    if (response.statusCode == 202) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['statusCode'] == 200) {
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(context, responseBody['status']);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

        // return responseBody['msg'];
      }
    }
    return null;
  }

  void deleteStaff(
    BuildContext context,
    String emailId,
  ) async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    try {
      final response = await apiProvider.deleteRequest(
        '${ApiUrls.deleteStaff}/$emailId',
        headers: {
          "Content-Type": "application/json",
        },
        includeBearerToken: true,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        // ignore: use_build_context_synchronously
        ApiUtils.showSucessSnackBar(
          context,
          responseBody['status'],
        );
      } else {
        final Map<String, dynamic> errorResponse = json.decode(response.body);
        final String errorMessage = errorResponse['msg'];
        print("Error message: $errorMessage");
        ApiUtils.showErrorSnackBar(context, errorMessage);
      }
    } catch (e) {
      ApiUtils.showErrorSnackBar(context, e.toString());
    }
  }
}
