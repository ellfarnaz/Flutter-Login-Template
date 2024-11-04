// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    bool isValid = true;
    setState(() {
      _emailError = null;
      _passwordError = null;

      if (_emailController.text.isEmpty) {
        _emailError = 'Email tidak boleh kosong';
        isValid = false;
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
          .hasMatch(_emailController.text)) {
        _emailError = 'Format email tidak valid';
        isValid = false;
      }

      if (_passwordController.text.isEmpty) {
        _passwordError = 'Password tidak boleh kosong';
        isValid = false;
      }
    });
    return isValid;
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
            // Centered main container
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      // Center all content
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: screenHeight * 0.05),
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
                                  'Masuk',
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
                              errorText: _emailError,
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
                              errorText: _passwordError,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            // Additional text
                            _buildAdditionalText(context, inputWidth),
                            SizedBox(height: screenHeight * 0.04),
                            // Login button
                            _buildLoginButton(context, buttonWidth),
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
    String? errorText,
  }) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
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
          const SizedBox(height: 8),
          TextFormField(
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
                  color:
                      errorText != null ? Colors.red : const Color(0xFF4285F4),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      errorText != null ? Colors.red : const Color(0xFF4285F4),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: errorText,
              errorStyle: GoogleFonts.poppins(
                fontSize: 12 * textScale,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalText(BuildContext context, double width) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Belum punya akun ?',
                  style: GoogleFonts.roboto(
                    fontSize: 13 * textScale,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    'Daftar sekarang',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF4285F4),
                      fontSize: 13 * textScale,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen()),
                );
              },
              child: Text(
                'Lupa password ?',
                style: GoogleFonts.roboto(
                  color: const Color(0xFF4285F4),
                  fontSize: 13 * textScale,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, double width) {
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
          if (_validateInputs()) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Masuk',
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
