import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {

  final ScrollController scrollController;
  final GlobalKey featuresKey;
  final GlobalKey faqKey;           // Add this line
  final GlobalKey testimonialsKey;  // Add this line
  final GlobalKey contactKey;       // Add this line

  const Navbar({
    super.key,
    required this.scrollController,
    required this.featuresKey,
    required this.faqKey,           // Add this line
    required this.testimonialsKey,  // Add this line
    required this.contactKey,       // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Color(0xFF07130E),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/logo.png', height: 40),
                    SizedBox(width: 8),
                    Text(
                      'CINESPHERE',
                      style: GoogleFonts.lexend(
                        color: Color(0xFFE2F1EB),
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        scrollController.animateTo(
                          0,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('Home', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                    ),
                    TextButton(
                      onPressed: () {
                        // Scroll to the features section
                        scrollController.animateTo(
                          1000, // Adjust the offset value based on the actual position of the section
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('Features', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                    ),
                    TextButton(
                      onPressed: () {
                        // Scroll to the testimonials section
                        scrollController.animateTo(
                          2500, // Adjust the offset value based on the actual position of the section
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('Testimonials', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                    ),
                    TextButton(
                      onPressed: () {
                        // Scroll to the FAQ section
                        scrollController.animateTo(
                          3300, // Adjust the offset value based on the actual position of the section
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('FAQ', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                    ),
                    TextButton(
                      onPressed: () {
                        // Scroll to the contact section
                        scrollController.animateTo(
                          3800, // Adjust the offset value based on the actual position of the section
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text('Contact', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/logo.png', height: 40),
                        SizedBox(width: 8),
                        Text(
                          'CINESPHERE',
                          style: GoogleFonts.lexend(
                            color: Color(0xFFE2F1EB),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.menu, color: Color(0xFFE2F1EB)),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Container(
                            color: Color(0xFF07130E),
                            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text('Home', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                  onTap: () {
                                    Navigator.pop(context);
                                    scrollController.animateTo(
                                      0,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                                ListTile(
                                  title: Text('Features', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                  onTap: () {
                                    Navigator.pop(context);
                                    scrollController.animateTo(
                                      800,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                                ListTile(
                                  title: Text('Testimonials', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                  onTap: () {
                                    Navigator.pop(context);
                                    scrollController.animateTo(
                                      1600,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                                ListTile(
                                  title: Text('FAQ', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                  onTap: () {
                                    Navigator.pop(context);
                                    scrollController.animateTo(
                                      2400,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                                ListTile(
                                  title: Text('Contact', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                  onTap: () {
                                    Navigator.pop(context);
                                    scrollController.animateTo(
                                      3200,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
