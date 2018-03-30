import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'sequence-dialog',
    templateUrl: 'sequencedialog.html',
    preserveWhitespace: true,
    directives: const [NgClass, NgModel, NgStyle, formDirectives])
class SequenceDialog extends EditorComponentBase {
  num startIndex = 10;
  num repeatCount = 10;
  num increment = 10;

  SequenceDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showSequenceDialog", initialiseAndShow);
  }

  void initialiseAndShow() {
    setFocus("#startTextbox");
    show();
  }

  String getGeneratedText() {
    generatedText = textProcessingService.generateSequenceString(
        startIndex, repeatCount, increment);
    return generatedText;
  }
}
