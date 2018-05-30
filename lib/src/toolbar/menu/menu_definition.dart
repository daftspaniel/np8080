import 'package:np8080/src/resources/resources.dart';
import 'package:np8080/src/toolbar/menu/menu.dart';
import 'package:np8080/src/toolbar/toolbar.dart';

class MenuDefinition {
  final startMenuItems = List<Menu>();
  final modifyMenuItems = List<Menu>();
  final addMenuItems = List<Menu>();
  final removeMenuItems = List<Menu>();
  final advancedMenuItems = List<Menu>();
  final viewMenuItems = List<Menu>();
  final helpMenuItems = List<Menu>();

  void buildMenus(Toolbar toolbar) {
    startMenuItems.addAll([
      Menu("Clear Text", toolbar.clearHandler,
          "Start again with an empty file.", true),
      Menu("Welcome Text", toolbar.sampleHandler,
          "Put sample text into the file."),
      Menu("Markdown", toolbar.markdownSampleHandler,
          "Put sample Markdown into the file.", true),
      Menu("Todo Template", toolbar.todoHandler,
          "Put a Todo list template into the file."),
      Menu("PMI Template", toolbar.pmiHandler,
          "Put a PMI list template into the file."),
      Menu("SMART Goal", toolbar.smartHandler,
          "Put a SMART Goal template into the file.", true),
      Menu("Week Planner", toolbar.weekPlannerHandler,
          "Put a week long planning template into the file."),
      Menu("HTML Starter", toolbar.htmlHandler,
          "Put an HTML template into the file.")
    ]);

    modifyMenuItems.addAll([
      Menu("Replace...", toolbar.replaceHandler,
          "Replace text with different text.\nShortcut - Ctrl + Q"),
      Menu("Pre/Post...", toolbar.prePostHandler,
          "Add text to start and/or end of lines.", true),
      Menu("Number", toolbar.numberHandler, "Number non-blank lines."),
      Menu("Tabs to Spaces", toolbar.tabsToSpaces,
          "Convert tab characters to spaces."),
      Menu("Doublespace", toolbar.doublespaceHandler, "Double space the lines.",
          true),
      Menu("Split...", toolbar.splitHandler,
          "Split into separate lines by a delimiter."),
      Menu("Single Line", toolbar.oneLineHandler,
          "Put all the text onto one line.", true),
      Menu("Reverse", toolbar.reverseHandler, "Reverse the line order."),
      Menu("Randomise", toolbar.randomHandler, "Randomise the line order.",
          true),
      Menu("Sort A to Z", toolbar.sortAZHandler, "Alphabetically sort lines."),
      Menu("Sort by Line Length", toolbar.sortLineLengthHandler,
          "Sort lines by length - shortest to longest.")
    ]);

    addMenuItems.addAll([
      Menu("Lorem Ipsum", toolbar.loremIpsumHandler, "Add Lorem Ipsum text.",
          true),
      Menu("Timestamp...", toolbar.timestampDlgHandler,
          "Choose a timestamp to add to the text.", true),
      Menu("Duplicate All", toolbar.duplicateHandler,
          "Append a copy of the entire text to itself."),
      Menu("Duplicate Lines", toolbar.dupeHandler,
          "Add a copy of each line to itself."),
      Menu("Duplicate Current", toolbar.duplicateCurrentLine,
          "Duplicate the current line.", true),
      Menu("Generate Text...", toolbar.generateHandler,
          "Add generated text into text."),
      Menu("Num Sequence...", toolbar.generateSeqHandler,
          "Add generated number sequence to text.")
    ]);

    removeMenuItems.addAll([
      Menu("Trim File", toolbar.trimFileHandler,
          "Remove proceeding and trailing whitespace from file."),
      Menu("Trim Lines", toolbar.trimLinesHandler,
          "Remove proceeding and trailing whitespace from each line."),
      Menu("Trim & Squash", toolbar.trimSquashHandler,
          "Trim lines and squash whitespace in each line.", true),
      Menu("Splice...", toolbar.spliceHandler,
          "Chops a number of characters of start and end of each line.", true),
      Menu("Blank Lines", toolbar.removeBlankLinesHandler,
          "Remove all blank lines."),
      Menu("Extra Blank Lines", toolbar.removeExtraBlankLinesHandler,
          "Remove extra blank lines.", true),
      Menu("Lines Containing...", toolbar.removeLinesContaining,
          "Remove lines containing (or NOT) a string."),
    ]);

    advancedMenuItems.addAll([
      Menu("Uri Encode", toolbar.uriEncodeHandler,
          "Encode the text for use in a Uri."),
      Menu("Uri Decode", toolbar.uriDecodeHandler,
          "Decode the text from a Uri.", true),
      Menu("Unescape HTML", toolbar.htmlUnescapeHandler, "Unescape HTML."),
    ]);

    viewMenuItems.addAll([
      Menu("Themes...", toolbar.themesHandler,
          "Choose a colour theme for NP8080."),
      Menu("Markdown", toolbar.markdownHandler,
          "Show a preview of MD.\nShortcut - Ctrl + M", true),
      Menu("Side By Side", toolbar.dualReaderHandler,
          "Show texts alongside each other."),
      Menu("Reader", toolbar.readerHandler,
          "Show a full screen read-only view of the text.")
    ]);

    helpMenuItems.addAll([
      Menu("About...", toolbar.aboutHandler, "Find out more about NP8080."),
      Menu("Manual...", toolbar.manualHandler, "Read the NP8080 manual.", true),
      Menu("🌎 What's New?", toolbar.whatsNewHandler,
          "Find out what's changed! - Hosted on Github.com.", true),
      Menu("🌎 GitHub", toolbar.githubHandler,
          "Get the source code - Hosted on Github.com."),
      Menu("🌎 Gitter Chat", toolbar.gitterHandler,
          "Gitter based Chatroom - Hosted on Gitter.com.")
    ]);

    buildManual();
  }

  void buildManual() {
    var allMenus = List<Menu>();
    var blank = Menu(' ');

    allMenus.add(Menu("Start Menu"));
    allMenus.add(blank);
    allMenus.addAll(startMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("Modify Menu"));
    allMenus.add(blank);
    allMenus.addAll(modifyMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("Add Menu"));
    allMenus.add(blank);
    allMenus.addAll(addMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("Remove Menu"));
    allMenus.add(blank);
    allMenus.addAll(removeMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("Advanced Menu"));
    allMenus.add(blank);
    allMenus.addAll(advancedMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("View Menu"));
    allMenus.add(blank);
    allMenus.addAll(viewMenuItems);
    allMenus.add(blank);

    allMenus.add(Menu("Help Menu"));
    allMenus.add(blank);
    allMenus.addAll(helpMenuItems);

    np8080Manual = np8080ManualIntro;
    allMenus.forEach((Menu menu) {
      np8080Manual += menu.name.padRight(25) + menu.tooltip + '\r\n';
    });
  }
}
