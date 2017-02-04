import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editablelabel/editablelabel_component.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/toolbar/menu/menu.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent,
    EditableLabelComponent, MenuComponent
    ],
    providers: const [TextProcessingService])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;
  List helpMenuItems;

  ToolbarComponent(this._textProcessingService) {
    display = new List<String>();
    display..add("none")..add("none")..add("none")..add("none")..add("none");
    helpMenuItems =
    [new Menu("GitHub", githubHandler, "Get the source code!"),
    new Menu("About", aboutHandler, "Find out more about NP8080")
    ];
  }

  List<String> display;

  @Input()
  TextDocument note;

  @Input()
  bool showAboutDialog;

  @Input()
  bool showReplaceDialog;

  @Input()
  bool showPrePostDialog;

  @Input()
  bool showGenerateDialog;

  @Input()
  bool showPreview;

  @Output()
  EventEmitter<bool> showAboutDialogChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showReplaceDialogChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showPrePostDialogChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showPreviewChange = new EventEmitter<bool>();

  @Output()
  EventEmitter<bool> showGenerateDialogChange = new EventEmitter<bool>();

  void markdownHandler() {
    showPreview = !showPreview;
    showPreviewChange.emit(showPreview);
  }

  void aboutHandler() {
    showAboutDialog = true;
    showAboutDialogChange.emit(showAboutDialog);
  }

  void clearHandler() {
    if (window.confirm(
        "Are you sure you want to clear the current document?")) {
      note.updateAndSave("");
    }
  }

  void trimHandler() {
    note.updateAndSave(_textProcessingService.trimText(note.text));
  }

  void sortHandler() {
    note.updateAndSave(_textProcessingService.sort(note.text));
  }

  void reverseHandler() {
    note.updateAndSave(_textProcessingService.reverse(note.text));
  }

  void randomHandler() {
    note.updateAndSave(_textProcessingService.randomise(note.text));
  }

  void duplicateHandler() {
    note.updateAndSave(_textProcessingService.getRepeatedString(note.text, 2));
  }

  void replaceHandler() {
    showReplaceDialog = true;
    showReplaceDialogChange.emit(showReplaceDialog);
  }

  void prePostHandler() {
    showPrePostDialog = true;
    showPrePostDialogChange.emit(showPrePostDialog);
  }

  void removeBlankLinesHandler() {
    note.updateAndSave(_textProcessingService.removeBlankLines(note.text));
  }

  void removeExtraBlankLinesHandler() {
    note.updateAndSave(_textProcessingService.removeExtraBlankLines(note.text));
  }

  void githubHandler() {
    window.location.href = "https://github.com/daftspaniel/np8080";
  }

  void downloadHandler() {
    note.save();
    String text = note.text;
    AnchorElement tl = document.createElement('a');
    tl
      ..attributes['href'] = 'data:text/plain;charset=utf-8,' +
          Uri.encodeComponent(text)
      ..attributes['download'] = note.downloadName
      ..click();
  }

  void generateHandler() {
    showGenerateDialog = true;
    showGenerateDialogChange.emit(showGenerateDialog);
  }

  void timestampHandler() {
    note.appendAndSave("\r\n" + new DateTime.now().toString());
  }

  void hide(int index) {
    display[index] = "none";
  }

  void show(int index) {
    display[index] = "block";
  }

  String getDisplay(int index) {
    if (display == null) return 'none';
    if (display.length == 0) return 'none';

    return display.elementAt(index);
  }
}