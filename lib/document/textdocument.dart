import 'dart:html';

class TextDocument {
  int id = 1;
  String text = '';

  TextDocument() {
    text = window.localStorage['id1'];
    if (text == null) text = "Welcome to notepad8080";
  }

  void save() {
    window.localStorage['id' + id.toString()] = text;
  }

  void trim() {
    text = text.trim();
    save();
  }
}