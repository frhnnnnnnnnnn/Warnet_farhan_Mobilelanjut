import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_warnet_farhan/customer.dart';

void main() {
  testWidgets('Customer entry and billing calculation test with date', (WidgetTester tester) async {
    // Build the CustomerEntryScreen widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: CustomerEntryScreen()));

    // Verify that the form fields are present.
    expect(find.byType(TextField), findsNWidgets(5)); // 5 TextFields for inputs

    // Enter customer details
    await tester.enterText(find.byType(TextField).at(0), 'P001'); // Kode Pelanggan
    await tester.enterText(find.byType(TextField).at(1), 'John Doe'); // Nama Pelanggan
    await tester.enterText(find.byType(TextField).at(2), 'VIP'); // Jenis Pelanggan
    await tester.enterText(find.byType(TextField).at(3), '1'); // Jam Masuk
    await tester.enterText(find.byType(TextField).at(4), '4'); // Jam Keluar

    // Pick a date
    await tester.tap(find.text('Pilih Tanggal')); // Tap on date picker button
    await tester.pumpAndSettle(); // Wait for the date picker to appear
    await tester.tap(find.text('15')); // Select the 15th of the current month
    await tester.pumpAndSettle(); // Close the date picker

    // Tap the 'Proses Data' button and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for navigation to complete

    // Verify that the BillingProcessScreen shows the correct total and date.
    expect(find.text('Total Bayar: Rp. 30000.00'), findsOneWidget); // Check the calculated total
    expect(find.text('Kode Pelanggan: P001'), findsOneWidget);
    expect(find.text('Nama Pelanggan: John Doe'), findsOneWidget);
    expect(find.text('Jenis Pelanggan: VIP'), findsOneWidget);
    expect(find.text('Tanggal: 2024-10-15'), findsOneWidget); // Check the selected date
    expect(find.text('Jam Masuk: 1.0'), findsOneWidget);
    expect(find.text('Jam Keluar: 4.0'), findsOneWidget);
  });
}
