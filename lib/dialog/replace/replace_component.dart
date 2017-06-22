import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'replace-dialog',
    templateUrl: 'replace_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class ReplaceDialogComponent extends DialogBase implements OnChanges {

  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;
  final EventBusService _eventBusService;
  final ThemeService _themeService;

  @Input()
  TextDocument note;

  String textToReplace;
  String replacementText;
  bool newLine = false;
  String _updatedText;

  int insertPos = -1;

  ReplaceDialogComponent(this._textProcessingService,
      this._textareaDomService, this._eventBusService, this._themeService) {
    this._eventBusService.subscribe("showReplaceDialog", show);
  }

  void closeTheDialog() {
    textToReplace = "";
    close();
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

  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}