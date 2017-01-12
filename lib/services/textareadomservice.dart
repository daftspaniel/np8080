import 'dart:html';

import 'package:angular2/core.dart';

@Injectable()
class TextareaDomService {

  String _id = '#nptextbox';

  TextareaSelection getCurrentSelectionInfo() {
    TextAreaElement nptb = querySelector(_id);
    TextareaSelection sel = new TextareaSelection();
    sel.start = nptb.selectionStart;
    sel.end = nptb.selectionEnd;
    return sel;
  }

  void setCursorPosition(int pos) {
    TextAreaElement nptb = querySelector(_id);
    nptb.setSelectionRange(pos, pos);
  }

  void setFocus() {
    TextAreaElement nptb = querySelector(_id);
    nptb.focus();
  }

}

class TextareaSelection {
  int start;
  int end;
}