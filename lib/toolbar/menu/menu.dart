import 'package:angular2/angular2.dart';
import 'package:angular2/angular2.dart' show NgStyle, NgModel, NgIf;
import 'package:angular2/core.dart';

@Component(
    selector: 'menu',
    directives: const [NgFor, NgModel, NgStyle, NgIf],
    templateUrl: 'menu_template.html')
class MenuComponent {

  String display = "none";

  MenuComponent();

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


}

class Menu {
  String name;
  String tooltip;
  var handler;
  bool separator;

  Menu(this.name, this.handler, this.tooltip, [this.separator = false]);
}