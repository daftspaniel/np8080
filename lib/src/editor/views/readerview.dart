import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';

@Component(
    selector: 'reader-view',
    templateUrl: 'readerview.html',
    visibility: Visibility.none,
    directives: const [NgModel, NgStyle, NgClass])
class ReaderView extends ComponentBase {
  ReaderView(ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService) {
    eventBusService.subscribe("showReaderView", showReader);
  }

  @Input()
  TextDocument note;

  void showReader() {
    show();
  }
}
