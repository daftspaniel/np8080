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

  void timestampDlgHandler() => eventBusService.post("showTimestampDialog");

  void undoHandler() => note.undo();

  void darkThemeHandler() => themeService.theme = "dark";

  void defaultThemeHandler() => themeService.theme = "default";

  void nb8080Handler() =>
      window.open("https://daftspaniel.github.io/demos/nb8080/", 'git');

  void githubHandler() =>
      window.open("https://github.com/daftspaniel/np8080", 'github');

  void gitterHandler() =>
      window.open("https://gitter.im/np8080/Lobby", 'gitter');
}
