import 'dart:html';

class TextDocument {

  int id = 1;
  String text = '';
  DateTime lastModified;

  TextDocument() {
    text = window.localStorage['id1'];
    lastModified = null;
    if (text == null) text = "";
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