import 'dart:async';

import 'package:angular2/angular2.dart' show NgStyle, NgModel, FORM_DIRECTIVES;
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    directives: const [NgModel, NgStyle, FORM_DIRECTIVES])
class GenerateDialogComponent extends DialogBase {
  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  String textToRepeat;
  String _generatedText;

  num repeatCount = 10;
  int insertPos = -1;
  bool newLine = false;

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  GenerateDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    textToRepeat = "";
    showDialog = false;
    onShowDialogChange.add(showDialog);
    _textareaDomService.setFocus();
    if (insertPos > 0) {
      _textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    String newText = note.text + getGeneratedText();
    saveAndUpdateState(newText, note.text.length);
  }

  String getGeneratedText() {
    _generatedText = _textProcessingService.getRepeatedString(
        textToRepeat, repeatCount, newLine);
    return _generatedText;
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();

    String newText = note.text.substring(0, selInfo.start) +
        getGeneratedText() +
        note.text.substring(selInfo.start);

    saveAndUpdateState(newText, selInfo.start);
  }

  void saveAndUpdateState(String newNoteText, int cursorPos) {
    note.updateAndSave(newNoteText);
    insertPos = cursorPos + _generatedText.length;
  }

}