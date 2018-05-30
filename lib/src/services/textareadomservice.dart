import 'dart:html';
import 'dart:async';
import 'package:angular/angular.dart';

@Injectable()
class TextareaDomService {
  final String _id = '#nptextbox';

  TextAreaElement nptb;

  TextareaSelection getCurrentSelectionInfo() {
    var sel = TextareaSelection();
    sel
      ..start = textArea.selectionStart
      ..end = textArea.selectionEnd
      ..text = textArea.value.substring(sel.start, sel.end);

    return sel;
  }

  TextAreaElement get textArea {
    if (nptb == null) {
      nptb = querySelector(_id);
    }
    return nptb;
  }

  void setCursorPosition(int pos) => textArea?.setSelectionRange(pos, pos);

  void setFocus() {
    Timer(Duration(milliseconds: 154), () => textArea?.focus());
  }

  void setFocusAndPosition(int position) {
    Timer(Duration(milliseconds: 255), () {
      textArea.focus();
      textArea.setSelectionRange(position, position);
    });
  }

  void setText(String txt) => textArea.value = txt;

  String getText() => textArea.value;
}

class TextareaSelection {
  int start;
  int end;
  String text;
}
