import 'package:json_annotation/json_annotation.dart';

part 'vehicle.g.dart';

@JsonSerializable()
class Vehicle {
  int id;
  int status;
  String make;
  String model;
  String vin;
  String notes;
  String telematics;
  DateTime datetime;

  @JsonKey(name: 'license_plate_no')
  final String licensePlateNo;

  @JsonKey(name: 'vehicle_id')
  final String vehicleId;

  @JsonKey(name: 'serial_no')
  final String serialNo;

  @JsonKey(name: 'device_version')
  final String deviceVersion;

  @JsonKey(name: 'enter_vin_manually')
  final bool enterVinManually;

  @JsonKey(name: 'eld_id')
  final int eldId;

  @JsonKey(name: 'fuel_type_id')
  final int fuelTypeId;

  @JsonKey(name: 'plate_issue_state_id')
  final int plateIssueStateId;

  @JsonKey(name: 'organization_id')
  final int organizationId;

  @JsonKey(name: 'driver_id')
  final int driverId;

  // fuel_type = {}
  // plate_issue_state = {}
  // eld = {}

  Vehicle(
      this.id,
      this.status,
      this.make,
      this.model,
      this.vin,
      this.notes,
      this.telematics,
      this.datetime,
      this.licensePlateNo,
      this.vehicleId,
      this.serialNo,
      this.deviceVersion,
      this.enterVinManually,
      this.eldId,
      this.fuelTypeId,
      this.plateIssueStateId,
      this.organizationId,
      this.driverId);

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
