import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/npdialogbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'generate-dialog',
    templateUrl: 'generate_component.html',
    directives: const [NgClass, NgModel, NgStyle, NgClass, FORM_DIRECTIVES])
class GenerateDialogComponent extends NpEditDialogBase {

  String textToRepeat;

  num repeatCount = 10;

  bool newLine = false;

  GenerateDialogComponent(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newTextProcessingService,
      newTextareaDomService, newthemeService,
      newEventBusService) {
    eventBusService.subscribe("showGenerateDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    textToRepeat = "";
    show();
  }

  String getGeneratedText() {
    if (textToRepeat == null) return '';

    generatedText = textProcessingService.getRepeatedString(
        textToRepeat, repeatCount, newLine);
    return generatedText;
  }

}