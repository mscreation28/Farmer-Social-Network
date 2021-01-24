import 'package:KrishiMitr/models/crops.dart';

abstract class ICropClient{
   Future<List<Crop>> getAllCrops();
}