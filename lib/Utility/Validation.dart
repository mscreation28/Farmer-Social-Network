class Validation{
  
  static String validateCropBreed(String value){
    final validCharacters = RegExp(r'^[a-zA-Z0-9_-]+$');
    if(value.isEmpty){
      return "Crop breed is required";
    }else if(!validCharacters.hasMatch(value)) {
      return "Enter valid crop breed";
    }else{
      return null;
    }
  }

  static String validateArea(String value){
    if(value.isEmpty){
      return "Area is required";
    }else if(double.tryParse(value)==null){
      return "Area must contain only numbers";
    }else if(double.parse(value)<=0){
      return "Area must be greater than 0";
    } else{
      return null;
    }
  }

  static String validateTimelineTitle(String value){
    if(value.isEmpty){
      return "Title is required";
    }else{
      return null;
    }
  }
  static String validateTimelineDescription(String value){
    if(value.isEmpty){
      return "Description is required";
    }else{
      return null;
    }
  }
  static String validateContactNumber(String value) {
    if (double.tryParse(value) == null) {
      return "Contact Number must contain only digits";
    } else if (value.isEmpty || value.length != 10) {
      return "Contact Number must contain 10 digits";
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password field is required";
    } else {
      return null;
    }
  }
  static String validateContactNumberSignUp(String value) {
   if (value.isEmpty || value.length != 10) {
      return "Contact Number must contain 10 digits";
    } else if (double.tryParse(value) == null) {
      return "Contact Number must contain only digits";
    } else {
      return null;
    }
  }

  static String validateUserName(String value) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9_]+$');
    if (value.isEmpty || value.length < 3) {
      return "Username must be greater than 2 characters";
    } else if (!validCharacters.hasMatch(value)) {
      return "Username can contain only characters, digits or _";
    } else {
      return null;
    }
    
  }

  static String validatePasswordSignUP(String value) {
    if (value.isEmpty) {
      return "Password field is required";
    } else if (value.length <= 7) {
      return "Password must be of 8 digits";
    } else {
      return null;
    }
  }
}