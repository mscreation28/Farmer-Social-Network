import './login_page.dart';
import '../Utility/Validation.dart';
import '../Widget/titleText.dart';
import '../models/users.dart';
import '../network/clients/UserClient.dart';
import '../network/interfaces/IUserClient.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const routeName = './signup-page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // ignore: missing_required_param
  User user = new User();
  TextEditingController userNameController = new TextEditingController();
  TextEditingController userContactNumberController =
      new TextEditingController();
  TextEditingController userCityController = new TextEditingController();
  TextEditingController userStateController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _validateRegistration = "";




  Widget _inputArea(String inputText, TextEditingController controller,
      {bool isPassword = false,
      bool isPhone = false,
      Function validator = null}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
             textInputAction: TextInputAction.next,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: "Enter $inputText",
                ),
            controller: controller,
            autofocus: true,
            validator: validator!=null?(value) {
              return validator(value);
            }:(_){
              return null;
            },
            keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          )
        ],
      ),
    );
  }

  Widget _signupButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColor
            ],
          )),
      child: Text(
        'Register Now',
        style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _label() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account ?",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            },
            constraints: BoxConstraints(),
            child: Text(
              'Login',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void registerUser() async {
    IUserClient userClient = UserClient();
    user.userName = userNameController.text;
    user.userCity = userCityController.text;
    user.userContactNumber = userContactNumberController.text;
    user.userState = userStateController.text;
    user.userpassword = userPasswordController.text;

    var response = await userClient.registerUser(user);
    
    if (response.statusCode == 201) {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    } else if(response.statusCode==409){
      setState(() {
        _validateRegistration = "Contact Number already exists";
      });
    } else {
      setState(() {
        _validateRegistration = "Error while creating new user";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: height,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.12,
                      ),
                      TitleText(
                        fontsize: 40,
                        color1: Theme.of(context).primaryColorDark,
                        color2: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      _inputArea("Name", userNameController,
                          validator: Validation.validateUserName),
                      _inputArea("Contact Number", userContactNumberController,
                          validator:Validation.validateContactNumberSignUp, isPhone: true),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: _inputArea("City", userCityController)),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: _inputArea("State", userStateController),
                          ),
                        ],
                      ),
                      _inputArea("Password", userPasswordController,
                          validator:Validation.validatePasswordSignUP, isPassword: true),
                      SizedBox(
                        height: 20,
                      ),
                       Container(
                            padding: const EdgeInsets.fromLTRB(8.0,4.0,8.0,14.0),
                            child: Text(_validateRegistration,style: TextStyle(color: Colors.red),),
                          ),
                      GestureDetector(
                        child: _signupButton(),
                        onTap: (){if(_formKey.currentState.validate())registerUser();},
                      ),
                      SizedBox(height: height * .03),
                      _label()
                    ]),
              ),
            )));
  }
}
