import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'dialog_base.dart';

abstract class NpEditDialogBase extends DialogBase {
  TextProcessingService textProcessingService;
  TextareaDomService textareaDomService;

  NpEditDialogBase(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newthemeService, newEventBusService) {
    textProcessingService = newTextProcessingService;
    textareaDomService = newTextareaDomService;
  }
}
