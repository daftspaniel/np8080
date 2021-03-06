import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/dialog/deletelines/deletelinesdialog.dart';
import 'package:np8080/src/dialog/generate/generatedialog.dart';
import 'package:np8080/src/dialog/prepost/prepostdialog.dart';
import 'package:np8080/src/dialog/replace/replacedialog.dart';
import 'package:np8080/src/dialog/sequence/sequencedialog.dart';
import 'package:np8080/src/dialog/splice/splicedialog.dart';
import 'package:np8080/src/dialog/split/splitdialog.dart';
import 'package:np8080/src/dialog/themes/themesdialog.dart';
import 'package:np8080/src/dialog/timestamp/timestampdialog.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/editablelabel/editablelabel.dart';
import 'package:np8080/src/editor/views/markdownpreview.dart';
import 'package:np8080/src/editor/statuspanel.dart';
import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/resources/templates.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/storage/localstorage.dart';
import 'package:np8080/src/storage/storagekeys.dart';
import 'package:np8080/src/toolbar/toolbar.dart';

@Component(selector: 'plain-editor', templateUrl: 'editor.html', directives: [
  StatusPanel,
  Toolbar,
  GenerateDialog,
  ReplaceDialog,
  PrePostDialog,
  SequenceDialog,
  DeleteLinesDialog,
  MarkdownPreview,
  EditableLabel,
  TimestampDialog,
  ThemesDialog,
  SplitDialog,
  SpliceDialog,
  NgFor,
  NgModel,
  NgStyle,
  NgIf,
  NgClass,
  formDirectives
])
class EditorComponent extends EditorComponentBase implements AfterContentInit {
  final _undoPositions = List<int>();

  @Input()
  TextDocument note;

  var showPreview = false;

  EditorComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    themeService.load();
    showPreview = loadValue(MarkdownPreviewVisibleKey, '').length > 0;

    eventBusService.subscribe('closeEditorTabPrompt', closeEditorTabHandler);
    eventBusService.subscribe('resetTextToSample', closeHandler);

    eventBusService.subscribe('resetTextToWeekPlanner', weekPlannerHandler);
    eventBusService.subscribe('resetTextToTodo', todoHandler);
    eventBusService.subscribe('resetTextToPMI', pmiHandler);
    eventBusService.subscribe('resetTextToSMART', smartHandler);
    eventBusService.subscribe('resetTextToHTML', htmlHandler);
    eventBusService.subscribe('ShowMarkdownPreview', () => showPreview = true);
    eventBusService.subscribe('HideMarkdownPreview', () => showPreview = false);
  }

  void changeHandler() => note.save();

  void storeStateForUndo(int cursorPos) => _undoPositions.add(cursorPos);

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 9) {
      return tabHandler(e);
    } else if (e.keyCode == 33 || e.keyCode == 34) {
      e.stopPropagation();
      return false;
    } else if (e.keyCode == 90 && e.ctrlKey == true) {
      note.undo();
      return false;
    } else if (e.keyCode == 81 && e.ctrlKey == true) {
      eventBusService.post('showReplaceDialog');
    } else if (e.keyCode == 77 && e.ctrlKey == true) {
      eventBusService
          .post(showPreview ? 'HideMarkdownPreview' : 'ShowMarkdownPreview');
    }

    return true;
  }

  bool tabHandler(KeyboardEvent e) {
    e.preventDefault();
    var selInfo = textareaDomService.getCurrentSelectionInfo();

    if (selInfo.text.length > 0) {
      var out = note.text.substring(0, selInfo.start);
      var tabbedText = textProcessingService.prefixLines(selInfo.text, tab);
      out += tabbedText + note.text.substring(selInfo.end);
      textareaDomService.setText(out);
      textareaDomService.setCursorPosition(selInfo.start + tabbedText.length);
    } else {
      textareaDomService.setText(note.text.substring(0, selInfo.start) +
          tab +
          note.text.substring(selInfo.end));
      textareaDomService.setCursorPosition(selInfo.start + tab.length);
    }

    note.updateAndSave(textareaDomService.getText());
    return false;
  }

  void closeEditorTabHandler() => closeHandler(true);

  void resetToTemplate(String templateContent, bool resetFilename) {
    if (note.empty ||
        window
            .confirm("Are you sure you want to clear the current document?")) {
      if (resetFilename) eventBusService.post('resetEditableLabel');
      note.updateAndSave(templateContent);
    }
    textareaDomService.setFocus();
  }

  void closeHandler([bool resetFilename = true]) =>
      resetToTemplate(welcomeText, resetFilename);

  void weekPlannerHandler([bool resetFilename = true]) =>
      resetToTemplate(WeekPlanner, resetFilename);

  void todoHandler([bool resetFilename = true]) =>
      resetToTemplate(TodoTemplate, resetFilename);

  void pmiHandler([bool resetFilename = true]) =>
      resetToTemplate(PMITemplate, resetFilename);

  void smartHandler([bool resetFilename = true]) =>
      resetToTemplate(SMARTTemplate, resetFilename);

  void htmlHandler([bool resetFilename = true]) =>
      resetToTemplate(WebStarterHtml, resetFilename);

  void ngAfterContentInit() {
    eventBusService
        .post(showPreview ? 'ShowMarkdownPreview' : 'HideMarkdownPreview');
  }
}
