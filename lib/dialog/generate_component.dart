import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    providers: const [TextProcessingService, TextareaDomService])
class GenerateDialogComponent {
  @Input()
  bool showDialog = false;

  @Input()
  TextDocument note;

  @Output()
  EventEmitter<bool> showDialogChange = new EventEmitter<bool>();

  String textToRepeat;
  num repeatCount = 10;

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;

  GenerateDialogComponent(this._textProcessingService,
      this._textareaDomService);

  void closeTheDialog() {
    textToRepeat = "";
    showDialog = false;
    showDialogChange.emit(showDialog);
  }

  void onSubmit() {
    note.text +=
        _textProcessingService.getRepeatedString(textToRepeat, repeatCount);
    note.save();
  }

  void insertCurrentPosition() {
    TextareaSelection selInfo = _textareaDomService.getCurrentSelectionInfo(
        '#nptextbox');

    String generatedText = _textProcessingService.getRepeatedString(
        textToRepeat, repeatCount);

    note.text = note.text.substring(0, selInfo.start) + generatedText +
        note.text.substring(selInfo.start);

    note.save();
  }
}