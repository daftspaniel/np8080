import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/storage/localstorage.dart';
import 'package:np8080/src/storage/storagekeys.dart';
import 'package:np8080/src/toolbar/menu/menu.dart';
import 'package:np8080/src/toolbar/menu_definition.dart';

@Component(
    selector: 'editor-toolbar',
    visibility: Visibility.none,
    templateUrl: 'toolbar.html',
    directives: const [NgClass, Toolbar, MenuComponent])
class Toolbar extends EditorComponentBase {
  final MenuDefinition menus = new MenuDefinition();
  final StreamController onShowPreviewChange = new StreamController();

  @Input()
  TextDocument note;

  @Input()
  bool showPreview;

  @Output()
  Stream<bool> get showPreviewChange => onShowPreviewChange.stream;

  Toolbar(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    menus.buildMenus(this);
  }

  void markdownHandler() {
    showPreview = !showPreview;
    storeValue(MarkdownPreviewVisibleKey, showPreview ? "showMarkdown" : "");
    onShowPreviewChange.add(showPreview);
    textareaDomService.setFocus();
  }

  void generateHandler() => post("showGenerateDialog");

  void prePostHandler() => post("showPrePostDialog");

  void generateSeqHandler() => post("showSequenceDialog");

  void aboutHandler() => post("showAboutDialog");

  void removeLinesContaining() => post("showDeleteLinesDialog");

  void replaceHandler() => post("showReplaceDialog");

  void sampleHandler() => post("resetTextToSample");

  void markdownSampleHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave(markdownSampler);
      showPreview = true;
      storeValue(MarkdownPreviewVisibleKey, showPreview ? "showMarkdown" : "");
      onShowPreviewChange.add(true);
    }
    textareaDomService.setFocus();
  }

  void clearHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave("");
    }
    textareaDomService.setFocus();
  }

  void operation(Function action) {
    note.updateAndSave(action(note.text));
    textareaDomService.setFocus();
  }

  void trimFileHandler() => operation(textProcessingService.trimText);

  void trimLinesHandler() => operation(textProcessingService.trimLines);

  void sortHandler() => operation(textProcessingService.sort);

  void reverseHandler() => operation(textProcessingService.reverse);

  void randomHandler() => operation(textProcessingService.randomiseLines);

  void duplicateHandler() {
    note.updateAndSave(
        textProcessingService.generateRepeatedString(note.text, 2));
    textareaDomService.setFocus();
  }

  void oneLineHandler() => operation(textProcessingService.makeOneLine);

  void removeBlankLinesHandler() =>
      operation(textProcessingService.removeBlankLines);

  void removeExtraBlankLinesHandler() =>
      operation(textProcessingService.removeExtraBlankLines);

  void doublespaceHandler() =>
      operation(textProcessingService.doubleSpaceLines);

  void uriEncodeHandler() => operation(textProcessingService.uriEncode);

  void uriDecodeHandler() => operation(textProcessingService.uriDecode);

  void htmlUnescapeHandler() => operation(textProcessingService.htmlUnescape);

  void dupeHandler() => operation(textProcessingService.dupeLines);

  void downloadHandler() {
    note.save();

    document.createElement('a')
      ..attributes['href'] =
          'data:text/plain;charset=utf-8,' + Uri.encodeComponent(note.text)
      ..attributes['download'] = note.downloadName
      ..click();

    textareaDomService.setFocus();
  }

  void timestampDlgHandler() => post("showTimestampDialog");

  void manualHandler() => post("showManualDialog");

  void splitHandler() => post("showSplitDialog");

  void post(String msg) => eventBusService.post(msg);

  void undoHandler() => note.undo();

  void readerHandler() => post("showReaderView");

  void nb8080Handler() =>
      window.open("https://daftspaniel.github.io/demos/nb8080/", 'git');

  void githubHandler() =>
      window.open("https://github.com/daftspaniel/np8080", 'github');

  void gitterHandler() =>
      window.open("https://gitter.im/np8080/Lobby", 'gitter');

  void whatsNewHandler() => window.open(
      "https://github.com/daftspaniel/np8080/blob/master/CHANGELOG.md",
      'CHANGELOG');

  void numberHandler() => operation(textProcessingService.addNumbering);

  void themesHandler() => post("showThemesDialog");
}
