import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:string_validator/string_validator.dart';
import '../../utils/app_colors.dart';
import '../../utils/styles/text_field_style.dart';
import '../../utils/utils.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.sizeOf(context),
        child: Stack(
          children: [
            // ... (your existing positioned images)
            Positioned(
              right: 40,
              top: 140,
              child: Transform.rotate(
                angle: -pi * .1,
                child: Image.asset(
                  'assets/pngs/medical.png',
                  width: 60,
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 300,
              child: Transform.rotate(
                angle: -pi * 0.05,
                child: Image.asset(
                  'assets/pngs/health-care.png',
                  width: 50,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 20,
              child: Transform.rotate(
                angle: -pi * 0.14,
                child: Image.asset(
                  'assets/pngs/antibiotic.png',
                  width: 120,
                ),
              ),
            ),
            Positioned(
              left: -50,
              top: 10,
              child: Image.asset(
                'assets/pngs/pills.png',
                width: 300,
              ),
            ),
            Positioned(
              left: 30,
              right: 30,
              bottom: 30,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your email.";
                          } else if (!isEmail(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Email'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            loadingDialog(context);
                            try {
                              await _auth.sendPasswordResetEmail(
                                email: _emailController.text.trim(),
                              );
                              //Tutup loading dialog
                              Navigator.pop(context);

                              // Show success message or navigate to another screen
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Reset Password"),
                                    content: Text(
                                      "Password reset email has been sent to your email address.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (e) {
                              print('Error: $e');
                              Navigator.pop(context); // Close loading dialog
                              // Handle errors, e.g., display an error message.
                            }
                          }
                        },
                        child: const Text("Reset Password"),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Remember your password? ",
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: AppColors.primaryHighContrast,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
