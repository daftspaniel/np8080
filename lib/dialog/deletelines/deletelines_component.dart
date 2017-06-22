import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:np8080/dialog/common/dialog_base.dart';
import 'package:np8080/document/textdocument.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'delete-lines-dialog',
    templateUrl: 'deletelines_component.html',
    directives: const[NgModel, NgClass, FORM_DIRECTIVES]
)
class DeleteLinesDialogComponent extends DialogBase {

  final ThemeService _themeService;
  final TextProcessingService _textProcessingService;
  final TextareaDomService _textareaDomService;
  final EventBusService _eventBusService;

  @Input()
  TextDocument note;

  String markerText;
  String _updatedText;

  int insertPos = -1;

  DeleteLinesDialogComponent(this._textProcessingService,
      this._textareaDomService,
      this._eventBusService,
      this._themeService) {
    _eventBusService.subscribe("showDeleteLinesDialog", show);
  }

  void closeTheDialog() {
    markerText = "";
    close();
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

  String getClass() {
    return _themeService.getMainClass();
  }

  String getHeaderClass() {
    return _themeService.getSecondaryClass();
  }
}