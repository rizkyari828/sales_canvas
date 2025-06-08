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
        'foto': photos.map((e) => e.toJson()).toList(),
      };

  factory AttendanceSubmitRequestWrapper.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequestWrapper(
        idToko: json['idToko'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        idUser: json['idUser'],
        token: json['token'],
        photos: (json['foto'] as List)
            .map((e) => PhotoAttachment.fromJson(e))
            .toList(),
      );
}

class PhotoAttachment {
  final String img;
  final String filename;

  PhotoAttachment({required this.img, required this.filename});

  Map<String, dynamic> toJson() => {
        'img': img,
        'filename': filename,
      };

  factory PhotoAttachment.fromJson(Map<String, dynamic> json) =>
      PhotoAttachment(
        img: json['img'],
        filename: json['filename'],
      );
}
