import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/storage/localstorage.dart';

@Injectable()
class DocumentService {
  final _allNotes = List<TextDocument>();
  var _textareaDomService;
  TextDocument _activeNote;
  int _activeNoteId = 0;

  DocumentService(TextareaDomService textareaDomService) {
    _textareaDomService = textareaDomService;
  }

  set activeNote(TextDocument newActiveNote) {
    _activeNote = newActiveNote;
    document.title = _activeNote.downloadName;
  }

  get activeNote => _activeNote;

  TextDocument getNote(int index) => _allNotes[index];

  void addNote(TextDocument note) => _allNotes.add(note);

  void makeNoteActive(int id) {
    _activeNoteId = id - 1;
    _activeNote = _allNotes[_activeNoteId];
    document.title = _activeNote.downloadName;
    _textareaDomService.setFocus();
    storeValue('ActiveDocument', id.toString());
  }

  void moveToNextTab() {
    _activeNoteId++;
    if (_activeNoteId > 5) _activeNoteId = 0;
    makeNoteActive(_activeNoteId + 1);
  }

  void moveToPreviousTab() {
    _activeNoteId--;
    if (_activeNoteId < 0) _activeNoteId = 5;
    makeNoteActive(_activeNoteId + 1);
  }
}
