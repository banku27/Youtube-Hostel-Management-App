import 'dart:convert';

class StaffInfoModel {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  StaffInfoModel({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory StaffInfoModel.fromRawJson(String str) =>
      StaffInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StaffInfoModel.fromJson(Map<String, dynamic> json) => StaffInfoModel(
        status: json["status"],
        statusCode: json["statusCode"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "error": error,
      };
}

class Result {
  String userName;
  String firstName;
  String lastName;
  String emailId;
  int phoneNumber;
  dynamic password;
  RoleId roleId;
  String? jobRole;

  Result({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.emailId,
    required this.phoneNumber,
    required this.password,
    required this.roleId,
    required this.jobRole,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userName: json["userName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailId: json["emailId"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        roleId: RoleId.fromJson(json["roleId"]),
        jobRole: json["jobRole"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "emailId": emailId,
        "phoneNumber": phoneNumber,
        "password": password,
        "roleId": roleId.toJson(),
        "jobRole": jobRole,
      };
}

class RoleId {
  int roleId;
  String role;

  RoleId({
    required this.roleId,
    required this.role,
  });

  factory RoleId.fromRawJson(String str) => RoleId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoleId.fromJson(Map<String, dynamic> json) => RoleId(
        roleId: json["roleId"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "role": role,
      };
}
