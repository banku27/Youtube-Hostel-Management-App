import 'dart:convert';

class StudentInfoModel {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  StudentInfoModel({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory StudentInfoModel.fromRawJson(String str) =>
      StudentInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) =>
      StudentInfoModel(
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
  StudentProfileData studentProfileData;
  List<StudentIssue> studentIssues;
  List<RoomChangeRequest> roomChangeRequests;
  RoomChargesModel roomChargesModel;

  Result({
    required this.studentProfileData,
    required this.studentIssues,
    required this.roomChangeRequests,
    required this.roomChargesModel,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        studentProfileData:
            StudentProfileData.fromJson(json["studentProfileData"]),
        studentIssues: List<StudentIssue>.from(
            json["studentIssues"].map((x) => StudentIssue.fromJson(x))),
        roomChangeRequests: List<RoomChangeRequest>.from(
            json["roomChangeRequests"]
                .map((x) => RoomChangeRequest.fromJson(x))),
        roomChargesModel: RoomChargesModel.fromJson(json["roomChargesModel"]),
      );

  Map<String, dynamic> toJson() => {
        "studentProfileData": studentProfileData.toJson(),
        "studentIssues":
            List<dynamic>.from(studentIssues.map((x) => x.toJson())),
        "roomChangeRequests":
            List<dynamic>.from(roomChangeRequests.map((x) => x.toJson())),
        "roomChargesModel": roomChargesModel.toJson(),
      };
}

class RoomChangeRequest {
  int currentRoomNumber;
  int toChangeRoomNumber;
  String currentBlock;
  String toChangeBlock;
  String changeReason;
  int roomChangeRequestId;
  String status;
  dynamic studentDetails;

  RoomChangeRequest({
    required this.currentRoomNumber,
    required this.toChangeRoomNumber,
    required this.currentBlock,
    required this.toChangeBlock,
    required this.changeReason,
    required this.roomChangeRequestId,
    required this.status,
    required this.studentDetails,
  });

  factory RoomChangeRequest.fromRawJson(String str) =>
      RoomChangeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomChangeRequest.fromJson(Map<String, dynamic> json) =>
      RoomChangeRequest(
        currentRoomNumber: json["currentRoomNumber"],
        toChangeRoomNumber: json["toChangeRoomNumber"],
        currentBlock: json["currentBlock"],
        toChangeBlock: json["toChangeBlock"],
        changeReason: json["changeReason"],
        roomChangeRequestId: json["roomChangeRequestId"],
        status: json["status"],
        studentDetails: json["studentDetails"],
      );

  Map<String, dynamic> toJson() => {
        "currentRoomNumber": currentRoomNumber,
        "toChangeRoomNumber": toChangeRoomNumber,
        "currentBlock": currentBlock,
        "toChangeBlock": toChangeBlock,
        "changeReason": changeReason,
        "roomChangeRequestId": roomChangeRequestId,
        "status": status,
        "studentDetails": studentDetails,
      };
}

class RoomChargesModel {
  double totalAmount;
  double roomAmount;
  double roomWaterCharges;
  double parkingCharges;
  double maintenanceCharges;

  RoomChargesModel({
    required this.totalAmount,
    required this.roomAmount,
    required this.roomWaterCharges,
    required this.parkingCharges,
    required this.maintenanceCharges,
  });

  factory RoomChargesModel.fromRawJson(String str) =>
      RoomChargesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomChargesModel.fromJson(Map<String, dynamic> json) =>
      RoomChargesModel(
        totalAmount: json["totalAmount"],
        roomAmount: json["roomAmount"],
        roomWaterCharges: json["roomWaterCharges"],
        parkingCharges: json["parkingCharges"],
        maintenanceCharges: json["maintenanceCharges"],
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount,
        "roomAmount": roomAmount,
        "roomWaterCharges": roomWaterCharges,
        "parkingCharges": parkingCharges,
        "maintenanceCharges": maintenanceCharges,
      };
}

class StudentIssue {
  int issueId;
  RoomDetails roomDetails;
  String issue;
  String studentComment;
  String studentEmailId;
  dynamic staffComment;
  String issueStatus;

  StudentIssue({
    required this.issueId,
    required this.roomDetails,
    required this.issue,
    required this.studentComment,
    required this.studentEmailId,
    required this.staffComment,
    required this.issueStatus,
  });

  factory StudentIssue.fromRawJson(String str) =>
      StudentIssue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentIssue.fromJson(Map<String, dynamic> json) => StudentIssue(
        issueId: json["issueId"],
        roomDetails: RoomDetails.fromJson(json["roomDetails"]),
        issue: json["issue"],
        studentComment: json["studentComment"],
        studentEmailId: json["studentEmailId"],
        staffComment: json["staffComment"],
        issueStatus: json["issueStatus"],
      );

  Map<String, dynamic> toJson() => {
        "issueId": issueId,
        "roomDetails": roomDetails.toJson(),
        "issue": issue,
        "studentComment": studentComment,
        "studentEmailId": studentEmailId,
        "staffComment": staffComment,
        "issueStatus": issueStatus,
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
  double roomAmount;
  double roomMaintenanceAmount;
  double roomWaterCharge;
  double parkingCharges;

  RoomType({
    required this.roomId,
    required this.roomType,
    required this.roomAmount,
    required this.roomMaintenanceAmount,
    required this.roomWaterCharge,
    required this.parkingCharges,
  });

  factory RoomType.fromRawJson(String str) =>
      RoomType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomType.fromJson(Map<String, dynamic> json) => RoomType(
        roomId: json["roomId"],
        roomType: json["roomType"],
        roomAmount: json["roomAmount"],
        roomMaintenanceAmount: json["roomMaintenanceAmount"],
        roomWaterCharge: json["roomWaterCharge"],
        parkingCharges: json["parkingCharges"],
      );

  Map<String, dynamic> toJson() => {
        "roomId": roomId,
        "roomType": roomType,
        "roomAmount": roomAmount,
        "roomMaintenanceAmount": roomMaintenanceAmount,
        "roomWaterCharge": roomWaterCharge,
        "parkingCharges": parkingCharges,
      };
}

class StudentProfileData {
  String userName;
  String emailId;
  RoleId roleId;
  String firstName;
  String lastName;
  int phoneNumber;
  int roomNumber;
  String block;

  StudentProfileData({
    required this.userName,
    required this.emailId,
    required this.roleId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.roomNumber,
    required this.block,
  });

  factory StudentProfileData.fromRawJson(String str) =>
      StudentProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentProfileData.fromJson(Map<String, dynamic> json) =>
      StudentProfileData(
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
        "roleId": roleId.toJson(),
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
