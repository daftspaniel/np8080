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
    window.alert('np 8080 v0.2');
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

