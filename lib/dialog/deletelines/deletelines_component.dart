import 'dart:async';

import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'delete-lines-dialog',
    templateUrl: 'deletelines_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class DeleteLinesDialogComponent extends DialogBase {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  String markerText;
  String _updatedText;

  int insertPos = -1;

  DeleteLinesDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    markerText = "";
    showDialog = false;
    onShowDialogChange.add(showDialog);
    _textareaDomService.setFocus();
  }

  void ammendText() {
    note.text = getUpdatedText();
    note.save();
  }

  String getUpdatedText() {
    _updatedText = _textProcessingService.deleteLinesContaining(
        note.text, markerText);
    return _updatedText;
  }

  void performDelete() {
    if (markerText.length > 0) {
      note.updateAndSave(getUpdatedText());
    }
  }
}