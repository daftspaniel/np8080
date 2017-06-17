abstract class DialogBase {

  bool showDialog = false;

  DialogBase();

  void show() {
    showDialog = true;
  }

  void close() {
    showDialog = false;
  }
}