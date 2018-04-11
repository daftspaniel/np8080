import 'package:angular/angular.dart';
// ignore: uri_has_not_been_generated
import 'rootinjector.template.dart' as mainng;

import 'package:np8080/src/services/documentservice.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/textareadomservice.dart';
import 'package:np8080/src/services/textprocessingservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@GenerateInjector(const [
  const ClassProvider(EventBusService),
  const ClassProvider(TextProcessingService),
  const ClassProvider(TextareaDomService),
  const ClassProvider(ThemeService),
  const ClassProvider(DocumentService),
])
final rootInjector = mainng.rootInjector$Injector;
