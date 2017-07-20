import 'package:angular/angular.dart';
import 'package:intl/intl.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'timestamp-dialog',
    templateUrl: 'timestamp_component.html',
    directives: const [
      NgFor,
      NgClass,
      NgModel,
      NgStyle,
      NgSelectOption,
      FORM_DIRECTIVES
    ])
class TimestampDialogComponent extends EditorComponentBase {
  final List<String> times = new List<String>();

  String timeStamp = '';
  String customTimeStamp = '';
  bool useCustomFormat = false;
  final String defaultCustomFormat = 'yyyy-MM-dd EEEE h:m:ss a';
  String customFormat;

  TimestampDialogComponent(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showTimestampDialog", show);
    updateTime();
    timeStamp = times[0];
    customFormat = defaultCustomFormat;
  }

  String customFormattedDate() {
    return formatDateTime(new DateTime.now(), customFormat);
  }

  String getGeneratedText() {
    generatedText = useCustomFormat ? customTimeStamp : timeStamp;
    return generatedText;
  }

  void updateTime() {
    DateTime currentTime = new DateTime.now();
    times.clear();
    times.addAll([
      currentTime.toString(),
      formatDateTime(currentTime, 'EEEE h:m a'),
      formatDateTime(currentTime, 'EEEE H:m'),
      formatDateTime(currentTime, 'yyyy-MM-dd'),
      formatDateTime(currentTime, 'h:m:ss'),
      formatDateTime(currentTime, 'H:m:ss'),
      formatDateTime(currentTime, 'EEEE H:m:ss'),
      formatDateTime(currentTime, 'EEEE h:m:ss a')
    ]);
    timeStamp = currentTime.toString();
    updateCustom(true);
  }

  void updateCustom([bool initialising = false]) {
    try {
      if (!initialising) useCustomFormat = true;
      customTimeStamp = customFormattedDate();
    } catch (Exception) {
      customTimeStamp = 'Error in format string.';
    }
  }

  String formatDateTime(DateTime dateTime, String pattern) {
    return new DateFormat(pattern).format(dateTime);
  }

  void resetCustomFormat() {
    customFormat = defaultCustomFormat;
    updateCustom();
  }
}
