import 'dart:async';

import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'prepost-dialog',
    templateUrl: 'prepost_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class PrePostDialogComponent extends DialogBase {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  Stream<bool> get showDialogChange => onShowDialogChange.stream;

  String prefix = "";
  String postfix = "";

  PrePostDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    showDialog = false;
    onShowDialogChange.add(showDialog);
    _textareaDomService.setFocus();
  }

  performPrePost() {
    if (prefix.length + postfix.length > 0) {
      String txt = note.text;
      if (prefix.length > 0)
        txt = _textProcessingService.prefixLines(txt, prefix);
      if (postfix.length > 0)
        txt = _textProcessingService.postfixLines(txt, postfix);

      note.updateAndSave(txt);
    }
  }
}