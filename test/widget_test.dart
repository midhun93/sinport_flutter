import 'dart:async';
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
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #createHttpClient) return _MockHttpClient();
    if (invocation.memberName == #getUrl) return _MockHttpClientRequest();
    if (invocation.memberName == #openUrl) return _MockHttpClientRequest();
    return null;
  }
}

class _MockHttpClientRequest implements HttpClientRequest {
  @override
  dynamic noSuchMethod(Invocation invocation) => _MockHttpClientResponse();
}

class _MockHttpClientResponse extends Mock implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => 0;

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return const Stream<List<int>>.empty().listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}

// Simple Mock class to satisfy implementation requirements
class Mock {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpOverrides();
  });

  group('General App Tests', () {
    testWidgets('App navigation from Home to Map should work', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify we are on Home
      expect(find.text('Airport map'), findsOneWidget);

      // Find the Map button in BottomNav
      final mapIcon = find.byIcon(Icons.map_outlined);
      expect(mapIcon, findsOneWidget);

      await tester.tap(mapIcon);
      await tester.pumpAndSettle();

      // Verify MapScreen components are now visible
      expect(find.text('Shopping'), findsOneWidget);
    });
  });

  group('MapScreen Coverage Tests', () {
    testWidgets('MapScreen interaction: floor levels and zoom', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MapScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('2'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.my_location));
      await tester.pumpAndSettle();

      expect(find.text('Gate 1C'), findsOneWidget);
      expect(find.text('Build a route'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(find.text('Build a route'), findsNothing);
    });

    testWidgets('MapScreen search filtering and selection', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MapScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'zara');
      await tester.pump();

      expect(find.text('Zara store'), findsOneWidget);
      expect(find.text('McDonald\'s'), findsNothing);

      await tester.tap(find.text('Zara store'));
      await tester.pumpAndSettle();

      expect(find.text('Zara store'), findsNWidgets(1));
      expect(find.text('Build a route'), findsOneWidget);

      await tester.tap(find.text('Build a route'));
      await tester.pumpAndSettle();

      expect(find.text('100 m turn left'), findsOneWidget);
      expect(find.text('Arrival'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pumpAndSettle();
      expect(find.text('Arrival'), findsNothing);
    });
  });

  group('Widget Component Tests', () {
    testWidgets('ServiceButton basic rendering', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Row(
              children: [
                ServiceButton(
                  title: 'Transfer',
                  color: Colors.amber,
                  icon: Icon(Icons.taxi_alert),
                  isWide: true,
                ),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Transfer'), findsOneWidget);
    });

    testWidgets('DepartureCard basic rendering', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DepartureCard(
              from: 'SG',
              to: 'NY',
              time: '12:00',
              gate: 'A1',
            ),
          ),
        ),
      );
      expect(find.text('SG - NY'), findsOneWidget);
      expect(find.text('A1'), findsOneWidget);
    });
  });
}
