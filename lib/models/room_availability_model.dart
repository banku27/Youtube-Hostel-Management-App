import 'dart:convert';

class RoomAvailability {
  String status;
  int statusCode;
  List<Result> result;
  dynamic error;

  RoomAvailability({
    required this.status,
    required this.statusCode,
    required this.result,
    required this.error,
  });

  factory RoomAvailability.fromRawJson(String str) =>
      RoomAvailability.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoomAvailability.fromJson(Map<String, dynamic> json) =>
      RoomAvailability(
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
  int roomNumber;
  int roomCapacity;
  int roomCurrentCapacity;
  RoomType? roomType;
  String roomStatus;
  BlockId blockId;

  Result({
    required this.roomNumber,
    required this.roomCapacity,
    required this.roomCurrentCapacity,
    required this.roomType,
    required this.roomStatus,
    required this.blockId,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        roomNumber: json["roomNumber"],
        roomCapacity: json["roomCapacity"],
        roomCurrentCapacity: json["roomCurrentCapacity"],
        roomType: json["roomType"] == null
            ? null
            : RoomType.fromJson(json["roomType"]),
        roomStatus: json["roomStatus"],
        blockId: BlockId.fromJson(json["blockId"]),
      );

  Map<String, dynamic> toJson() => {
        "roomNumber": roomNumber,
        "roomCapacity": roomCapacity,
        "roomCurrentCapacity": roomCurrentCapacity,
        "roomType": roomType?.toJson(),
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
