import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'dualreader-view',
    templateUrl: 'dualreaderview.html',
    visibility: Visibility.none,
    directives: const [NgModel, NgStyle, NgClass, formDirectives])
class DualReaderView extends ComponentBase {
  DualReaderView(
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    eventBusService.subscribe("showDualReaderView", showReader);
  }

  @Input()
  TextDocument note1;

  @Input()
  TextDocument note2;

  bool lockScrolling = true;

  void showReader() {
    show();
  }
}
