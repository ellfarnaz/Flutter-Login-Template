import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform, File;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _universityName = 'Universitas Teknologi Yogyakarta';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _nameController.text = prefs.getString('name') ?? 'Farel Naufal A';
      _phoneController.text = prefs.getString('phone') ?? '';
      _addressController.text = prefs.getString('address') ?? '';
      _universityName =
          prefs.getString('university') ?? 'Universitas Teknologi Yogyakarta';
      final String? imagePath = prefs.getString('profile_image_path');
      if (imagePath != null && File(imagePath).existsSync()) {
        _image = File(imagePath);
      }
    });
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');

      setState(() {
        _image = savedImage;
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', savedImage.path);
    }
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('name', _nameController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);

    setState(() {
      // Update the UI
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profil berhasil diperbarui'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF4285F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isIOS = Platform.isIOS;
    final double profileWidth = isIOS ? size.width * 0.5 : 200;
    final double fontSize = isIOS ? size.width * 0.05 : 20;
    final double padding = isIOS ? size.width * 0.05 : 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3CEFA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4285F4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Kelola Akun',
          style: GoogleFonts.roboto(
            color: const Color(0xFF4285F4),
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile Section
                  Center(
                    child: Container(
                      width: profileWidth,
                      padding: EdgeInsets.all(padding * 0.8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFB3CEFA),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Profile Image
                          GestureDetector(
                            onTap: () async {
                              await getImage();
                              setState(
                                  () {}); // Refresh UI after image selection
                            },
                            child: Container(
                              width: profileWidth * 0.8,
                              height: profileWidth * 0.8,
                              decoration: BoxDecoration(
                                color: const Color(0xFFB3CEFA),
                                shape: BoxShape.circle,
                                image: _image != null && _image!.existsSync()
                                    ? DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: _image == null || !_image!.existsSync()
                                  ? Icon(
                                      Icons.camera_alt,
                                      size: profileWidth * 0.4,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(height: padding * 0.8),
                          // Name
                          Text(
                            _nameController.text,
                            style: GoogleFonts.roboto(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: padding * 0.4),
                          // University
                          Text(
                            _universityName,
                            style: GoogleFonts.roboto(
                              fontSize: fontSize * 0.8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: padding * 1.2),
                  // Form Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTextField(context, 'Email',
                              TextInputType.emailAddress, _emailController),
                          SizedBox(height: padding * 0.8),
                          _buildTextField(context, 'Nama', TextInputType.name,
                              _nameController),
                          SizedBox(height: padding * 0.8),
                          _buildTextField(context, 'Nomor Telepon',
                              TextInputType.phone, _phoneController),
                          SizedBox(height: padding * 0.8),
                          _buildTextField(context, 'Alamat',
                              TextInputType.streetAddress, _addressController,
                              maxLines: 2),
                          SizedBox(height: padding * 1.2),
                          ElevatedButton(
                            onPressed: _updateProfile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4285F4),
                              padding: EdgeInsets.symmetric(
                                  vertical: padding * 0.75),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'Ubah Profil',
                              style: GoogleFonts.roboto(
                                fontSize: fontSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label,
      TextInputType keyboardType, TextEditingController controller,
      {int maxLines = 1}) {
    final isIOS = Platform.isIOS;
    final size = MediaQuery.of(context).size;
    final double fontSize = isIOS ? size.width * 0.04 : 16;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: fontSize * 0.875,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: isIOS ? 16 : 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3CEFA),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFB3CEFA),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF4285F4),
                width: 2,
              ),
            ),
          ),
          style: GoogleFonts.roboto(
            fontSize: fontSize,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
