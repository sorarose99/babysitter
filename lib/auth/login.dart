
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 24.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          '$role Sign In',
          style: TextStyle(fontSize: 24.sp, color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
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
              SizedBox(height: 20.h),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Firebase Authentication login
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      User? user = userCredential.user;

                      // Fetch user data from Firestore
                      if (role == 'Parent') {
                        DocumentSnapshot parentDoc = await FirebaseFirestore.instance.collection('Parent').doc(user?.uid).get();
                        if (parentDoc.exists) {
                          context.goNamed('home');
                        } else {
                          print('Parent not found');
                        }
                      } else if (role == 'Sitter') {
                        DocumentSnapshot sitterDoc = await FirebaseFirestore.instance.collection('Babysitter/Nurseries').doc(user?.uid).get();
                        if (sitterDoc.exists) {
                          context.goNamed('home');
                        } else {
                          print('Sitter not found');
                        }
                      }
                    } catch (e) {
                      print('Error: $e');
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
                    'Sign In',
                    style: TextStyle(fontSize: 18.sp, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
