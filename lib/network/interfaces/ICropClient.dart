import '../../models/crops.dart';

abstract class ICropClient{
   Future<List<Crop>> getAllCrops();
}