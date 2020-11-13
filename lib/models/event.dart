class LogEvent {
  int id;
  // id = fields.Int(required=False)
  // log_id = fields.Int(required=False)
  // driver_id = fields.Int(required=True)
  // vehicle_id = fields.Int(required=True)
  // unit_id = fields.Int(required=True)
  // start_datetime = fields.DateTime(required=True)
  // duration = fields.Int()
  // from_address = fields.Str()
  // to_address = fields.Str()
  // distance = fields.Float()
  // start_odometer = fields.Float()
  // start_engine_hours = fields.Float()
  // notes = fields.Str(required=False)
  // current_lon = fields.Float()
  // current_lat = fields.Float()
  // current_address = fields.Str()
  // event_status = fields.Str(required=True)
  // time_minute = fields.Int()
  LogEvent([this.id]);
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    return map;
  }
}
