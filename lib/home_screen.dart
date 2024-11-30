import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For handling image files

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // NEW: Variable to store the selected image file
  File? _selectedImage;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // NEW: Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path); // Store the selected image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Light Green background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent[400], // Light green app bar
        title: const Text(
          'PlantCare AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
            fontFamily: 'Poppins', // Simple and clean font style
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Section
            const Text(
              'Detect and Treat Plant Diseases',
              style: TextStyle(
                fontSize: 22,
                color: Color(0xFF388E3C), // Slightly darker green text
                fontWeight: FontWeight.w500,
                letterSpacing: 1.3,
                fontFamily: 'Roboto', // Clear and modern font
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Image Placeholder Section
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.greenAccent.shade200, width: 2),
              ),
              // NEW: Conditional check to show image or placeholder text
              child: Center(
                child: _selectedImage == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.green[300],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'No image selected',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
                    : Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover, // Display selected image
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Upload & Take Photo Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // NEW: Upload Image Button with _pickImage logic
                _buildCustomButton(
                  label: 'Upload Image',
                  icon: Icons.upload_file,
                  onPressed: _pickImage, // Calls the image picker function
                  color: Colors.green,
                ),
                _buildCustomButton(
                  label: 'Take Photo',
                  icon: Icons.camera_alt,
                  onPressed: () {
                    // Camera logic will go here in the future
                  },
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Scan Button
            ElevatedButton(
              onPressed: () {
                // Scan logic will go here in the future
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.green[700], // Dark green for emphasis
              ),
              child: const Text(
                'Scan for Diseases',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins', // Modern font style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Button Builder Function
  Widget _buildCustomButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Roboto', // Simple, modern font
        ),
      ),
    );
  }
}
