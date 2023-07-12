extension AdditionalStringMethods on String {
  bool validateEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool validatePassword() {
    return RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$").hasMatch(this);
  }
  
  bool validateOnlyAlpha() {
    return RegExp(r"^[a-zA-Z]+$").hasMatch(this);
  }
  
  bool validatePhoneNumber() {
    return RegExp(r"^[\\+]?[(]?[0-9]{2,}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}$").hasMatch(this);
  }
}
