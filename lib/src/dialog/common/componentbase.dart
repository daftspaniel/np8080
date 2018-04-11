import 'dart:async';
import 'dart:html';

abstract class ComponentBase {
  final themeService;
  final eventBusService;

  bool showComponent = false;

  ComponentBase(this.themeService, this.eventBusService);

  void show() => showComponent = true;

  void close() => showComponent = false;

  String get display => showComponent ? 'block' : 'none';

  String getClass() => themeService.mainClass;

  String getHeaderClass() => themeService.secondaryClass;

  String getBackgroundClass() => themeService.tertiaryClass;

  String getDocumentClass() => themeService.documentClass;

  String getHighlightClass() => themeService.highlightClass;

  String getBorderClass() => themeService.borderClass;

  void setFocus(String id) {
    Timer(Duration(milliseconds: 454), () => querySelector(id)?.focus());
  }
}
