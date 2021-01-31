import '../Screen/signup_page.dart';
import '../Widget/titleText.dart';
import './login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  

  
  Widget _loginBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          LoginPage.routeName
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).accentColor,
                offset: Offset(2, 3),
                blurRadius: 4,
                spreadRadius: 1),
          ],
          color: Colors.white60,
        ),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          SignupPage.routeName
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Theme.of(context).accentColor, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  Widget _label() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      child: Column(
        children: [
          Text(
            "Welcome to the Green World..!",
            style: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 22),
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColorLight,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 170,
            ),
            TitleText(
              fontsize: 40,
              color1: Theme.of(context).primaryColorDark,
              color2: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 130,
            ),
            _loginBtn(),
            SizedBox(
              height: 30,
            ),
            _signUpButton(),
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.agriculture_rounded,
              color: Colors.green.shade900,
              size: 80,              
            ),
            _label()
          ],
        ),
      ),
    );
  }
}
