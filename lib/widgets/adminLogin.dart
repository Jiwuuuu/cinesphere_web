import 'package:cinesphere_web/admins/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

void _loginAdmin() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter both email and password')),
    );
    return;
  }

  try {
    // Authenticate the user with Supabase
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    // If the user is authenticated successfully
    if (response.session != null) {
      final userId = response.user?.id;

      if (userId != null) {
        // Query the admins table to check if the logged-in user is a super admin
        final adminResponse = await supabase
            .from('admins')
            .select()
            .eq('id', userId)
            .single();

        // Extract data from the response
        final data = adminResponse;

        // Check if the admin is a super admin
        final isSuperAdmin = data['is_super_admin'] == true;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );

        // Navigate to the Admin Dashboard with the `isSuperAdmin` flag
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminDashboardPage(isSuperAdmin: isSuperAdmin),
          ),
        );
            }
    } else {
      // Handle the case where authentication fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: Invalid email or password')),
      );
    }
  } catch (error) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: $error')),
    );
  }
}






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Admin',
          style: GoogleFonts.lexend(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hero_background.png'), // Replace with your background image path
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF07130E).withOpacity(0.9),
                  Color(0xFF07130E),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(24.0),
              constraints: BoxConstraints(maxWidth: 400),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'CineSphere Admin',
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    style: GoogleFonts.lexendDeca(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: GoogleFonts.lexendDeca(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF2C3A36),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: GoogleFonts.lexendDeca(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.lexendDeca(color: Colors.white70),
                      filled: true,
                      fillColor: Color(0xFF2C3A36),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _loginAdmin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF8CDDBB),
                      minimumSize: Size(double.infinity, 49),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.lexendDeca(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
