import 'dart:convert';

import 'package:KrishiMitr/models/crops.dart';
import 'package:KrishiMitr/network/clients/Utils.dart';
import 'package:KrishiMitr/network/interfaces/ICropClient.dart';
import 'package:http/http.dart' as http;
class CropClient implements ICropClient{
  static const CROP_URL = 'crops';
  
  @override
  Future<List<Crop>> getAllCrops()async {
    List<Crop> cropList = [];
    var response = await http.get('${Utils.BASE_URL}$CROP_URL');
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