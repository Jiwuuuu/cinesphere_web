import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  final ScrollController scrollController;
  final GlobalKey featuresKey;
  final GlobalKey faqKey;
  final GlobalKey testimonialsKey;
  final GlobalKey contactKey;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.featuresKey,
    required this.faqKey,
    required this.testimonialsKey,
    required this.contactKey,
  });

  void _scrollToSection(GlobalKey sectionKey) {
    final context = sectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        alignment: 0, // Adjusts the alignment of the target widget, 0 means top.
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xFF07130E),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF8CDDBB).withOpacity(0.2),
              width: 2.0,
            ),
          ),
        ),
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
                          _scrollToSection(featuresKey);
                        },
                        child: Text('Features', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                      ),
                      TextButton(
                        onPressed: () {
                          _scrollToSection(testimonialsKey);
                        },
                        child: Text('Testimonials', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                      ),
                      TextButton(
                        onPressed: () {
                          _scrollToSection(faqKey);
                        },
                        child: Text('FAQ', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                      ),
                      TextButton(
                        onPressed: () {
                          _scrollToSection(contactKey);
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
                                      _scrollToSection(featuresKey);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Testimonials', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _scrollToSection(testimonialsKey);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('FAQ', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _scrollToSection(faqKey);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Contact', style: GoogleFonts.lexend(color: Color(0xFFE2F1EB))),
                                    onTap: () {
                                      Navigator.pop(context);
                                      _scrollToSection(contactKey);
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
      ),
    );
  }
}
