import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/document/textdocument.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'dart:html';

@Component(
    selector: 'dualreader-view',
    templateUrl: 'dualreaderview.html',
    directives: [NgModel, NgStyle, NgClass, formDirectives])
class DualReaderView extends ComponentBase implements AfterContentInit {
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
  TextAreaElement rightText;
  TextAreaElement leftText;

  void showReader() => show();

  scrollLeft(var e) {
    if (lockScrolling) rightText.scrollTop = leftText.scrollTop;
  }

  scrollRight(var e) {
    if (lockScrolling) leftText.scrollTop = rightText.scrollTop;
  }

  void ngAfterContentInit() {
    rightText = querySelector('#rightText');
    leftText = querySelector('#leftText');
  }
}
