import 'dart:convert';

import 'package:KrishiMitr/models/crops.dart';
import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/network/interfaces/ICropClient.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CropClient implements ICropClient{
  static const CROP_URL = 'crops';
  
  Future<String> getTokenString() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Utils.TOKEN);
  }
  
  @override
  Future<List<Crop>> getAllCrops()async {
    String token = await getTokenString();
    List<Crop> cropList = [];
    var response = await http.get('${Utils.BASE_URL}$CROP_URL'
      ,headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
    );
    if(response.statusCode==200){
      var jsonResponse = jsonDecode(response.body);
      for(var crop in jsonResponse['crops']){
        cropList.add(new Crop.fromJson(crop));
      }
    }else{
      throw Exception('Error while getting crop list');
    }
    return cropList;
  }

}