class AttendanceSubmitRequestWrapper {
  final String idToko;
  final String latitude;
  final String longitude;
  final String idUser;
  final String token;
  final List<PhotoAttachment> photos;

  AttendanceSubmitRequestWrapper({
    required this.idToko,
    required this.latitude,
    required this.longitude,
    required this.idUser,
    required this.token,
    required this.photos,
  });

  Map<String, dynamic> toJson() => {
        'idToko': idToko,
        'latitude': latitude,
        'longitude': longitude,
        'idUser': idUser,
        'token': token,
        'photos': photos.map((e) => e.toJson()).toList(),
      };

  factory AttendanceSubmitRequestWrapper.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequestWrapper(
        idToko: json['idToko'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        idUser: json['idUser'],
        token: json['token'],
        photos: (json['photos'] as List)
            .map((e) => PhotoAttachment.fromJson(e))
            .toList(),
      );
}

class PhotoAttachment {
  final String photoBase64;
  final String filename;

  PhotoAttachment({required this.photoBase64, required this.filename});

  Map<String, dynamic> toJson() => {
        'photoBase64': photoBase64,
        'filename': filename,
      };

  factory PhotoAttachment.fromJson(Map<String, dynamic> json) =>
      PhotoAttachment(
        photoBase64: json['photoBase64'],
        filename: json['filename'],
      );
}
