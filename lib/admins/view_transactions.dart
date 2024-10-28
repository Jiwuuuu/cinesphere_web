import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewTransactionsPage extends StatefulWidget {
  const ViewTransactionsPage({super.key});

  @override
  _ViewTransactionsPageState createState() => _ViewTransactionsPageState();
}

class _ViewTransactionsPageState extends State<ViewTransactionsPage> {
  final supabase = Supabase.instance.client;
  List<TransactionData> transactions = [
    TransactionData(id: 'tx001', amount: 150.0, status: 'Paid'),
    TransactionData(id: 'tx002', amount: 200.0, status: 'Pending'),
    TransactionData(id: 'tx003', amount: 350.0, status: 'Cancelled'),
    TransactionData(id: 'tx004', amount: 120.0, status: 'Paid'),
    TransactionData(id: 'tx005', amount: 500.0, status: 'Paid'),
  ];

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
      if (response.isEmpty) {
        // Add mock data if no data exists in the table
        setState(() {
          transactions = [
            TransactionData(id: 'mock_tx001', amount: 100.0, status: 'Paid'),
            TransactionData(id: 'mock_tx002', amount: 200.0, status: 'Pending'),
            TransactionData(id: 'mock_tx003', amount: 300.0, status: 'Cancelled'),
          ];
        });
      } else {
        setState(() {
          transactions = response.map((e) => TransactionData.fromJson(e)).toList();
        });
      }
        } catch (error) {
      print('Error fetching transactions: $error');
    }
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
      ),
      backgroundColor: Color(0xFF07130E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: transactions.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
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
