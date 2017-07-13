import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

abstract class DialogBase {
  final ThemeService themeService;
  final EventBusService eventBusService;
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