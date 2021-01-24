class Crop{
  final int cropId;
  final String cropName;

  Crop({this.cropId, this.cropName,});

  factory Crop.fromJson(Map<String, dynamic> json){
    return Crop(cropId: json['cropId'], cropName: json['cropName']);
  }

  Map<String,dynamic> toJson(){
    return {
      "cropId": cropId,
      "cropName": cropName
    };
  }
}