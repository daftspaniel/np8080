import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

abstract class ComponentBase {
  final ThemeService themeService;
  final EventBusService eventBusService;
  bool showComponent = false;

  ComponentBase(this.themeService, this.eventBusService);

  void show() => showComponent = true;

  void close() => showComponent = false;

  String getClass() => themeService.getMainClass();

  String getHeaderClass() => themeService.getSecondaryClass();
}
