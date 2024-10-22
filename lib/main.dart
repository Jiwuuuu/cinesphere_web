import 'package:flutter/material.dart';
import './widgets/navbar.dart';
import './widgets/hero_section.dart';
import './widgets/features_section.dart';
import './widgets/testimonials_section.dart';
import './widgets/faq_section.dart';
import './widgets/footer.dart';

void main() {
  runApp(CineSphereWeb());
}

class CineSphereWeb extends StatelessWidget {
  const CineSphereWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DesktopCinesphere(),
    );
  }
}

class DesktopCinesphere extends StatefulWidget {
  const DesktopCinesphere({super.key});

  @override
  _DesktopCinesphereState createState() => _DesktopCinesphereState();
}

class _DesktopCinesphereState extends State<DesktopCinesphere> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  // Define keys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200) {
        setState(() {
          _showScrollToTopButton = true;
        });
      } else {
        setState(() {
          _showScrollToTopButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF07130E),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Navbar(
                  scrollController: _scrollController,
                  featuresKey: _featuresKey,
                  faqKey: _faqKey,
                  testimonialsKey: _testimonialsKey,
                  contactKey: _contactKey,
                ),
                SizedBox(height: 20),
                HeroSection(key: _heroKey),  // Add the required key
                SizedBox(height: 40),
                FeaturesSection(key: _featuresKey), // Use the updated FeaturesSection here
                SizedBox(height: 40),
                TestimonialsSection(key: _testimonialsKey),
                SizedBox(height: 40),
                FAQSection(key: _faqKey),
                SizedBox(height: 40),
                Footer(key: _contactKey),
              ],
            ),
          ),
          if (_showScrollToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF8CDDBB),
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(Icons.arrow_upward, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
