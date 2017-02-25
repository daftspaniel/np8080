import 'package:np8080/toolbar/menu/menu.dart';
import 'package:np8080/toolbar/toolbar_component.dart';

class MenuDefinition {

  List<Menu> initMenuItems;
  List<Menu> modifyMenuItems;
  List<Menu> addMenuItems;
  List<Menu> removeMenuItems;
  List<Menu> viewMenuItems;
  List<Menu> helpMenuItems;


  void buildMenus(ToolbarComponent toolbar) {
    initMenuItems = [
      new Menu(
          "Clear Text", toolbar.clearHandler, "Start again with an empty file.")
    ];

    modifyMenuItems =
    [
      new Menu(
          "Doublespace", toolbar.doublespaceHandler, "Double space the lines.",
          true),
      new Menu("Reverse", toolbar.reverseHandler, "Reverse line order."),
      new Menu("Randomise", toolbar.randomHandler, "Random line order."),
      new Menu("Sort", toolbar.sortHandler, "Alphabetically sort lines.", true),
      new Menu("Replace...", toolbar.replaceHandler,
          "Replace some text with some other text."),
      new Menu("Pre/Post...", toolbar.prePostHandler,
          "Add text to start and/or end of lines."),
    ];

    addMenuItems = [
      new Menu(
          "Timestamp", toolbar.timestampHandler,
          "Add a timestamp to the document.",
          true),
      new Menu("Duplicate", toolbar.duplicateHandler,
          "Append a copy of the entire text to itself."),
      new Menu("Duplicate lines", toolbar.dupeHandler,
          "Add a copy of a line to itself.", true),
      new Menu("Generate Text...", toolbar.generateHandler,
          "Add generated text to put into document."),
      new Menu("Num Sequence...", toolbar.generateSeqHandler,
          "Add generated number sequence to document."),
    ];

    removeMenuItems = [
      new Menu(
          "Trim", toolbar.trimFileHandler,
          "Remove proceeding and trailing whitespace from file."),
      new Menu(
          "Trim Lines", toolbar.trimLinesHandler,
          "Remove proceeding and trailing whitespace from each line.",
          true),
      new Menu(
          "Blank Lines", toolbar.removeBlankLinesHandler,
          "Remove all blank lines."),
      new Menu("Extra Blank Lines", toolbar.removeExtraBlankLinesHandler,
          "Remove extra blank lines."),
    ];

    viewMenuItems = [
      new Menu("Markdown", toolbar.markdownHandler,
          "Show a rendering of Markdown alongside the text.")
    ];

    helpMenuItems = [
      new Menu(
          "About", toolbar.aboutHandler, "Find out more about NP8080", true),
      new Menu("GitHub", toolbar.githubHandler, "Get the source code!"),
      new Menu("Gitter Chat", toolbar.gitterHandler, "Gitter based Chatroom")
    ];
  }
}