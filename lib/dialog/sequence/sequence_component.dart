import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'sequence-dialog',
    templateUrl: 'sequence_component.html',
    directives: const [NgClass, NgModel, NgStyle, FORM_DIRECTIVES])
class SequenceDialogComponent extends NpEditDialogBase {
  num startIndex = 10;
  num repeatCount = 10;
  num increment = 10;

  SequenceDialogComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showSequenceDialog", show);
  }

  String getGeneratedText() {
    generatedText = textProcessingService.getSequenceString(
        startIndex, repeatCount, increment);
    return generatedText;
  }
}
