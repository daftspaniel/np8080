import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'prepost-dialog',
    templateUrl: 'prepost_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class PrePostDialogComponent {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  String prefix;
  String postfix;

  PrePostDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    showDialog = false;
    showDialogChange.emit(showDialog);
    _textareaDomService.setFocus();
  }

  performPrePost() {
    String txt = note.text;
    txt = _textProcessingService.prefixLines(txt, prefix);
    txt = _textProcessingService.postfixLines(txt, postfix);
    note.updateAndSave(txt);
  }
}