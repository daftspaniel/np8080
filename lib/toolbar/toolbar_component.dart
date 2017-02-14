import 'dart:html';

import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editablelabel/editablelabel_component.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/toolbar/menu/menu.dart';
import 'package:np8080/toolbar/menu_definition.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [ToolbarComponent,
    EditableLabelComponent, MenuComponent
    ],
    providers: const [TextProcessingService, TextareaDomService])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  final MenuDefinition menus = new MenuDefinition();

  ToolbarComponent(this._textProcessingService, this._textareaDomService) {
    menus.buildMenus(this);
  }

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
  bool showSeqGenerateDialog;

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

  @Output()
  EventEmitter<bool> showSeqGenerateDialogChange = new EventEmitter<bool>();

  void generateHandler() {
    showGenerateDialog = true;
    showGenerateDialogChange.emit(showGenerateDialog);
  }

  void generateSeqHandler() {
    showSeqGenerateDialog = true;
    showSeqGenerateDialogChange.emit(showSeqGenerateDialog);
  }

  void markdownHandler() {
    showPreview = !showPreview;
    showPreviewChange.emit(showPreview);
    _textareaDomService.setFocus();
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
    _textareaDomService.setFocus();
  }

  void trimFileHandler() {
    note.updateAndSave(_textProcessingService.trimText(note.text));
    _textareaDomService.setFocus();
  }

  void trimLinesHandler() {
    note.updateAndSave(_textProcessingService.trimLines(note.text));
    _textareaDomService.setFocus();
  }

  void sortHandler() {
    note.updateAndSave(_textProcessingService.sort(note.text));
    _textareaDomService.setFocus();
  }

  void reverseHandler() {
    note.updateAndSave(_textProcessingService.reverse(note.text));
    _textareaDomService.setFocus();
  }

  void randomHandler() {
    note.updateAndSave(_textProcessingService.randomise(note.text));
    _textareaDomService.setFocus();
  }

  void duplicateHandler() {
    note.updateAndSave(_textProcessingService.getRepeatedString(note.text, 2));
    _textareaDomService.setFocus();
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
    _textareaDomService.setFocus();
  }

  void removeExtraBlankLinesHandler() {
    note.updateAndSave(_textProcessingService.removeExtraBlankLines(note.text));
    _textareaDomService.setFocus();
  }

  void doublespaceHandler() {
    note.updateAndSave(_textProcessingService.doubleSpaceLines(note.text));
    _textareaDomService.setFocus();
  }

  void dupeHandler() {
    note.updateAndSave(_textProcessingService.dupeLines(note.text));
    _textareaDomService.setFocus();
  }

  void githubHandler() {
    window.location.href = "https://github.com/daftspaniel/np8080";
  }

  void gitterHandler() {
    window.location.href = "https://gitter.im/np8080/Lobby";
  }

  void downloadHandler() {
    note.save();

    document.createElement('a')
      ..attributes['href'] = 'data:text/plain;charset=utf-8,' +
          Uri.encodeComponent(note.text)
      ..attributes['download'] = note.downloadName
      ..click();

    _textareaDomService.setFocus();
  }

  void timestampHandler() {
    note.appendAndSave("\r\n" + new DateTime.now().toString());
    _textareaDomService.setFocus();
  }

}
