// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Calculate responsive dimensions
    final double logoHeight = screenHeight * 0.12;
    final double logoWidth = screenWidth * 0.6;
    final double inputWidth = screenWidth * 0.85;
    final double buttonWidth = screenWidth * 0.6;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.02),
                            // Logo
                            Container(
                              alignment: Alignment.center,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: logoWidth,
                                  height: logoHeight,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Title
                            Container(
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Lupa Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenHeight * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Message Section
                            _buildMessageSection(context, inputWidth),
                            SizedBox(height: screenHeight * 0.03),
                            // Input Field
                            _buildInputField(context, inputWidth),
                            SizedBox(height: screenHeight * 0.04),
                            // Submit Button
                            _buildSubmitButton(context, buttonWidth),
                            SizedBox(height: screenHeight * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageSection(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesan',
            style: GoogleFonts.poppins(
              fontSize: 16 * textScale,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Masukan email Anda dan tunggu kode etik akan dikirimkan.',
            style: GoogleFonts.poppins(
              fontSize: 14 * textScale,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Masukan Email',
            style: GoogleFonts.poppins(
              fontSize: 14 * textScale,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontSize: 14 * textScale,
              ),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: 12,
                ),
                hintText: 'Email',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12 * textScale,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF4285F4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Color(0xFF4285F4),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        color: const Color(0xFF4285F4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x29000000),
            offset: Offset(4, 4),
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          print('Submit button pressed');
          // Implement your logic here
        },
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Kirim',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 24 * textScale,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
