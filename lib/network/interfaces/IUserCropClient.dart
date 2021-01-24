import 'package:KrishiMitr/models/user_crops.dart';

abstract class IUserCropClient{
  Future<List<UserCrop>> getAllUserCrop(int userId);
  Future<UserCrop> getSpecificUserCrop(int userCropId);
  void deleteUserCrop(int userCropId);
  void updateUserCrop(UserCrop userCrop);
  void addUserCrop(UserCrop userCrop);
}