import 'package:angular/angular.dart';
import 'package:np8080/src/dialog/common/componentbase.dart';
import 'package:np8080/src/services/eventbusservice.dart';
import 'package:np8080/src/services/themeservice.dart';
import 'package:np8080/src/toolbar/menu_definition.dart';

@Component(
    selector: 'menu',
    directives: const [NgFor, NgModel, NgStyle, NgIf, NgClass],
    templateUrl: 'menu_template.html')
class MenuComponent extends ComponentBase {
  MenuComponent(
      ThemeService newthemeService, EventBusService newEventBusService)
      : super(newthemeService, newEventBusService);

  @Input('menutitle')
  String menutitle;

  @Input('items')
  List<Menu> items;

  void menuClick(Function handler) {
    close();
    handler();
  }

  String getMenuClass() =>
      themeService.mainClass + " " + themeService.highlightClass;

  String getFooterClass() =>
      themeService.mainClass + " " + themeService.borderClass;

  String getBorderClass() => themeService.borderClass;
}
