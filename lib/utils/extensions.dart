extension Validators on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  String get reverse => split('').reversed.join();

  bool isValidPhoneNumber() {
    return RegExp("^[\\+]?[(]?[0-9]{2,}[)]?[-\\s\\.]?[0-9]{3}[-\\s\\.]?[0-9]{4,6}\$")
        .hasMatch(this);
  }

  bool isAlpha() {
    return RegExp("^[\\w'\\-,.][^0-9_!¡?÷?¿/\\+=@#\$%\\ˆ&*(){}|~<>;:[\\]]{2,}\$").hasMatch(this);
  }

  String capitalize() {
    List<String> wordList = this.split(" ");
    wordList = wordList.map((element) {
      return element[0].toUpperCase() + element.substring(1);
    }).toList();
    return wordList.join(" ");
  }

  bool isDateTimeString() {
    RegExp reg = new RegExp('[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}');
    return reg.hasMatch(this.split('.')[0]);
  }
}


extension AdditionMethodsList<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}