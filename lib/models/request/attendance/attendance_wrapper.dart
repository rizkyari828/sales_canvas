class AttendanceSubmitRequestWrapper {
  final String idToko;
  final String latitude;
  final String longitude;
  final String idUser;
  final String token;
  final String photoBase64;
  final String filename;

  AttendanceSubmitRequestWrapper({
    required this.idToko,
    required this.latitude,
    required this.longitude,
    required this.idUser,
    required this.token,
    required this.photoBase64,
    required this.filename,
  });

  factory AttendanceSubmitRequestWrapper.fromJson(Map<String, dynamic> json) {
    return AttendanceSubmitRequestWrapper(
      idToko: json['idToko'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      idUser: json['idUser'],
      token: json['token'],
      photoBase64: json['photoBase64'],
      filename: json['filename'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idToko': idToko,
      'latitude': latitude,
      'longitude': longitude,
      'idUser': idUser,
      'token': token,
      'photoBase64': photoBase64,
      'filename': filename,
    };
  }
}
