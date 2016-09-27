import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textprocessingservice.dart';

const String aboutTxt = """np 8080 v0.4

np8080.win is a web based text editor.

Your data is stored in your web browser's Local Storage.

It is NOT stored on any server.

Click Download to store the current contents on your filesystem.
    """;

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent],
    providers: const [TextProcessingService])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;

  ToolbarComponent(this._textProcessingService);

  @Input()
  TextDocument note;

  void aboutHandler() {
    window.alert(aboutTxt);
  }

  void trimHandler() {
    note.text = _textProcessingService.trimText(note.text);
    note.save();
  }

  void githubHandler(){
    window.location.href = "https://github.com/daftspaniel/np8080";
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