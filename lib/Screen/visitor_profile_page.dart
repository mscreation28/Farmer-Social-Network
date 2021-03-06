import '../Widget/visitor_crop_item.dart';
import '../models/crops.dart';
import '../models/user_crops.dart';
import '../models/users.dart';
import '../network/clients/CropClient.dart';
import '../network/clients/UserClient.dart';
import '../network/clients/UserCropClient.dart';
import '../Utility/Utils.dart';
import '../network/interfaces/ICropClient.dart';
import '../network/interfaces/IUserClient.dart';
import '../page/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitorProfilePage extends StatefulWidget {
  static const routeName = "./visitor-profile-page";
  List<Crop> cropList;
  @override
  _VisitorProfilePageState createState() => _VisitorProfilePageState();
}

class _VisitorProfilePageState extends State<VisitorProfilePage> {
  static int userId;
  bool isLoggedIn = false;

  Widget _headSection(User user) {
    return Container(
      // height: 230,
      child: Stack(
        alignment: Alignment.topLeft,
        overflow: Overflow.visible,
        children: [
          Column(
            children: [
              Container(
                height: 150.0,
                width: double.infinity,
                child: Image.asset("assets/images/back_farm.JPG",
                    fit: BoxFit.cover),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 15, left: 160),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          user.userName,
                          style: GoogleFonts.cairo(
                            textStyle: Theme.of(context).textTheme.headline6,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 0.8,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          '${user.userCity}, ${user.userState}',
                          style: GoogleFonts.cairo(
                              textStyle: Theme.of(context).textTheme.caption,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ),
            ],
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              height: 120.0,
              width: 120.0,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage('${Utils.BASE_URL}uploads/${user.userProfileUrl}'),
                  )),
              // child: Image.asset(
              //   "assets/images/farmer.png",
              // ),
            ),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {
      getUserCropList();
    });
  }
  void refreshUser() {
    setState(() {
      getUser();
    });
  }

  Widget getUserCropListWidget(List<UserCrop> userCropList) {
    List<Widget> list = [];
    for (var i = 0; i < userCropList.length; i++) {
      list.add(VisitorCropList(userCropList[i], widget.cropList, refresh));
    }
    return new Column(children: list);
  }

  //get all crops
  Future<List<Crop>> getCropList() async {
    ICropClient cropClient = new CropClient();
    return cropClient.getAllCrops();
  }

  //get specific user
  Future<User> getUser() async {
    IUserClient userClient = new UserClient();
    return await userClient.getSpecificUser(userId);
  }

  Future<List<UserCrop>> getUserCropList() async {
    //first get crop list
    widget.cropList = await getCropList();

    //then fetch user crop
    UserCropClient userCropClient = new UserCropClient();
    List<UserCrop> userCropList = await userCropClient.getAllUserCrop(userId);

    //sort based on userCropDate
    userCropList.sort((userCrop1,userCrop2){
      return userCrop2.cropDate.compareTo(userCrop1.cropDate);
    });

    userCropList.forEach((userCrop) {
      userCrop.cropName = widget.cropList
          .firstWhere((crop) => crop.cropId == userCrop.cropId)
          .cropName;
      });    
    
      
    return userCropList;
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    userId = routeArgs['userId'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(
            color: Theme.of(context).primaryColorDark
          ),
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: getUser(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? _headSection(snapshot.data as User)
                      : CircularProgressIndicator();
                }
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: getUserCropList(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? getUserCropListWidget(
                          snapshot.data as List<UserCrop>)
                      : CircularProgressIndicator();
                },
              )
            ]
          )
        ),
      )
    );
  }
}
