import 'package:angular/angular.dart';
import 'package:np8080/src/document/textdocument.dart';

@Injectable()
class DocumentService {
  TextDocument _activeNote;
  TextDocument _inactiveNote;

  DocumentService() {}

  set note(TextDocument newActiveNote) {
    _activeNote = newActiveNote;
  }

  set inActiveNote(TextDocument newInactiveNote) {
    _inactiveNote = newInactiveNote;
  }

  get note {
    return _activeNote;
  }

  get InactiveNote {
    return _inactiveNote;
  }

  void swap() {
    if (_activeNote == null || _inactiveNote == null) return;
    TextDocument temp;
    temp = _activeNote;
    _activeNote = _inactiveNote;
    _inactiveNote = temp;
    print('Active note ${_activeNote.downloadName}');
    print('Inactive note ${_inactiveNote.downloadName}');
  }
}
