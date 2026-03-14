import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sinport_airport_ui/main.dart';
import 'package:sinport_airport_ui/screens/map_screen.dart';
import 'package:sinport_airport_ui/widgets/service_button.dart';
import 'package:sinport_airport_ui/widgets/departure_card.dart';

// Mock HttpOverrides to avoid Image.network errors during tests
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => _MockHttpClient();
}

class _MockHttpClient implements HttpClient {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  group('Widget Tests', () {
    testWidgets('App should load HomeContent correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.text('Airport map'), findsOneWidget);
      expect(find.text('Good afternoon!'), findsOneWidget);
    });

    testWidgets('MapScreen should render controls and allow search trigger', (WidgetTester tester) async {
      // Direct test of the MapScreen widget
      await tester.pumpWidget(const MaterialApp(home: MapScreen()));
      await tester.pumpAndSettle();

      // Check for Top Bar Categories
      expect(find.text('Shopping'), findsOneWidget);
      expect(find.text('Gates'), findsOneWidget);
      
      // Check for Side Controls (Floor level '1' is active)
      expect(find.text('1'), findsOneWidget);

      // Trigger Search Overlay
      final searchButton = find.byIcon(Icons.search);
      expect(searchButton, findsOneWidget);
      
      await tester.tap(searchButton);
      await tester.pumpAndSettle();

      // Verify Search Overlay is shown
      expect(find.text('Where do you want to go?'), findsOneWidget);
      expect(find.text('You have already looked'), findsOneWidget);
    });

    testWidgets('ServiceButton should render title and icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                ServiceButton(
                  title: 'Test Service',
                  color: Colors.red,
                  icon: Icon(Icons.star),
                  isWide: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Test Service'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });
  });

  group('Logic & Unit Tests', () {
    test('Map Search Filtering Logic', () {
      final locations = [
        {'title': 'Gate 1C'},
        {'title': 'Zara store'},
      ];

      String query = 'zara';
      final filtered = locations.where((loc) => 
        loc['title']!.toLowerCase().contains(query.toLowerCase())).toList();

      expect(filtered.length, 1);
      expect(filtered[0]['title'], 'Zara store');
    });
  });
}
