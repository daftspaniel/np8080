import 'dart:html';

class TextDocument {
  final int id = 1;
  String text = '';
  DateTime lastModified;

  TextDocument() {
    text = window.localStorage['id1'];
    if (text == null) text = "Welcome to notepad8080";
    updateModifiedDate();
  }

  void updateModifiedDate() {
    lastModified = new DateTime.now();
  }

  void save() {
    updateModifiedDate();
    window.localStorage['id' + id.toString()] = text;
  }

  void trim() {
    text = text.trim();
    save();
  }
}