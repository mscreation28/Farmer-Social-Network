import 'package:intl/intl.dart';

class UserCrop {
  int userCropId;
  int userId;
  int cropId;
  DateTime cropDate = new DateTime.now();
  String cropCity;
  String cropState;
  String croptaluka;
  String breed;
  double area;
  String cropName;

  UserCrop({
    this.userCropId,
    this.cropState,
    this.breed,
    this.area,
    this.cropCity,
    this.cropDate,
    this.croptaluka,
    this.cropId,
    this.userId,
    this.cropName
  });

  factory UserCrop.fromJson(Map<String, dynamic> json) {
    return UserCrop(
        userCropId: json['userCropId'],
        cropState: json['cropState'],
        area: double.parse(json['area']),
        breed: json['breed'],
        cropCity: json['cropCity'],
        croptaluka: json['croptaluka'],
        cropDate: DateFormat('yyyy-M-d').parse((json['cropDate'])),
        cropId: json['cropId'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      "userCropId": userCropId,
      "cropState": cropState,
      "cropCity": cropCity,
      "croptaluka": croptaluka,
      "area": area,
      "breed": breed,
      "userId": userId,
      "cropId": cropId,
      "cropDate":cropDate.toIso8601String()
    };
  }
}
