import 'package:angular/angular.dart';
import 'package:angular/core.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
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
class DeleteLinesDialogComponent extends NpEditDialogBase {

  @Input()
  TextDocument note;

  String markerText;
  String _updatedText;

  int insertPos = -1;

  DeleteLinesDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService, newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showDeleteLinesDialog", show);
  }

  void closeTheDialog() {
    markerText = "";
    close();
    textareaDomService.setFocus();
  }

  void ammendText() {
    note.text = getUpdatedText();
    note.save();
    closeTheDialog();
  }

  String getUpdatedText() {
    _updatedText = textProcessingService.deleteLinesContaining(
        note.text, markerText);
    return _updatedText;
  }

  void performDelete() {
    if (markerText.length > 0) {
      note.updateAndSave(getUpdatedText());
    }
  }
}