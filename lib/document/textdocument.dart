import 'dart:html';

class TextDocument {

  int id = 1;
  String text = '';
  String _downloadName;
  DateTime lastModified;

  get downloadName => _downloadName;

  set downloadName(String value) {
    _downloadName = value;
    save();
  }

  TextDocument() {
    text = window.localStorage['id1'];
    _downloadName = window.localStorage['dn1'];
    String lms = window.localStorage['lm1'];

    if (lms != null) {
      lastModified = DateTime.parse(lms);
    }

    if (text == null) text = "";
    if (_downloadName == null) downloadName = "np8080.txt";
  }

  void updateModifiedDate() {
    lastModified = new DateTime.now();
  }

  void save() {
    updateModifiedDate();
    window.localStorage['id' + id.toString()] = text;
    window.localStorage['dn' + id.toString()] = _downloadName;
    window.localStorage['lm' + id.toString()] = lastModified.toIso8601String();
  }
}