import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/storage/localstorage.dart';

const defaultDownloadName = 'np8080.txt';
const defaultFilename = 'np8080';
const defaultFileExtension = 'txt';

class TextDocument {
  final _undoText = List<String>();

  final int _id;
  var _text = '';
  String _downloadName;
  DateTime _lastModified;

  TextDocument(this._id) {
    initText();
    initLastModifiedDate();
    initDownloadName();
  }

  DateTime get lastModified => _lastModified;

  void set lastModified(DateTime lastModified) {
    _lastModified = lastModified;
  }

  bool get empty => _text.length == 0;

  String get downloadName => _downloadName;

  String get text => _text;

  int get id => _id;

  String get storedText => loadValue('id$_id', null);

  set downloadName(String value) {
    _downloadName = value;
    save();
  }

  set text(String value) {
    _text = value;
    save();
  }

  void initText() {
    _text = storedText;
    if (_text == null) _text = welcomeText;
  }

  void initDownloadName() {
    _downloadName = loadValue('dn$_id', null);
    if (_downloadName == null) generateDownloadName();
  }

  void generateDownloadName() {
    downloadName = '$defaultFilename-$_id.$defaultFileExtension';
  }

  void reset() {
    generateDownloadName();
    updateModifiedDate();
  }

  void initLastModifiedDate() {
    var lms = loadValue('lm$_id', null);

    if (lms != null) {
      lastModified = DateTime.parse(lms);
    }
  }

  void updateModifiedDate() => lastModified = DateTime.now();

  void updateAndSave(String newText) {
    _text = newText;
    save();
  }

  void appendAndSave(String additionalText) {
    _text += additionalText;
    save();
  }

  void save() {
    if (_text != storedText) {
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
    storeValue('id$_id', _text);
    storeValue('dn$_id', _downloadName);
    storeValue('lm$_id', lastModified.toIso8601String());
  }

  void undo() {
    _text = _undoText.removeLast();
    performSave();
  }
}
