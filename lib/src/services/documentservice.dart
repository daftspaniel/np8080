import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';

@Injectable()
class DocumentService {
  final _allNotes = List<TextDocument>();
  TextDocument _activeNote;

  DocumentService() {}

  set note(TextDocument newActiveNote) {
    _activeNote = newActiveNote;
    document.title = _activeNote.downloadName;
  }

  get note => _activeNote;

  void addNote(TextDocument note) {
    _allNotes.add(note);
  }

  void makeNoteActive(int id) {
    _activeNote = _allNotes[id - 1];
    document.title = _activeNote.downloadName;
  }
}
