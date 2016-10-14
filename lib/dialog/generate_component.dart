import 'package:angular2/core.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textprocessingservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    providers: const [TextProcessingService])
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

  GenerateDialogComponent(this._textProcessingService);

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
}