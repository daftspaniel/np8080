import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';

abstract class NpEditDialogBase extends DialogBase {
  TextProcessingService textProcessingService;
  TextareaDomService textareaDomService;

  NpEditDialogBase(TextProcessingService newTextProcessingService,
      TextareaDomService newTextareaDomService,
      ThemeService newthemeService, EventBusService newEventBusService)
      :super(newthemeService, newEventBusService) {
    textProcessingService = newTextProcessingService;
    textareaDomService = newTextareaDomService;
  }
}

abstract class DialogBase {
  ThemeService themeService;
  EventBusService eventBusService;
  bool showDialog = false;

  DialogBase(this.themeService, this.eventBusService);

  void show() {
    showDialog = true;
  }

  void close() {
    showDialog = false;
  }

  String getClass() {
    return themeService.getMainClass();
  }

  String getHeaderClass() {
    return themeService.getSecondaryClass();
  }
}