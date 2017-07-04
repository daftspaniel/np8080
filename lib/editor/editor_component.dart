import 'dart:html';

import 'package:angular2/angular2.dart'
    show NgFor, NgModel, NgStyle, NgIf, NgClass, FORM_DIRECTIVES;
import 'package:angular2/core.dart';
import 'package:np8080/dialog/about/about_component.dart';
import 'package:np8080/dialog/deletelines/deletelines_component.dart';
import 'package:np8080/dialog/generate/generate_component.dart';
import 'package:np8080/dialog/prepost/prepost_component.dart';
import 'package:np8080/dialog/replace/replace_component.dart';
import 'package:np8080/dialog/sequence/sequence_component.dart';
import 'package:np8080/dialog/timestamp/timestamp_component.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/editablelabel/editablelabel_component.dart';
import 'package:np8080/editor/preview_component.dart';
import 'package:np8080/editor/status_component.dart';
import 'package:np8080/resources/resources.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'package:np8080/storage/localstorage.dart';
import 'package:np8080/storage/storagekeys.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

@Component(
    selector: 'plain-editor',
    templateUrl: 'editor_component.html',
    directives: const [
      StatusComponent,
      ToolbarComponent,
      AboutDialogComponent,
      GenerateDialogComponent,
      ReplaceDialogComponent,
      PrePostDialogComponent,
      SequenceDialogComponent,
      DeleteLinesDialogComponent,
      PreviewComponent,
      EditableLabelComponent,
      TimestampDialogComponent,
      NgFor, NgModel, NgStyle, NgIf, NgClass, FORM_DIRECTIVES
    ])
class EditorComponent {
  final TextareaDomService _textareaDomService;
  final TextProcessingService _textProcessingService;
  final ThemeService _themeService;

  final List<int> _undoPositions = new List<int>();

  EditorComponent(this._textareaDomService, this._textProcessingService,
      this._themeService) {
    _themeService.load();
    showPreview = loadValue(MarkdownPreviewVisibleKey, "").length > 0;
  }

  @Input()
  TextDocument note;

  bool showAboutDialog = false;

  bool showGenerateDialog = false;

  bool showSeqDialog = false;

  bool showReplaceDialog = false;

  bool showPreview = false;

  bool showPrePostDialog = false;

  bool showDeleteLinesDialog = false;

  void changeHandler() {
    note.save();
  }

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 9) {
      return tabHandler(e);
    }
    else if (e.keyCode == 90 && e.ctrlKey == true) {
      note.undo();
      return false;
    }

    return true;
  }

  bool tabHandler(KeyboardEvent e) {
    e.preventDefault();
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

    if (selInfo.text.length > 0) {
      String out = note.text.substring(0, selInfo.start);
      String tabbedText = _textProcessingService.prefixLines(
          selInfo.text, tab);
      out += tabbedText;
      out += note.text.substring(selInfo.end);
      _textareaDomService.setText(out);
      _textareaDomService.setCursorPosition(
          selInfo.start + tabbedText.length);
    }
    else {
      _textareaDomService.setText(
          note.text.substring(0, selInfo.start) +
              tab +
              note.text.substring(selInfo.end));
      _textareaDomService.setCursorPosition(selInfo.start + tab.length);
    }

    note.updateAndSave(_textareaDomService.getText());
    return false;
  }

  void storeStateForUndo(int cursorPos) {
    _undoPositions.add(cursorPos);
  }

  String getClass() {
    return _themeService.getMainClass();
  }

  String getTextareaClass() {
    return _themeService.getDocumentClass();
  }

}