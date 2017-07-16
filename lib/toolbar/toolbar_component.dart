import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/resources/resources.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'package:np8080/storage/localstorage.dart';
import 'package:np8080/storage/storagekeys.dart';
import 'package:np8080/toolbar/menu/menu.dart';
import 'package:np8080/toolbar/menu_definition.dart';

@Component(
    selector: 'editor-toolbar',
    templateUrl: 'toolbar_component.html',
    directives: const [NgClass, ToolbarComponent, MenuComponent])
class ToolbarComponent {
  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;
  final EventBusService _eventBusService;
  final ThemeService _themeService;

  final MenuDefinition menus = new MenuDefinition();

  ToolbarComponent(this._textProcessingService, this._textareaDomService,
      this._eventBusService, this._themeService) {
    menus.buildMenus(this);
  }

  @Input()
  TextDocument note;

  @Input()
  bool showPreview;

  @Output()
  Stream<bool> get showPreviewChange => onShowPreviewChange.stream;
  final StreamController onShowPreviewChange = new StreamController();

  void markdownHandler() {
    showPreview = !showPreview;
    storeValue(MarkdownPreviewVisibleKey, showPreview ? "showMarkdown" : "");
    onShowPreviewChange.add(showPreview);
    _textareaDomService.setFocus();
  }

  void generateHandler() {
    _eventBusService.post("showGenerateDialog");
  }

  void prePostHandler() {
    _eventBusService.post("showPrePostDialog");
  }

  void generateSeqHandler() {
    _eventBusService.post("showSequenceDialog");
  }

  void aboutHandler() {
    _eventBusService.post("showAboutDialog");
  }

  void removeLinesContaining() {
    _eventBusService.post("showDeleteLinesDialog");
  }

  void replaceHandler() {
    _eventBusService.post("showReplaceDialog");
  }

  void sampleHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave(welcomeText);
    }
    _textareaDomService.setFocus();
  }

  void markdownSampleHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave(markdownSampler);
      onShowPreviewChange.add(true);
    }
    _textareaDomService.setFocus();
  }

  void clearHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
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
    note.updateAndSave(
        _textProcessingService.generateRepeatedString(note.text, 2));
    _textareaDomService.setFocus();
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
    window.open("https://github.com/daftspaniel/np8080", 'github');
  }

  void gitterHandler() {
    window.open("https://gitter.im/np8080/Lobby", 'gitter');
  }

  void downloadHandler() {
    note.save();

    document.createElement('a')
      ..attributes['href'] =
          'data:text/plain;charset=utf-8,' + Uri.encodeComponent(note.text)
      ..attributes['download'] = note.downloadName
      ..click();

    _textareaDomService.setFocus();
  }

  void timestampDlgHandler() {
    _eventBusService.post("showTimestampDialog");
  }

  void undoHandler() {
    note.undo();
  }

  String getClass() {
    return _themeService.getMainClass();
  }

  void darkThemeHandler() {
    _themeService.theme = "dark";
  }

  void defaultThemeHandler() {
    _themeService.theme = "default";
  }

  void nb8080Handler() {
    window.open("https://daftspaniel.github.io/demos/nb8080/", 'git');
  }
}
