import 'package:KrishiMitr/Screen/login_page.dart';
import 'package:KrishiMitr/Widget/titleText.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  static const routeName = './signup-page';
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

   Widget _inputArea(String inputText,{bool isPassword = false, bool isPhone = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(
            inputText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(            
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,              
              fillColor: Colors.grey.shade200,
              filled: true,
              labelText: "Enter $inputText",
              isDense: true              
            ),            
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
            spreadRadius: 2
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor
          ],
        )
      ),
      child: Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
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
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600
            ),
          ),          
          RawMaterialButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                LoginPage.routeName
              );
            },                        
            constraints: BoxConstraints(),
            child: Text(
              'Login',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w600
              ),
            ),
          ),          
        ],
      ),
    );
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
                height: height * 0.12,
              ),
              TitleText(fontsize: 40, color1: Theme.of(context).primaryColorDark, color2: Theme.of(context).primaryColor,),
              SizedBox(
                height: height * 0.04,
              ),
              _inputArea("Name"),
              _inputArea("Phone Number",isPhone: true),
              Row(                
                children: [
                  Container( 
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),
                    width: MediaQuery.of(context).size.width*0.42,
                    child: _inputArea("City"),
                  ),
                  Container( 
                    width: MediaQuery.of(context).size.width*0.42,
                    child: _inputArea("State"),
                  ),
                ],
              ),
              
              _inputArea("Password",isPassword: true),

              SizedBox(
                height: 20,
              ),
              _signupButton(),
              SizedBox(height: height * .03),
              _label()
            ]
          ),
        )
      )
    );
  }
}