import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                                  'Daftar',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenHeight * 0.045,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                            // Input fields
                            _buildInputField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              label: 'Masukan Email',
                              hint: 'Email',
                              width: inputWidth,
                              context: context,
                            ),
                            SizedBox(height: screenHeight * 0.025),
                            _buildInputField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              label: 'Masukan Password',
                              hint: 'Password',
                              isPassword: true,
                              width: inputWidth,
                              context: context,
                            ),
                            SizedBox(height: screenHeight * 0.025),
                            _buildInputField(
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocusNode,
                              label: 'Masukan Kembali Password',
                              hint: 'Password',
                              isPassword: true,
                              width: inputWidth,
                              context: context,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Additional text
                            _buildAdditionalText(context, inputWidth),
                            SizedBox(height: screenHeight * 0.04),
                            // Register button
                            _buildRegisterButton(context, buttonWidth),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required BuildContext context,
    bool isPassword = false,
  }) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14 * textScale,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 48,
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              obscureText: isPassword,
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(fontSize: 14 * textScale),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: 12,
                ),
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12 * textScale,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4285F4),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
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

  Widget _buildAdditionalText(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sudah memiliki akun ?',
              style: GoogleFonts.roboto(fontSize: 13 * textScale),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Masuk',
                style: GoogleFonts.roboto(
                  color: Color(0xFF4285F4),
                  fontSize: 13 * textScale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        color: Color(0xFF4285F4),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x29000000),
            offset: Offset(4, 4),
          )
        ],
      ),
      child: TextButton(
        onPressed: () {
          print('Register button pressed');
        },
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Daftar',
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
