import 'package:KrishiMitr/Widget/titleText.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = './login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   Widget _inputArea(String inputText,{bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
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
              labelText: isPassword ? "Enter Password" : "Enter Mobile Number"
            ),
            keyboardType: !isPassword ? TextInputType.phone : TextInputType.text
          )
        ],
      ),
    );
  }

  Widget _loginButton() {
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
        'Login',
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
            "Don\'t have an account ?",
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},                        
            constraints: BoxConstraints(),
            child: Text(
              'Register',
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
                height: height * 0.18,
              ),
              TitleText(fontsize: 40, color1: Theme.of(context).primaryColorDark, color2: Theme.of(context).primaryColor,),
              SizedBox(
                height: height * 0.08,
              ),
              _inputArea("Phone Number"),                        
              _inputArea("Password",isPassword: true),                                     
              Container(                
                alignment: Alignment.centerRight,
                child: Text('Forgot Password ?',
                  style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600
                  )
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _loginButton(),
              SizedBox(height: height * .1),
              _label()
            ]
          ),
        )
      )
    );
  }
}