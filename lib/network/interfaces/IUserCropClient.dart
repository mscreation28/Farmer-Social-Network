import '../../models/user_crops.dart';
import 'package:http/http.dart';

abstract class IUserCropClient{
  Future<List<UserCrop>> getAllUserCrop(int userId);
  Future<UserCrop> getSpecificUserCrop(int userCropId);
  Future<Response> deleteUserCrop(int userCropId);
  Future<Response> updateUserCrop(UserCrop userCrop);
  Future<Response> addUserCrop(UserCrop userCrop);
}