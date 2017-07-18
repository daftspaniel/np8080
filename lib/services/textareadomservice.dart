import 'dart:html';
import 'package:angular/angular.dart';

@Injectable()
class TextareaDomService {
  final String _id = '#nptextbox';

  TextareaSelection getCurrentSelectionInfo() {
    TextAreaElement nptb = querySelector(_id);
    TextareaSelection sel = new TextareaSelection();
    sel
      ..start = nptb.selectionStart
      ..end = nptb.selectionEnd
      ..text = nptb.value.substring(sel.start, sel.end);

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

  void setText(String txt) {
    TextAreaElement nptb = querySelector(_id);
    nptb.value = txt;
  }

  String getText() {
    TextAreaElement nptb = querySelector(_id);
    return nptb.value;
  }
}

class TextareaSelection {
  int start;
  int end;
  String text;
}
