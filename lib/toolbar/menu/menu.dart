import 'package:angular/angular.dart';
import 'package:np8080/dialog/common/componentbase.dart';
import 'package:np8080/services/eventbusservice.dart';
import 'package:np8080/services/themeservice.dart';

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
}

class Menu {
  final String name;
  final String tooltip;
  final Function handler;
  final bool separator;

  Menu(this.name, this.handler, this.tooltip, [this.separator = false]);
}
