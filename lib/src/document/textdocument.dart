import 'dart:html';

import '../resources/resources.dart';

class TextDocument {
  int id = 1;
  String text = '';
  String _downloadName;
  DateTime lastModified;

  final List<String> _undoText = new List<String>();

  TextDocument() {
    initText();
    initLastModifiedDate();
    initDownloadName();
  }

  bool get empty => text.length == 0;

  String get downloadName => _downloadName;

  String get storedText => window.localStorage['id1'];

  set downloadName(String value) {
    _downloadName = value;
    save();
  }

  void initText() {
    text = storedText;
    if (text == null) text = welcomeText;
  }

  void initDownloadName() {
    _downloadName = window.localStorage['dn1'];
    if (_downloadName == null) downloadName = "np8080.txt";
  }

  void reset() {
    downloadName = "np8080.txt";
    updateModifiedDate();
  }

  void initLastModifiedDate() {
    String lms = window.localStorage['lm1'];

    if (lms != null) {
      lastModified = DateTime.parse(lms);
    }
  }

  void updateModifiedDate() => lastModified = new DateTime.now();

  void updateAndSave(String newText) {
    text = newText;
    save();
  }

  void appendAndSave(String additionalText) {
    text += additionalText;
    save();
  }

  void save() {
    if (text != storedText) {
      updateUndoBuffer();
    }
    performSave();
  }

  void updateUndoBuffer() {
    if ((_undoText.length == 0) ||
        (_undoText.length > 0 &&
            _undoText[_undoText.length - 1] != storedText)) {
      _undoText.add(storedText);
    }
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
