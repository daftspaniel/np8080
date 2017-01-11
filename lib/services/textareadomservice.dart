import 'dart:html';

import 'package:angular2/core.dart';

@Injectable()
class TextareaDomService {

  TextareaSelection getCurrentSelectionInfo(String id) {
    TextAreaElement nptb = querySelector(id);
    TextareaSelection sel = new TextareaSelection();
    sel.start = nptb.selectionStart;
    sel.end = nptb.selectionEnd;
    return sel;
  }

  void setCursorPosition(String id, int pos) {
    TextAreaElement nptb = querySelector(id);
    nptb.setSelectionRange(pos, pos);
  }

  void setFocus(String id) {
    TextAreaElement nptb = querySelector(id);
    nptb.focus();
  }

}

class TextareaSelection {
  int start;
  int end;
}