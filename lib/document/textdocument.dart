import 'dart:html';

class TextDocument {

  int id = 1;
  String text = '';
  String _downloadName;
  DateTime lastModified;
  final List<String> _undoText = new List<String>();

  String get downloadName => _downloadName;

  String get storedText => window.localStorage['id1'];

  set downloadName(String value) {
    _downloadName = value;
    save();
  }

  TextDocument() {
    text = storedText;
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

  void updateAndSave(String newText) {
    text = newText;
    save();
  }

  void appendAndSave(String additionalText) {
    text += additionalText;
    save();
  }

  void save() {
    print("Save ${_undoText.length}");
    if ((_undoText.length == 0) ||
        (_undoText.length > 0 && _undoText[_undoText.length - 1] != storedText)) {
      print("Storing current ${storedText.length}");
      _undoText.add(storedText);
    }
    print("Save ${_undoText.length}");

    performSave();
  }

  void performSave() {

    updateModifiedDate();
    window.localStorage['id' + id.toString()] = text;
    window.localStorage['dn' + id.toString()] = _downloadName;
    window.localStorage['lm' + id.toString()] = lastModified.toIso8601String();
  }

  void undo() {
    text = _undoText.removeLast();
    performSave();
  }
}