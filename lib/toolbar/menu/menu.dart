import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';

@Component(
    selector: 'menu',
    directives: const [NgFor],
    templateUrl: 'menu_template.html')
class MenuComponent {

  String display = "none";

  MenuComponent();

  @Input('menutitle')
  String menutitle;

  @Input('items')
  List items;

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

  Menu(this.name, this.handler, this.tooltip);
}