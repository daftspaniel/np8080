import 'package:angular2/angular2.dart';
import 'package:angular2/angular2.dart' show NgStyle, NgModel, NgIf;
import 'package:angular2/core.dart';
import 'package:np8080/services/themeservice.dart';

@Component(
    selector: 'menu',
    directives: const [NgFor, NgModel, NgStyle, NgIf, NgClass],
    templateUrl: 'menu_template.html')
class MenuComponent {

  final ThemeService _themeService;
  String display = "none";

  MenuComponent(this._themeService);

  @Input('menutitle')
  String menutitle;

  @Input('items')
  List<Menu> items;

  void hide() {
    display = "none";
  }

  void show() {
    display = "block";
  }

  String getClass() {
    return _themeService.getMainClass();
  }

}

class Menu {
  String name;
  String tooltip;
  Function handler;
  bool separator;

  Menu(this.name, this.handler, this.tooltip, [this.separator = false]);
}