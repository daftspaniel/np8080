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

  DocumentService(TextareaDomService textareaDomService) {
    _textareaDomService = textareaDomService;
  }

  set activeNote(TextDocument newActiveNote) {
    _activeNote = newActiveNote;
    document.title = _activeNote.downloadName;
  }

  get activeNote => _activeNote;

  TextDocument getNote(int index) {
    return _allNotes[index];
  }

  void addNote(TextDocument note) {
    _allNotes.add(note);
  }

  void makeNoteActive(int id) {
    _activeNote = _allNotes[id - 1];
    document.title = _activeNote.downloadName;
    _textareaDomService.setFocus();
    storeValue('ActiveDocument', id.toString());
  }
}
