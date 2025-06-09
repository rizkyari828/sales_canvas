class AttendanceSubmitRequestWrapper {
  final String idToko;
  final String latitude;
  final String longitude;
  final String idUser;
  final String token;
  final List<PhotoAttachment> photos;
  final String? date;

  AttendanceSubmitRequestWrapper({
    required this.idToko,
    required this.latitude,
    required this.longitude,
    required this.idUser,
    required this.token,
    required this.photos,
    this.date,
  });

  Map<String, dynamic> toJson({String? date}) => {
        'id_toko': idToko,
        'lat': latitude,
        'long': longitude,
        'id_user': idUser,
        'token': token,
        'foto': photos.map((e) => e.toJson()).toList(),
        'date': date ?? this.date,
      };

  factory AttendanceSubmitRequestWrapper.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequestWrapper(
        idToko: json['id_toko']?.toString() ?? '',
        latitude: json['lat']?.toString() ?? '',
        longitude: json['long']?.toString() ?? '',
        idUser: json['id_user']?.toString() ?? '',
        token: json['token']?.toString() ?? '',
        photos: (json['foto'] as List? ?? [])
            .map((e) => PhotoAttachment.fromJson(e))
            .toList(),
        date: json['date']?.toString(),
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
        img: json['img']?.toString() ?? '',
        filename: json['filename']?.toString() ?? '',
      );
}
