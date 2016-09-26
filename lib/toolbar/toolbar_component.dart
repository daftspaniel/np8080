import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent])
class ToolbarComponent {

  @Input()
  TextDocument note;

  void aboutHandler() {
    String txt = """np 8080 v0.3

np8080.win is a web based text editor.

Your data is stored in your web browser's Local Storage.

It is NOT stored on any server.

Click Download to store the current contents on your filesystem.
    """;
    window.alert(txt);
  }

  void trimHandler() {
    note.trim();
  }

  void downloadHandler() {
    String text = note.text;
    AnchorElement tl = document.createElement('a');
    tl
      ..attributes['href'] = 'data:text/plain;charset=utf-8,' +
          Uri.encodeComponent(text)
      ..attributes['download'] = "np8080.txt"
      ..click();
  }
}

