import 'dart:async';

import 'package:angular2/angular2.dart' show NgStyle, NgModel, FORM_DIRECTIVES;
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'replace-dialog',
    templateUrl: 'replace_component.html',
    directives: const [NgModel, NgStyle, FORM_DIRECTIVES])
class ReplaceDialogComponent extends DialogBase implements OnChanges {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  String textToReplace;
  String replacementText;
  bool newLine = false;
  String _updatedText;

  int insertPos = -1;

  ReplaceDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    textToReplace = "";
    showDialog = false;
    onShowDialogChange.add(showDialog);
    _textareaDomService.setFocus();
    if (insertPos > 0) {
      _textareaDomService.setCursorPosition(insertPos);
    }
  }

  void appendText() {
    note.text += getUpdatedText();
    note.save();
  }

  String getUpdatedText() {
    _updatedText = _textProcessingService.getReplaced(
        note.text, textToReplace, replacementText);
    return _updatedText;
  }

  void performReplace() {
    if (textToReplace.length > 0) {
      replacementText ??= "";
      if (newLine) {
        replacementText += "\n";
      }

      note.updateAndSave(getUpdatedText());
    }
  }

  void trackCursorPosition(int start) {
    insertPos = start + _updatedText.length;
  }

  @override
  ngOnChanges(Map<String, SimpleChange> changes) {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo();
    insertPos = selInfo.start;
  }
}