import 'dart:async';
import 'dart:html';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

abstract class ComponentBase {
  final ThemeService themeService;
  final EventBusService eventBusService;

  bool showComponent = false;

  ComponentBase(this.themeService, this.eventBusService);

  void show() => showComponent = true;

  void close() => showComponent = false;

  String get display => showComponent ? 'block' : 'none';

  String getClass() => themeService.mainClass;

  String getHeaderClass() => themeService.secondaryClass;

  String getDocumentClass() => themeService.documentClass;

  void setFocus(String id) {
    new Timer(
        new Duration(milliseconds: 454), () => querySelector(id)?.focus());
  }
}
