// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) {
  return Vehicle(
    json['id'] as int,
    json['status'] as int,
    json['make'] as String,
    json['model'] as String,
    json['vin'] as String,
    json['notes'] as String,
    json['telematics'] as String,
    json['datetime'] == null
        ? null
        : DateTime.parse(json['datetime'] as String),
    json['license_plate_no'] as String,
    json['vehicle_id'] as String,
    json['serial_no'] as String,
    json['device_version'] as String,
    json['enter_vin_manually'] as bool,
    json['eld_id'] as int,
    json['fuel_type_id'] as int,
    json['plate_issue_state_id'] as int,
    json['organization_id'] as int,
    json['driver_id'] as int,
  );
}

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'make': instance.make,
      'model': instance.model,
      'vin': instance.vin,
      'notes': instance.notes,
      'telematics': instance.telematics,
      'datetime': instance.datetime?.toIso8601String(),
      'license_plate_no': instance.licensePlateNo,
      'vehicle_id': instance.vehicleId,
      'serial_no': instance.serialNo,
      'device_version': instance.deviceVersion,
      'enter_vin_manually': instance.enterVinManually,
      'eld_id': instance.eldId,
      'fuel_type_id': instance.fuelTypeId,
      'plate_issue_state_id': instance.plateIssueStateId,
      'organization_id': instance.organizationId,
      'driver_id': instance.driverId,
    };
