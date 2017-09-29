import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:intl/intl.dart';
import 'package:np8080/src/dialog/common/editorcomponentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'timestamp-dialog',
    visibility: Visibility.none,
    templateUrl: 'timestampdialog.html',
    directives: const [
      NgFor,
      NgClass,
      NgModel,
      NgStyle,
      NgSelectOption,
      formDirectives
    ])
class TimestampDialog extends EditorComponentBase {
  final List<String> times = new List<String>();
  final String defaultCustomFormat = 'yyyy-MM-dd EEEE h:m:ss a';

  String timeStamp = '';
  String customTimeStamp = '';
  String customFormat;

  bool useCustomFormat = false;

  TimestampDialog(
      TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newThemeService,
      EventBusService newEventBusService)
      : super(newTextProcessingService, newTextareaDomService, newThemeService,
            newEventBusService) {
    eventBusService.subscribe("showTimestampDialog", initialiseAndShow);
    updateTime();
    timeStamp = times[0];
    customFormat = defaultCustomFormat;
  }

  void initialiseAndShow() {
    show();
    setFocus('#patternSelect');
  }

  String customFormattedDate() {
    return formatDateTime(new DateTime.now(), customFormat);
  }

  String getGeneratedText() {
    generatedText = useCustomFormat ? customTimeStamp : timeStamp;
    return generatedText;
  }

  bool keyHandler(KeyboardEvent e) {
    // TAB key
    if (e.keyCode == 13) {
      appendText();
    }
    return true;
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
