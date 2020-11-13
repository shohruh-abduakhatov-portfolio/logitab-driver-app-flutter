class DutyStatus {
  int id;
  int status;
  String location;
  String remarks;
  DateTime date;
  DateTime start;
  DateTime end;

  DutyStatus({
    this.id,
    this.status,
    this.location,
    this.remarks,
    this.date,
    this.start,
    this.end,
  });

  @override
  String toString() {
    return 'Duty status id: $id, status: $status';
  }

  static parseJson(Map map) {
    return;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
    };
    return map;
  }

  DutyStatus.fromMap(Map<String, dynamic> map) {
    id = map[id];
  }
}
