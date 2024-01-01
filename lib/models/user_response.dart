import 'dart:convert';

class UserResponse {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  UserResponse({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
  String? emailId;
  RoleId? roleId;
  String? firstName;
  String? lastName;
  int? phoneNumber;
  int? roomNumber;
  String? block;

  Result({
    required this.userName,
    required this.emailId,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.roomNumber,
    required this.block,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        userName: json["userName"],
        emailId: json["emailId"],
        roleId: RoleId.fromJson(json["roleId"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        roomNumber: json["roomNumber"],
        block: json["block"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "emailId": emailId,
        "roleId": roleId!.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "roomNumber": roomNumber,
        "block": block,
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
