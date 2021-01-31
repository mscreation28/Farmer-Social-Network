import '../Widget/titleText.dart';
import '../models/crops.dart';
import '../models/user_crops.dart';
import '../models/users.dart';
import '../network/clients/CropClient.dart';
import '../network/clients/UserClient.dart';
import '../network/clients/UserCropClient.dart';
import '../Utility/Utils.dart';
import '../network/interfaces/ICropClient.dart';
import '../network/interfaces/IUserClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page/edit_profile.dart';
import '../page/new_crop_timeline.dart';
import '../Widget/userCropListItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "./profile-page";
  List<Crop> cropList;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static int userId;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int userIdData = prefs.getInt(Utils.USER_ID);

    if (userIdData != null) {
      setState(() {
        isLoggedIn = true;
        userId = userIdData;
      });
      return;
    }
  }

  void gotoEditProfile(User user) {
    Navigator.pushNamed(context, EditProfile.routeName,
        arguments: {'user': user,'refresh':refreshUser});
  }

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
                      Container(
                        alignment: Alignment.topRight,
                        child: FlatButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              gotoEditProfile(user);
                            },
                            padding: EdgeInsets.only(right: 17),
                            minWidth: 0,
                            height: 0,
                            // constraints: BoxConstraints(),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Edit Profile',
                                  style: GoogleFonts.cairo(
                                      textStyle:
                                          Theme.of(context).textTheme.caption,
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.bold),
                                ),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 5,
                                )),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.edit,
                                    size: 21,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                )
                              ]),
                            )

                            // icon:
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
      list.add(UserCropList(userCropList[i], widget.cropList, refresh));
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: TitleText(
          color1: Theme.of(context).primaryColorDark,
          color2: Theme.of(context).accentColor
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight
              ],
            )
          ),
        ),
      ),
      body: isLoggedIn
          ? SingleChildScrollView(
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
                            }),
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
                      ])),
            )
          : Text("not logged In"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewCropTimeline.routeName,
              arguments: {'cropList': widget.cropList,'userId':userId,'refresh':refresh});
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
