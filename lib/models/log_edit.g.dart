// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_edit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogEdit _$LogEditFromJson(Map<String, dynamic> json) {
  return LogEdit(
    json['id'] as int,
    json['duration'] as int,
    json['distance'] as int,
    json['notes'] as String,
    json['createdBy'] as String ?? 'NYC Trucking',
    json['log_id'] as int,
    json['start_datetime'] == null
        ? null
        : DateTime.parse(json['start_datetime'] as String),
    (json['start_odometer'] as num)?.toDouble(),
    (json['start_engine_hours'] as num)?.toDouble(),
    json['from_address'] as String,
    json['to_address'] as String,
    json['unit_id'] as int,
    json['vehicle_id'] as int,
    json['organizationId'] as int,
    json['current_address'] as String,
    (json['current_lon'] as num)?.toDouble(),
    (json['current_lat'] as num)?.toDouble(),
    json['time_minute'] as int,
    json['event_status'] as String,
    json['edited_datetime'] == null
        ? null
        : DateTime.parse(json['edited_datetime'] as String),
    json['edited_status_code'] as int,
    json['edited_status_desc'] as String,
  );
}

Map<String, dynamic> _$LogEditToJson(LogEdit instance) => <String, dynamic>{
      'id': instance.id,
      'duration': instance.duration,
      'distance': instance.distance,
      'notes': instance.notes,
      'createdBy': instance.createdBy,
      'log_id': instance.logId,
      'start_datetime': instance.startDatetime?.toIso8601String(),
      'start_odometer': instance.startOdometer,
      'start_engine_hours': instance.startEngineHours,
      'from_address': instance.fromAddress,
      'to_address': instance.toAddress,
      'unit_id': instance.unitId,
      'vehicle_id': instance.vehicleId,
      'organizationId': instance.organizationId,
      'current_address': instance.currentAddress,
      'current_lon': instance.currentLon,
      'current_lat': instance.currentLat,
      'time_minute': instance.timeMinute,
      'event_status': instance.eventStatus,
      'edited_datetime': instance.dateCreated?.toIso8601String(),
      'edited_status_code': instance.editedStatusCode,
      'edited_status_desc': instance.editedStatusDesc,
    };
