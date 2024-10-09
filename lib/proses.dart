import 'package:flutter/material.dart';

class BillingProcessScreen extends StatelessWidget {
  final String kode;
  final String nama;
  final String jenisPelanggan;
  final double jamMasuk;
  final double jamKeluar;
  final String tanggal; // Add the tanggal parameter

  BillingProcessScreen({
    required this.kode,
    required this.nama,
    required this.jenisPelanggan,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tanggal, // Receive the selected date
  });

  double calculateTotalBayar() {
    const double tarifPerJam = 10000;
    double lama = jamKeluar - jamMasuk;
    double diskon = 0;

    if (jenisPelanggan == 'VIP' && lama > 2) {
      diskon = 0.02; // 2% discount
    } else if (jenisPelanggan == 'GOLD' && lama > 2) {
      diskon = 0.05; // 5% discount
    }

    return (lama * tarifPerJam) * (1 - diskon);
  }

  @override
  Widget build(BuildContext context) {
    double totalBayar = calculateTotalBayar();

    return Scaffold(
      appBar: AppBar(
        title: Text('Billing Process'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode Pelanggan: $kode'),
            Text('Nama Pelanggan: $nama'),
            Text('Jenis Pelanggan: $jenisPelanggan'),
            Text('Tanggal: $tanggal'), // Display the selected date
            Text('Jam Masuk: $jamMasuk'),
            Text('Jam Keluar: $jamKeluar'),
            SizedBox(height: 20),
            Text(
              'Total Bayar: Rp. ${totalBayar.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
