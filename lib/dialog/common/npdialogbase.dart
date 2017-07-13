import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/textareadomservice.dart';
import 'package:np8080/services/textprocessingservice.dart';
import 'package:np8080/services/themeservice.dart';
import 'dialog_base.dart';

abstract class NpEditDialogBase extends DialogBase {
  final TextProcessingService textProcessingService;
  final TextareaDomService textareaDomService;

  NpEditDialogBase(this.textProcessingService,
      this.textareaDomService,
      ThemeService newthemeService,
      EventBusService newEventBusService)
      :super(newthemeService, newEventBusService) {
  }
}
