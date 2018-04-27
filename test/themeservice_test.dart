//import 'package:np8080/src/services/themeservice.dart';
//import 'package:test/test.dart';
//
//void main() {
//  ThemeService tps = ThemeService();
//
//  group('Main: default theme.', () {
//    test('theme', () {
//      expect(tps.theme, "default");
//    });
//    test('mainClass', () {
//      expect(tps.mainClass, "default-theme-1");
//    });
//    test('secondaryClass', () {
//      expect(tps.secondaryClass, "default-theme-2");
//    });
//    test('documentClass', () {
//      expect(tps.documentClass, "default-document");
//    });
//    test('highlightClass', () {
//      expect(tps.highlightClass, "default-highlight");
//    });
//    test('borderClass', () {
//      expect(tps.borderClass, "default-border");
//    });
//  });
//
//  group('Main: dark theme.', () {
//    setUp(() {
//      tps.theme = "dark";
//    });
//    test('theme', () {
//      expect(tps.theme, "dark");
//    });
//    test('mainClass', () {
//      expect(tps.mainClass, "dark-theme-1");
//    });
//    test('secondaryClass', () {
//      expect(tps.secondaryClass, "dark-theme-2");
//    });
//    test('documentClass', () {
//      expect(tps.documentClass, "dark-document");
//    });
//    test('highlightClass', () {
//      expect(tps.highlightClass, "dark-highlight");
//    });
//    test('borderClass', () {
//      expect(tps.borderClass, "dark-border");
//    });
//  });
//
//  group('Theme storage.', () {
//    test('Ensure changed theme is changed and stored.', () {
//      tps.theme = "TEST";
//
//      tps = ThemeService();
//      tps.load();
//      expect(tps.theme, "TEST");
//    });
//  });
//}
