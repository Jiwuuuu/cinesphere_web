import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key});

  @override
  _CreateAdminPageState createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final supabase = Supabase.instance.client;

  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;
  String? _generalError;

void _createAdmin() async {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  setState(() {
    _emailError = null;
    _passwordError = null;
    _generalError = null;
  });

  if (!_isValidEmail(email)) {
    setState(() {
      _emailError = 'Please enter a valid email address';
    });
    return;
  }

  if (!_isValidPassword(password)) {
    setState(() {
      _passwordError = 'Password must be at least 8 characters, contain uppercase, lowercase, and a number';
    });
    return;
  }

  try {
    // Sign up using Supabase auth
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user != null) {
      final userId = response.user!.id;

      // Insert admin data using service role key
      final serviceClient = SupabaseClient(
        'https://ugvcmfripsepimuwetav.supabase.co',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVndmNtZnJpcHNlcGltdXdldGF2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNjI4MzgxMCwiZXhwIjoyMDQxODU5ODEwfQ.I6JFdx-szv5RlDdVwdnbwUcKVw4rDSQ0hb6PI5xwH6U', // Replace with your actual Supabase service role key
      );

      final adminResponse = await serviceClient.from('admins').insert({
        'id': userId,
        'email': email,
      });

      if (adminResponse.hasError) {
        setState(() {
          _generalError = 'Failed to create admin in the database: ${adminResponse.error?.message}';
        });
      } else {
        setState(() {
          _generalError = 'Admin account created successfully';
        });
      }
    } else {
      setState(() {
        _generalError = 'Failed to create user account. Please try again.';
      });
    }
  } catch (error) {
    setState(() {
      _generalError = 'An unexpected error occurred: $error';
    });
  }
}



  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF07130E),
        title: Text(
          'Create Admin',
          style: GoogleFonts.lexend(color: Color(0xFFE2F1EB)),
        ),
      ),
      backgroundColor: Color(0xFF07130E),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              style: TextStyle(color: Color(0xFFE2F1EB)),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                filled: true,
                fillColor: Color(0xFF2C3A36),
                border: OutlineInputBorder(),
                errorText: _emailError,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(color: Color(0xFFE2F1EB)),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Color(0xFFE2F1EB)),
                filled: true,
                fillColor: Color(0xFF2C3A36),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFFE2F1EB),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                errorText: _passwordError,
              ),
            ),
            if (_generalError != null) ...[
              SizedBox(height: 16),
              Text(
                _generalError!,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _createAdmin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8CDDBB),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Create Admin',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
