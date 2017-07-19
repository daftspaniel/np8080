import 'package:np8080/src/toolbar/menu/menu.dart';
import 'package:np8080/src/toolbar/toolbar_component.dart';

class MenuDefinition {
  final List<Menu> startMenuItems = new List<Menu>();
  final List<Menu> modifyMenuItems = new List<Menu>();
  final List<Menu> addMenuItems = new List<Menu>();
  final List<Menu> removeMenuItems = new List<Menu>();
  final List<Menu> advancedMenuItems = new List<Menu>();
  final List<Menu> viewMenuItems = new List<Menu>();
  final List<Menu> helpMenuItems = new List<Menu>();

  void buildMenus(ToolbarComponent toolbar) {
    startMenuItems.addAll([
      new Menu("Clear Text", toolbar.clearHandler,
          "Start again with an empty file.", true),
      new Menu("Welcome Text", toolbar.sampleHandler,
          "Put sample text into the file."),
      new Menu("Sample Markdown", toolbar.markdownSampleHandler,
          "Put sample Markdown into the file.")
    ]);

    modifyMenuItems.addAll([
      new Menu("Replace...", toolbar.replaceHandler,
          "Replace some text with some other text."),
      new Menu("Pre/Post...", toolbar.prePostHandler,
          "Add text to start and/or end of lines.", true),
      new Menu(
        "Doublespace",
        toolbar.doublespaceHandler,
        "Double space the lines.",
      ),
      new Menu("Make One Line", toolbar.oneLineHandler,
          "Put all the text onto one line.", true),
      new Menu("Reverse", toolbar.reverseHandler, "Reverse line order."),
      new Menu("Randomise", toolbar.randomHandler, "Random line order."),
      new Menu("Sort", toolbar.sortHandler, "Alphabetically sort lines.")
    ]);

    addMenuItems.addAll([
      new Menu("Timestamp...", toolbar.timestampDlgHandler,
          "Choose a timestamp to add to the document.", true),
      new Menu("Duplicate All", toolbar.duplicateHandler,
          "Append a copy of the entire text to itself."),
      new Menu("Duplicate Lines", toolbar.dupeHandler,
          "Add a copy of a line to itself.", true),
      new Menu("Generate Text...", toolbar.generateHandler,
          "Add generated text to put into document."),
      new Menu("Num Sequence...", toolbar.generateSeqHandler,
          "Add generated number sequence to document.")
    ]);

    removeMenuItems.addAll([
      new Menu("Trim", toolbar.trimFileHandler,
          "Remove proceeding and trailing whitespace from file."),
      new Menu("Trim Lines", toolbar.trimLinesHandler,
          "Remove proceeding and trailing whitespace from each line.", true),
      new Menu("Blank Lines", toolbar.removeBlankLinesHandler,
          "Remove all blank lines."),
      new Menu("Extra Blank Lines", toolbar.removeExtraBlankLinesHandler,
          "Remove extra blank lines.", true),
      new Menu("Lines containing...", toolbar.removeLinesContaining,
          "Remove lines containing a particular string."),
    ]);

    advancedMenuItems.addAll([
      new Menu("Uri Encode", toolbar.uriEncodeHandler,
          "Encode the text for use in a Uri."),
      new Menu("Uri Decode", toolbar.uriDecodeHandler,
          "Decode the text from a Uri.", true),
      new Menu("Unescape HTML", toolbar.htmlUnescapeHandler, "Unescape HTML."),
    ]);

    viewMenuItems.addAll([
      new Menu("Markdown", toolbar.markdownHandler,
          "Show a rendering of Markdown alongside the text.", true),
      new Menu(
          "Dark theme", toolbar.darkThemeHandler, "Switch to a UI dark theme."),
      new Menu("Default theme", toolbar.defaultThemeHandler,
          "Switch to the default theme."),
    ]);

    helpMenuItems.addAll([
      new Menu(
          "About", toolbar.aboutHandler, "Find out more about NP8080", true),
      new Menu("GitHub", toolbar.githubHandler, "Get the source code!"),
      new Menu(
          "Gitter Chat", toolbar.gitterHandler, "Gitter based Chatroom", true),
      new Menu("Notesboard8080", toolbar.nb8080Handler,
          "Try the new Notes Board application")
    ]);
  }
}
