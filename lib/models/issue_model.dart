import 'dart:convert';

class IssueModel {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  IssueModel({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory IssueModel.fromRawJson(String str) =>
      IssueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IssueModel.fromJson(Map<String, dynamic> json) => IssueModel(
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
  int issueId;
  RoomDetails roomDetails;
  String issue;
  String studentComment;
  String studentEmailId;
  dynamic staffComment;
  StudentDetails studentDetails;

  Result({
    required this.issueId,
    required this.roomDetails,
    required this.issue,
    required this.studentComment,
    required this.studentEmailId,
    required this.staffComment,
    required this.studentDetails,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        issueId: json["issueId"],
        roomDetails: RoomDetails.fromJson(json["roomDetails"]),
        issue: json["issue"],
        studentComment: json["studentComment"],
        studentEmailId: json["studentEmailId"],
        staffComment: json["staffComment"],
        studentDetails: StudentDetails.fromJson(json["studentDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "issueId": issueId,
        "roomDetails": roomDetails.toJson(),
        "issue": issue,
        "studentComment": studentComment,
        "studentEmailId": studentEmailId,
        "staffComment": staffComment,
        "studentDetails": studentDetails.toJson(),
      };
}

class RoomDetails {
  int roomNumber;
  int roomCapacity;
  int roomCurrentCapacity;
  RoomType roomType;
  dynamic roomStatus;
  BlockId blockId;

  RoomDetails({
    required this.roomNumber,
    required this.roomCapacity,
    required this.roomCurrentCapacity,
    required this.roomType,
    required this.roomStatus,
    required this.blockId,
  });

  factory RoomDetails.fromRawJson(String str) =>
      RoomDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomDetails.fromJson(Map<String, dynamic> json) => RoomDetails(
        roomNumber: json["roomNumber"],
        roomCapacity: json["roomCapacity"],
        roomCurrentCapacity: json["roomCurrentCapacity"],
        roomType: RoomType.fromJson(json["roomType"]),
        roomStatus: json["roomStatus"],
        blockId: BlockId.fromJson(json["blockId"]),
      );

  Map<String, dynamic> toJson() => {
        "roomNumber": roomNumber,
        "roomCapacity": roomCapacity,
        "roomCurrentCapacity": roomCurrentCapacity,
        "roomType": roomType.toJson(),
        "roomStatus": roomStatus,
        "blockId": blockId.toJson(),
      };
}

class BlockId {
  int blockId;
  String block;
  String blockName;
  String blockOwner;

  BlockId({
    required this.blockId,
    required this.block,
    required this.blockName,
    required this.blockOwner,
  });

  factory BlockId.fromRawJson(String str) => BlockId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlockId.fromJson(Map<String, dynamic> json) => BlockId(
        blockId: json["blockId"],
        block: json["block"],
        blockName: json["blockName"],
        blockOwner: json["blockOwner"],
      );

  Map<String, dynamic> toJson() => {
        "blockId": blockId,
        "block": block,
        "blockName": blockName,
        "blockOwner": blockOwner,
      };
}

class RoomType {
  int roomId;
  String roomType;

  RoomType({
    required this.roomId,
    required this.roomType,
  });

  factory RoomType.fromRawJson(String str) =>
      RoomType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
        roomId: json["roomId"],
        roomType: json["roomType"],
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "roomType": roomType,
      };
}

class StudentDetails {
  String userName;
  String emailId;
  dynamic password;
  int roleId;
  String firstName;
  String lastName;
  int phoneNumber;
  dynamic jobRole;

  StudentDetails({
    required this.userName,
    required this.emailId,
    required this.password,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.jobRole,
  });

  factory StudentDetails.fromRawJson(String str) =>
      StudentDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
        userName: json["userName"],
        emailId: json["emailId"],
        password: json["password"],
        roleId: json["roleId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        jobRole: json["jobRole"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "emailId": emailId,
        "password": password,
        "roleId": roleId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "jobRole": jobRole,
      };
}
