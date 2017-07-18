import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/editorcomponentbase.dart';
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
class ToolbarComponent extends EditorComponentBase {
  final MenuDefinition menus = new MenuDefinition();

  ToolbarComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
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
    textareaDomService.setFocus();
  }

  void generateHandler() => eventBusService.post("showGenerateDialog");

  void prePostHandler() => eventBusService.post("showPrePostDialog");

  void generateSeqHandler() => eventBusService.post("showSequenceDialog");

  void aboutHandler() => eventBusService.post("showAboutDialog");

  void removeLinesContaining() => eventBusService.post("showDeleteLinesDialog");

  void replaceHandler() => eventBusService.post("showReplaceDialog");

  void sampleHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave(welcomeText);
    }
    textareaDomService.setFocus();
  }

  void markdownSampleHandler() {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      note.updateAndSave(markdownSampler);
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

  void trimFileHandler() {
    note.updateAndSave(textProcessingService.trimText(note.text));
    textareaDomService.setFocus();
  }

  void trimLinesHandler() {
    note.updateAndSave(textProcessingService.trimLines(note.text));
    textareaDomService.setFocus();
  }

  void sortHandler() {
    note.updateAndSave(textProcessingService.sort(note.text));
    textareaDomService.setFocus();
  }

  void reverseHandler() {
    note.updateAndSave(textProcessingService.reverse(note.text));
    textareaDomService.setFocus();
  }

  void randomHandler() {
    note.updateAndSave(textProcessingService.randomiseLines(note.text));
    textareaDomService.setFocus();
  }

  void duplicateHandler() {
    note.updateAndSave(
        textProcessingService.generateRepeatedString(note.text, 2));
    textareaDomService.setFocus();
  }

  void oneLineHandler() {
    note.updateAndSave(textProcessingService.makeOneLine(note.text));
    textareaDomService.setFocus();
  }

  void removeBlankLinesHandler() {
    note.updateAndSave(textProcessingService.removeBlankLines(note.text));
    textareaDomService.setFocus();
  }

  void removeExtraBlankLinesHandler() {
    note.updateAndSave(textProcessingService.removeExtraBlankLines(note.text));
    textareaDomService.setFocus();
  }

  void doublespaceHandler() {
    note.updateAndSave(textProcessingService.doubleSpaceLines(note.text));
    textareaDomService.setFocus();
  }

  void uriEncodeHandler() {
    note.updateAndSave(textProcessingService.uriEncode(note.text));
    textareaDomService.setFocus();
  }

  void uriDecodeHandler() {
    note.updateAndSave(textProcessingService.uriDecode(note.text));
    textareaDomService.setFocus();
  }

  void htmlUnescapeHandler() {
    note.updateAndSave(textProcessingService.htmlUnescape(note.text));
    textareaDomService.setFocus();
  }

  void dupeHandler() {
    note.updateAndSave(textProcessingService.dupeLines(note.text));
    textareaDomService.setFocus();
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

    textareaDomService.setFocus();
  }

  void timestampDlgHandler() => eventBusService.post("showTimestampDialog");

  void undoHandler() => note.undo();

  void darkThemeHandler() => themeService.theme = "dark";

  void defaultThemeHandler() => themeService.theme = "default";

  void nb8080Handler() =>
      window.open("https://daftspaniel.github.io/demos/nb8080/", 'git');
}
