import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  final String role;

  SignUpScreen({required this.role});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController experienceController = TextEditingController(); // For BabySitter Experience

  LatLng? selectedLocation; // To store the location selected on the map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          '${widget.role} Sign Up',
          style: TextStyle(fontSize: 24.sp, color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 300.h,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.7749, -122.4194), // Default location (San Francisco)
                      zoom: 10,
                    ),
                    onTap: (LatLng latLng) {
                      setState(() {
                        selectedLocation = latLng; // Update the selected location
                      });
                    },
                    markers: selectedLocation != null
                        ? {
                            Marker(
                              markerId: MarkerId('selected-location'),
                              position: selectedLocation!,
                            ),
                          }
                        : {},
                  ),
                ),
                SizedBox(height: 10.h),
                if (widget.role == 'Sitter')
                  TextFormField(
                    controller: experienceController,
                    decoration: InputDecoration(
                      labelText: 'Experience (for Sitters)',
                      labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.visibility, size: 20.sp, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(fontSize: 16.sp, color: Theme.of(context).textTheme.bodyMedium?.color),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.visibility, size: 20.sp, color: Theme.of(context).iconTheme.color),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (passwordController.text == confirmPasswordController.text) {
                        if (selectedLocation != null) {
                          try {
                            // Create user in Firebase Authentication
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            User? user = userCredential.user;

                            // Create GeoPoint from selected location
                            GeoPoint location = GeoPoint(selectedLocation!.latitude, selectedLocation!.longitude);

                            // Insert data into Firestore based on role
                            if (widget.role == 'Parent') {
                              // Use "Parent" collection if the role is Parent
                              await FirebaseFirestore.instance.collection('Parent').doc(user?.uid).set({
                                'Name': nameController.text.trim(),
                                'Age': int.parse(ageController.text.trim()), // Store as integer
                                'Location': location, // Store as GeoPoint
                                'Email': emailController.text.trim(),
                                'Children': [] // Initialize as empty array for now
                              });
                            } else if (widget.role == 'Sitter') {
                              // Use "BabySitter" collection if the role is Sitter
                              await FirebaseFirestore.instance.collection('BabySitter').doc(user?.uid).set({
                                'Name': nameController.text.trim(),
                                'Age': int.parse(ageController.text.trim()), // Store as integer
                                'Location': location, // Store as GeoPoint
                                'Email': emailController.text.trim(),
                                'Experience': experienceController.text.trim(), // Experience entered by user
                                'Availability': 'Available' // Example availability status
                              });
                            }

                            // Navigate to home
                            context.goNamed('home');
                          } catch (e) {
                            // Handle errors
                            print('Error: $e');
                          }
                        } else {
                          print('Please select a location.');
                        }
                      } else {
                        print('Passwords do not match.');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      minimumSize: Size(300.w, 50.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
