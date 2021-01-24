import 'dart:io';
import 'package:KrishiMitr/models/users.dart';
import 'package:KrishiMitr/network/clients/UserClient.dart';
import 'package:KrishiMitr/network/interfaces/IUserClient.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:KrishiMitr/Widget/imageDialog.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'edit-profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File imageFile;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String name;
  User user;

  Future getImage(String action) async {      
    final selectedImage = action != "Gallery"
      ? await picker.getImage(source: ImageSource.camera)
        : await picker.getImage(source: ImageSource.gallery);
    
    setState(() {
      if (selectedImage != null) {
        imageFile = File(selectedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget imageDialog(BuildContext context) {
    return SimpleDialog(
      children: [
        SimpleDialogOption(
          child: Text('Choose from Gallery'),
          onPressed: () {
            getImage('Gallery').then((selectedImage) {
              // setState(() {
              //   imageFile = File(PickedFile.);
              //   print(imageFile);
              // });                  
            });
          },
        ),
        SimpleDialogOption(
          child: Text('Take Photo'),
          onPressed: () {
            getImage('Camera').then((selectedImage) {
              // setState(() {
              //   imageFile = selectedImage;
              //   print(imageFile);
              // });                  
            });
          },
        ),
        SimpleDialogOption(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  void updateUser() async{
    IUserClient userClient = new UserClient();
    userClient.updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context).settings.arguments as Map<String,dynamic>;
    user = routeArgs['user'] as User;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              if (_formKey.currentState.validate()) {                  
                _formKey.currentState.save();//save once fields are valid, onSaved method invoked for every form fields
                updateUser();
              } else {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always; //enable realtime validation
                });
              }
            }
          )
        ],
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body : SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 110.0,
                height: 110.0,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,                        
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 2,
                  // ), 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 6
                    )
                  ],   
                  image: DecorationImage(
                    image: imageFile == null
                      ? AssetImage("assets/images/farmer.png")
                        : FileImage(imageFile)
                  )                           
                ),
                // child: imageFile != null
                //   ? Image.file(imageFile)
                //     : Image.asset("assets/images/farmer.png"),              
              ),
              FlatButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return imageDialog(context);
                    },
                  );
                },
                child: Text(
                  'Change Photo',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: user.userName,
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (value) => value.isEmpty ? 'Name is required' : null,
                        onSaved: (value) => user.userName = value,
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        initialValue: user.userContactNumber,
                        decoration: InputDecoration(labelText: 'Mobile Number'),
                        validator: (value) => value.isEmpty ? 'Mobile number is required' : null,
                        onSaved: (value) => name = value,
                        keyboardType: TextInputType.number,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: user.userCity,
                              decoration: InputDecoration(labelText: 'City'),
                              validator: (value) => value.isEmpty ? 'City is required' : null,
                              onSaved: (value) => user.userCity = value,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextFormField(
                              initialValue: user.userState,
                              decoration: InputDecoration(labelText: 'State',),
                              validator: (value) => value.isEmpty ? 'State is required' : null,
                              onSaved: (value) => user.userState = value,                        
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        initialValue: user.userpassword,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (value) => value.isEmpty ? 'Password is required' : null,
                        onSaved: (value) => user.userpassword = value,                        
                      ),
                    ]
                  )
                )
              )
            ],
          ),
        ),
      )
    );
  }
}
