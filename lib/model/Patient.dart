class Patient {
  String id;
  String fullname;

  Patient({this.id = "", this.fullname = ""});

  String Info() {
    return 'id : $id' ' fullname : $fullname';
  }

  factory Patient.fromJson(Map<String, dynamic> parsedJson) {
    return Patient(
        id: parsedJson['id'] ?? '', fullname: parsedJson['fullname'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
    };
  }
}
