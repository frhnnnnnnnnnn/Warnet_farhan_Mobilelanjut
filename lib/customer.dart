import 'package:flutter/material.dart';
import 'proses.dart'; // Ensure that this is correctly pointing to the file where BillingProcessScreen is defined.
import 'package:intl/intl.dart'; // This is for date formatting.

// Customer Entry Screen
class CustomerEntryScreen extends StatefulWidget {
  @override
  _CustomerEntryScreenState createState() => _CustomerEntryScreenState();
}

class _CustomerEntryScreenState extends State<CustomerEntryScreen> {
  // Controllers for text fields
  final TextEditingController _kodeController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jenisPelangganController = TextEditingController();
  final TextEditingController _jamMasukController = TextEditingController();
  final TextEditingController _jamKeluarController = TextEditingController();
  
  // Initial date for date picker
  DateTime _selectedDate = DateTime.now();
  
  // Method to show DatePicker and select a date
  void _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Current selected date
      firstDate: DateTime(2000),  // Earliest possible date
      lastDate: DateTime(2100),   // Latest possible date
    );
    
    // If the user picks a date, update the selected date
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Navigate to the billing screen and pass data
  void _navigateToBilling(BuildContext context) {
    // Get values from the form fields
    final String kode = _kodeController.text;
    final String nama = _namaController.text;
    final String jenisPelanggan = _jenisPelangganController.text;
    final double jamMasuk = double.parse(_jamMasukController.text);
    final double jamKeluar = double.parse(_jamKeluarController.text);

    // Format the selected date as yyyy-MM-dd
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    // Navigate to BillingProcessScreen, passing form data and date
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BillingProcessScreen(
          kode: kode,
          nama: nama,
          jenisPelanggan: jenisPelanggan,
          jamMasuk: jamMasuk,
          jamKeluar: jamKeluar,
          tanggal: formattedDate, // Pass the selected and formatted date
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry Pelanggan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kodeController,
              decoration: InputDecoration(labelText: 'Kode Pelanggan'),
            ),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Pelanggan'),
            ),
            TextField(
              controller: _jenisPelangganController,
              decoration: InputDecoration(labelText: 'Jenis Pelanggan (VIP/GOLD)'),
            ),
            TextField(
              controller: _jamMasukController,
              decoration: InputDecoration(labelText: 'Jam Masuk'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _jamKeluarController,
              decoration: InputDecoration(labelText: 'Jam Keluar'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Date Picker Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Tanggal: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  child: Text('Pilih Tanggal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToBilling(context),
              child: Text('Proses Data'),
            ),
          ],
        ),
      ),
    );
  }
}
