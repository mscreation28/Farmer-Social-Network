import 'dart:convert';

import 'package:KrishiMitr/Screen/tab_page.dart';
import 'package:KrishiMitr/Utility/Validation.dart';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:KrishiMitr/Utility/Utils.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signup_page.dart';
import '../Widget/titleText.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = './login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  User user = new User();
  TextEditingController userContactNumberController =
      new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();
  bool _validatePass = true;
  bool _validateContact = true;
  String _loginFailString = "";
    final focus = FocusNode();

 

  Widget _inputArea(String inputText, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
                  hintText:
                      isPassword ? "Enter Password" : "Enter Contact Number"),
              controller: controller,
              validator: (value) {
                return isPassword
                    ? Validation.validatePassword(value)
                    : Validation.validateContactNumber(value);
              },
              autofocus: true,
              keyboardType:
                  !isPassword ? TextInputType.phone : TextInputType.text)
        ],
      ),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          _loginUser();
        }
      },
      child: Container(
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
          'Login',
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
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
            "Don\'t have an account ?",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                SignupPage.routeName,
              );
            },
            constraints: BoxConstraints(),
            child: Text(
              'Register',
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

  void _loginUser() async {
    IUserClient userClient = new UserClient();
    user.userContactNumber = userContactNumberController.text;
    user.userpassword = userPasswordController.text;

    Response response = await userClient.loginUser(user);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(Utils.USER_ID, json['userId']);
      prefs.setString(Utils.TOKEN, json['token']);
      Navigator.of(context).pushNamedAndRemoveUntil(TabScreen.routeName,(Route<dynamic> route) => false);
    }else{
         setState(() {
           _loginFailString = "Incorrect username or password";
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.18,
                    ),
                    TitleText(
                      fontsize: 40,
                      color1: Theme.of(context).primaryColorDark,
                      color2: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    Form(
                     
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          _inputArea(
                              "Contact Number", userContactNumberController),
                          _inputArea("Password", userPasswordController,
                              isPassword: true),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,14.0),
                            child: Text(_loginFailString,style: TextStyle(color: Colors.red),),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _loginButton(),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .1),
                    _label()
                  ]),
            )));
  }
}
