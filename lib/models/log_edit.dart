import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'log_edit.g.dart';

@JsonSerializable()
class LogEdit {
  // driver_id: int = 0

  int id;
  int duration;
  int distance;
  String notes;

  @JsonKey(defaultValue: 'NYC Trucking')
  final String createdBy;

  @JsonKey(name: 'log_id')
  final int logId;

  @JsonKey(name: 'start_datetime')
  final DateTime startDatetime;

  @JsonKey(name: 'start_odometer')
  final double startOdometer;

  @JsonKey(name: 'start_engine_hours')
  final double startEngineHours;

  @JsonKey(name: 'from_address')
  final String fromAddress;

  @JsonKey(name: 'to_address')
  final String toAddress;

  @JsonKey(name: 'unit_id')
  final int unitId;

  @JsonKey(name: 'vehicle_id')
  final int vehicleId;

  @JsonKey(name: 'organizationId')
  final int organizationId;

  @JsonKey(name: 'current_address')
  final String currentAddress;

  @JsonKey(name: 'current_lon')
  final double currentLon;

  @JsonKey(name: 'current_lat')
  final double currentLat;

  @JsonKey(name: 'time_minute')
  final int timeMinute;

  @JsonKey(name: 'event_status')
  final String eventStatus;

  @JsonKey(name: 'edited_datetime')
  final DateTime dateCreated;

  @JsonKey(name: 'edited_status_code')
  final int editedStatusCode;

  @JsonKey(name: 'edited_status_desc')
  final String editedStatusDesc;

  LogEdit(
    this.id,
    this.duration,
    this.distance,
    this.notes,
    this.createdBy,
    this.logId,
    this.startDatetime,
    this.startOdometer,
    this.startEngineHours,
    this.fromAddress,
    this.toAddress,
    this.unitId,
    this.vehicleId,
    this.organizationId,
    this.currentAddress,
    this.currentLon,
    this.currentLat,
    this.timeMinute,
    this.eventStatus,
    this.dateCreated,
    this.editedStatusCode,
    this.editedStatusDesc,
  );

  factory LogEdit.fromJson(Map<String, dynamic> json) =>
      _$LogEditFromJson(json);

  Map<String, dynamic> toJson() => _$LogEditToJson(this);
}
