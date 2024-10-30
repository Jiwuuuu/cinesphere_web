import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ViewTransactionsPage extends StatefulWidget {
  const ViewTransactionsPage({super.key});

  @override
  _ViewTransactionsPageState createState() => _ViewTransactionsPageState();
}

class _ViewTransactionsPageState extends State<ViewTransactionsPage> {
  final supabase = Supabase.instance.client;
  List<TransactionData> transactions = [];
  final TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchTransactions();
    });
  }

  Future<void> _fetchTransactions() async {
    try {
      final response = await supabase.from('transactions').select();
      setState(() {
        transactions = response.isNotEmpty
            ? response.map((e) => TransactionData.fromJson(e)).toList()
            : [];
      });
    } catch (error) {
      print('Error fetching transactions: $error');
    }
  }

  Future<void> _verifyTransaction(String qrData) async {
  final response = await supabase
      .from('transactions')
      .select()
      .eq('id', qrData)
      .maybeSingle();

  if (response == null) {
    _showMessage('Invalid or Unmatched QR Code');
  } else {
    final transaction = TransactionData.fromJson(response);
    _showTransactionDetails(transaction);
  }
}


  Future<void> _verifyByCode(String code) async {
    final response = await supabase
        .from('transactions')
        .select()
        .eq('unique_code', code)
        .maybeSingle();

    if (response == null) {
      _showMessage('Invalid or Unmatched Code');
    } else {
      final transaction = TransactionData.fromJson(response);
      _showTransactionDetails(transaction);
    }
  }

  void _showTransactionDetails(TransactionData transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Transaction Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Transaction ID: ${transaction.id}'),
              Text('Amount: ₱${transaction.amount}'),
              Text('Status: ${transaction.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        title: Text(
          'View Transactions',
          style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner, color: Color(0xFFE2F1EB)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _buildQRScanner()),
              );
            },
            tooltip: 'Scan QR Code',
          ),
        ],
      ),
      backgroundColor: Color(0xFF07130E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field to verify by unique code
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Unique Code',
                labelStyle: GoogleFonts.lexend(color: Colors.white),
                filled: true,
                fillColor: Color(0xFF07130E),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFF8CDDBB)), // Green stroke color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFF8CDDBB)), // Green stroke color
                ),
              ),
              style: GoogleFonts.lexend(color: Colors.white),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _verifyByCode(_codeController.text.trim()),
              child: Text('Verify Code'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: transactions.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Color(0xFF40E49F).withOpacity(0.6),
                              width: 2,
                            ),
                          ),
                          color: Color(0xFF07130E),
                          child: ListTile(
                            title: Text(
                              'Transaction ID: ${transaction.id}',
                              style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                            ),
                            subtitle: Text(
                              'Amount: ₱${transaction.amount}\nStatus: ${transaction.status}',
                              style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQRScanner() {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        backgroundColor: Color(0xFF07130E),
      ),
      body: kIsWeb
          ? Center(
              child: Text(
                'QR scanning is only supported on mobile devices or specific web browsers.',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : MobileScanner(
              onDetect: (barcode) {
                if (barcode.barcodes.isNotEmpty) {
                  final qrData = barcode.barcodes.first.rawValue;
                  if (qrData != null) {
                    _verifyTransaction(qrData);
                  } else {
                    _showMessage('Failed to scan QR Code');
                  }
                }
              },
            ),
    );
  }
}

class TransactionData {
  final String id;
  final double amount;
  final String status;

  TransactionData({
    required this.id,
    required this.amount,
    required this.status,
  });

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      id: json['id'],
      amount: json['amount']?.toDouble() ?? 0.0,
      status: json['payment_status'] ?? 'Unknown',
    );
  }
}
