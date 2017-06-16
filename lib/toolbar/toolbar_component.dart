import 'dart:async';
import 'dart:html';
import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editablelabel/editablelabel_component.dart';
import 'package:np8080/resources/resources.dart';
import 'package:np8080/services/eventbusservice.dart';
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
    providers: const [TextProcessingService, TextareaDomService, EventBusService
    ])
class ToolbarComponent {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;
  final EventBusService _eventBusService;

  final MenuDefinition menus = new MenuDefinition();

  ToolbarComponent(this._textProcessingService, this._textareaDomService,
      this._eventBusService) {
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
  bool showDeleteLinesDialog;

  @Input()
  bool showPreview;

  @Output()
  Stream<bool> get showAboutDialogChange => onShowAboutDialogChange.stream;
  final StreamController onShowAboutDialogChange = new StreamController();

  @Output()
  Stream<bool> get showReplaceDialogChange => onShowReplaceDialogChange.stream;
  final StreamController onShowReplaceDialogChange = new StreamController();

  @Output()
  Stream<bool> get showPrePostDialogChange => onShowPrePostDialogChange.stream;
  final StreamController onShowPrePostDialogChange = new StreamController();

  @Output()
  Stream<bool> get showDeleteLinesDialogChange =>
      onshowDeleteLinesDialogChange.stream;
  final StreamController onshowDeleteLinesDialogChange = new StreamController();

  @Output()
  Stream<bool> get showPreviewChange => onShowPreviewChange.stream;
  final StreamController onShowPreviewChange = new StreamController();

  @Output()
  Stream<bool> get showGenerateDialogChange =>
      onShowGenerateDialogChange.stream;
  final StreamController onShowGenerateDialogChange = new StreamController();

  @Output()
  Stream<bool> get showSeqGenerateDialogChange =>
      onShowSeqGenerateDialogChange.stream;
  final StreamController onShowSeqGenerateDialogChange = new StreamController();

  void generateHandler() {
    showGenerateDialog = true;
    onShowGenerateDialogChange.add(showGenerateDialog);
  }

  void generateSeqHandler() {
    showSeqGenerateDialog = true;
    onShowSeqGenerateDialogChange.add(showSeqGenerateDialog);
  }

  void markdownHandler() {
    showPreview = !showPreview;
    onShowPreviewChange.add(showPreview);
    _textareaDomService.setFocus();
  }

  void aboutHandler() {
    print('posting');
    showAboutDialog = true;
    onShowAboutDialogChange.add(showAboutDialog);
  }

  void sampleHandler() {
    if (note.empty || window.confirm(
        "Are you sure you want to clear the current document?")) {
      note.updateAndSave(welcomeText);
    }
    _textareaDomService.setFocus();
  }

  void markdownSampleHandler() {
    if (note.empty || window.confirm(
        "Are you sure you want to clear the current document?")) {
      note.updateAndSave(markdownSampler);
      onShowPreviewChange.add(true);
    }
    _textareaDomService.setFocus();
  }

  void clearHandler() {
    if (note.empty || window.confirm(
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
    note.updateAndSave(_textProcessingService.randomiseLines(note.text));
    _textareaDomService.setFocus();
  }

  void duplicateHandler() {
    note.updateAndSave(_textProcessingService.getRepeatedString(note.text, 2));
    _textareaDomService.setFocus();
  }

  void replaceHandler() {
    showReplaceDialog = true;
    onShowReplaceDialogChange.add(showReplaceDialog);
  }

  void prePostHandler() {
    showPrePostDialog = true;
    onShowPrePostDialogChange.add(showPrePostDialog);
  }

  void oneLineHandler() {
    note.updateAndSave(_textProcessingService.makeOneLine(note.text));
    _textareaDomService.setFocus();
  }

  void removeBlankLinesHandler() {
    note.updateAndSave(_textProcessingService.removeBlankLines(note.text));
    _textareaDomService.setFocus();
  }

  void removeExtraBlankLinesHandler() {
    note.updateAndSave(_textProcessingService.removeExtraBlankLines(note.text));
    _textareaDomService.setFocus();
  }

  void removeLinesContaining() {
    showDeleteLinesDialog = true;
    onshowDeleteLinesDialogChange.add(showDeleteLinesDialog);
  }

  void doublespaceHandler() {
    note.updateAndSave(_textProcessingService.doubleSpaceLines(note.text));
    _textareaDomService.setFocus();
  }

  void uriEncodeHandler() {
    note.updateAndSave(_textProcessingService.uriEncode(note.text));
    _textareaDomService.setFocus();
  }

  void uriDecodeHandler() {
    note.updateAndSave(_textProcessingService.uriDecode(note.text));
    _textareaDomService.setFocus();
  }

  void htmlUnescapeHandler() {
    note.updateAndSave(_textProcessingService.htmlUnescape(note.text));
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

  void undoHandler() {
    note.undo();
  }

}
