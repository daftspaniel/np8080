import 'dart:html';

import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';

@Injectable()
class DocumentService {
  final _allNotes = List<TextDocument>();
  TextDocument _activeNote;

  //TextDocument _inactiveNote;

  DocumentService() {}

  set note(TextDocument newActiveNote) {
    _activeNote = newActiveNote;
    document.title = _activeNote.downloadName;
  }

//  set inActiveNote(TextDocument newInactiveNote) {
//    _inactiveNote = newInactiveNote;
//  }
//
  get note => _activeNote;

  void addNote(TextDocument note) {
    _allNotes.add(note);
  }

  //get InactiveNote => _inactiveNote;

  void makeNoteActive(int id) {
    print('SWAP $id');
    _activeNote = _allNotes[id - 1];
    document.title = _activeNote.downloadName;
//    if (_activeNote == null || _inactiveNote == null) return;
//    var temp = _activeNote;
//    _activeNote = _inactiveNote;
//    _inactiveNote = temp;
//    document.title = _activeNote.downloadName;
  }
}
