import 'package:cinesphere_web/admins/create_admin.dart';
import 'package:cinesphere_web/admins/view_transactions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import 'manage_movies.dart';


class AdminDashboardPage extends StatefulWidget {
  final bool isSuperAdmin;

  const AdminDashboardPage({super.key, required this.isSuperAdmin});

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final supabase = Supabase.instance.client;
  List<_ChartData> categoryData = [];
  List<_ChartData> bookingData = [];
  List<_ChartData> revenueData = [];
  List<_ChartData> genreData = [];
  List<_ChartData> bookingStatusData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCategoryData();
      _fetchBookingData();
      _fetchRevenueData();
      _fetchGenreData();
      _fetchBookingStatusData();
    });
  }

  Future<void> _fetchCategoryData() async {
    try {
      final response = await supabase.from('movies').select('status');
      Map<String, int> categoryCount = {
        'Now Showing': 0,
        'Advance Selling': 0,
        'Coming Soon': 0,
      };
      for (var movie in response) {
        String status = movie['status'] ?? 'Unknown';
        if (categoryCount.containsKey(status)) {
          categoryCount[status] = categoryCount[status]! + 1;
        }
      }
      setState(() {
        categoryData = categoryCount.entries.map((e) => _ChartData(e.key, e.value)).toList();
      });
    } catch (error) {
      print('Error fetching category data: $error');
    }
  }

  Future<void> _fetchBookingData() async {
    try {
      final response = await supabase.from('bookings').select('created_at');
      Map<String, int> bookingCount = {
        'Jan': 0,
        'Feb': 0,
        'Mar': 0,
        'Apr': 0,
        'May': 0,
        'Jun': 0,
        'Jul': 0,
        'Aug': 0,
        'Sep': 0,
        'Oct': 0,
        'Nov': 0,
        'Dec': 0,
      };
      for (var booking in response) {
        DateTime createdAt = DateTime.parse(booking['created_at']);
        String month = _getMonthName(createdAt.month);
        bookingCount[month] = bookingCount[month]! + 1;
      }
      setState(() {
        bookingData = bookingCount.entries.map((e) => _ChartData(e.key, e.value)).toList();
      });
    } catch (error) {
      print('Error fetching booking data: $error');
    }
  }

  Future<void> _fetchRevenueData() async {
    // Mock data for revenue by month
    setState(() {
      revenueData = [
        _ChartData('Jan', 5000),
        _ChartData('Feb', 7000),
        _ChartData('Mar', 6000),
        _ChartData('Apr', 8000),
        _ChartData('May', 4000),
        _ChartData('Jun', 9000),
        _ChartData('Jul', 7000),
        _ChartData('Aug', 8500),
        _ChartData('Sep', 7500),
        _ChartData('Oct', 9500),
        _ChartData('Nov', 6500),
        _ChartData('Dec', 10000),
      ];
    });
  }

  Future<void> _fetchGenreData() async {
    try {
      final response = await supabase.from('movies').select('genre');
      Map<String, int> genreCount = {};
      for (var movie in response) {
        String genre = movie['genre'] ?? 'Unknown';
        if (genreCount.containsKey(genre)) {
          genreCount[genre] = genreCount[genre]! + 1;
        } else {
          genreCount[genre] = 1;
        }
      }
      setState(() {
        genreData = genreCount.entries.map((e) => _ChartData(e.key, e.value)).toList();
      });
    } catch (error) {
      print('Error fetching genre data: $error');
    }
  }

  Future<void> _fetchBookingStatusData() async {
    // Mock data for booking status distribution
    setState(() {
      bookingStatusData = [
        _ChartData('Paid', 25),
        _ChartData('Pending', 10),
        _ChartData('Cancelled', 5),
      ];
    });
  }

  String _getMonthName(int month) {
    List<String> months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Replace with your logo image path
              height: 30,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Text(
              'CINESPHERE',
              style: GoogleFonts.lexend(
                fontSize: 30,
                color: Color(0xFFE2F1EB)
                ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF07130E),
      body: ClipRect(
        child: Row(
          children: [
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: Color(0xFF07130E),
                border: Border(
                  right: BorderSide(
                    color: Color(0xFF40E49F).withOpacity(0.6),
                    width: 2,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu',
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE2F1EB),
                      ),
                    ),
                    SizedBox(height: 24),

                    // Button to Create Admin visible only for Super Admins
                    if (widget.isSuperAdmin) ...[
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CreateAdminPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Color(0xFF8CDDBB)),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(Icons.person_add, color: Color(0xFF8CDDBB)),
                        label: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create Admin',
                            style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],

                    // Button to Manage Movies (Visible for all admins)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ManageMoviesPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Color(0xFF8CDDBB)),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.movie, color: Color(0xFF8CDDBB)),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Manage Movies',
                          style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Button to Manage Bookings (Visible for all admins)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add navigation to Booking Management Page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Color(0xFF8CDDBB)),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.event_seat, color: Color(0xFF8CDDBB)),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Manage Bookings',
                          style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Button to Manage Seats (Visible for all admins)
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add navigation to Seat Management Page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Color(0xFF8CDDBB)),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.chair, color: Color(0xFF8CDDBB)),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Manage Seats',
                          style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Button to View Transactions (Visible for all admins)
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewTransactionsPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: Color(0xFF8CDDBB)),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.attach_money, color: Color(0xFF8CDDBB)),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'View Transactions',
                          style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)),
                        ),
                      ),
                    ),
                    Spacer(),
                    // Logout Button at the bottom of the sidebar
                    ElevatedButton.icon(
                      onPressed: () async {
                        await supabase.auth.signOut();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Transparent background
                        side: BorderSide(color: Color(0xFF8CDDBB)), // Stroke color
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: Icon(Icons.logout, color: Color(0xFF8CDDBB)),
                      label: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Logout',
                          style: GoogleFonts.lexend(color: Color(0xFF8CDDBB)), // Change button text color here
                        ),
                      ),
                    ),

                    // Copyright Text
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '2024 CineSphere. All rights reserved.',
                          style: GoogleFonts.lexend(
                            color: Color(0xFFE2F1EB),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to CineSphere Admin Dashboard',
                      style: GoogleFonts.lexend(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE2F1EB),
                      ),
                    ),
                    SizedBox(height: 32),

                    // Adding statistics and graphs to the admin dashboard
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          // Example: Movies by Category Chart
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFF40E49F).withOpacity(0.6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Color(0xFF07130E),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: 'Movies by Category',
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                series: <CircularSeries>[
                                  PieSeries<_ChartData, String>(
                                    dataSource: categoryData,
                                    xValueMapper: (_ChartData data, _) => data.x,
                                    yValueMapper: (_ChartData data, _) => data.y,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: GoogleFonts.lexend(
                                        color: Color(0xFFE2F1EB),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Example: Bookings Chart
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFF40E49F).withOpacity(0.6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Color(0xFF07130E),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                  text: 'Monthly Bookings',
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                primaryXAxis: CategoryAxis(
                                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                primaryYAxis: NumericAxis(
                                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                series: <ChartSeries<_ChartData, String>>[
                                  ColumnSeries<_ChartData, String>(
                                    dataSource: bookingData,
                                    xValueMapper: (_ChartData data, _) => data.x,
                                    yValueMapper: (_ChartData data, _) => data.y,
                                    color: Color(0xFF8CDDBB),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: GoogleFonts.lexend(
                                        color: Color(0xFFE2F1EB),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Example: Revenue by Month Chart
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFF40E49F).withOpacity(0.6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Color(0xFF07130E),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                  text: 'Revenue by Month',
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                primaryXAxis: CategoryAxis(
                                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                primaryYAxis: NumericAxis(
                                  labelStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                series: <ChartSeries<_ChartData, String>>[
                                  LineSeries<_ChartData, String>(
                                    dataSource: revenueData,
                                    xValueMapper: (_ChartData data, _) => data.x,
                                    yValueMapper: (_ChartData data, _) => data.y,
                                    color: Color(0xFF8CDDBB),
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: GoogleFonts.lexend(
                                        color: Color(0xFFE2F1EB),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Example: Top Genres Chart
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFF40E49F).withOpacity(0.6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Color(0xFF07130E),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: 'Top Genres',
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                series: <CircularSeries>[
                                  PieSeries<_ChartData, String>(
                                    dataSource: genreData,
                                    xValueMapper: (_ChartData data, _) => data.x,
                                    yValueMapper: (_ChartData data, _) => data.y,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: GoogleFonts.lexend(
                                        color: Color(0xFFE2F1EB),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Example: Booking Status Distribution Chart
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Color(0xFF40E49F).withOpacity(0.6),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Color(0xFF07130E),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SfCircularChart(
                                title: ChartTitle(
                                  text: 'Booking Status Distribution',
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  textStyle: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
                                ),
                                series: <CircularSeries>[
                                  PieSeries<_ChartData, String>(
                                    dataSource: bookingStatusData,
                                    xValueMapper: (_ChartData data, _) => data.x,
                                    yValueMapper: (_ChartData data, _) => data.y,
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: GoogleFonts.lexend(
                                        color: Color(0xFFE2F1EB),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color: Colors.black,
                                            offset: Offset(1.0, 1.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final int y;
}
