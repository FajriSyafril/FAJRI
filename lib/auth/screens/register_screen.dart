import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import library Firestore
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glass_login/auth/screens/homepage.dart';
import 'package:string_validator/string_validator.dart';

import '../../utils/app_colors.dart';
import '../../utils/styles/text_field_style.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({Key? key, required this.controller}) : super(key: key);

  final PageController controller;

  @override
  _SignUpScreen1State createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox.fromSize(
        size: MediaQuery.of(context).size,
        child: Stack(
          children: [
            Positioned(
              right: (MediaQuery.of(context).size.width / 2) - 150,
              top: 60,
              child: Transform.rotate(
                angle: -pi * 0,
                child: SvgPicture.asset(
                  'assets/svgs/medition_with_box.svg',
                  width: 300,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 300,
              child: Transform.rotate(
                angle: -pi * 0.1,
                child: Image.asset(
                  'assets/pngs/drugs.png',
                  width: 80,
                ),
              ),
            ),
            Positioned(
              right: 100,
              bottom: 30,
              child: Transform.rotate(
                angle: -pi * 0.04,
                child: Image.asset(
                  'assets/pngs/cardiogram.png',
                  width: 200,
                ),
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
                  key: fKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          color: AppColors.primaryHighContrast,
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) => _validateEmail(value),
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Email'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nameController,
                        validator: (value) => _validateName(value),
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Full Name'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passController,
                        validator: (value) => _validatePassword(value),
                        style: textFieldTextStyle(),
                        decoration: textFieldDecoration('Password'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      FractionallySizedBox(
                        widthFactor: 1,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.whiteColor,
                          ),
                          onPressed: () => _signUp(),
                          child: const Text("Create account"),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 2.5,
                          ),
                          InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              widget.controller.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Text(
                              'Log In ',
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {// kondisi ketik email kosong
      return "Enter your email";
    } else if (!isEmail(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter your name";
    } else if (value.length < 4) {
      return "Name must have at least 4 characters";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Enter your password";
    } else if (value.length < 6) {
      return "Password must have at least 6 characters";
    }
    return null;
  }

  Future<void> _signUp() async {
    //pendaftaran pengguna dengan mengguanakan FireBase Auth dan menyimpan ata pengguna ke CLoud firestore
    if (fKey.currentState!.validate()) {
      //Validasi
      try {
        UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //melakukan pendaftaran pengguna
          email: _emailController.text,
          password: _passController.text,
        );

        User? user = userCredential.user;

        if (user != null) {
          // Simpan data pengguna ke Cloud Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .set({
            'email': _emailController.text,
            'name': _nameController.text,
            'pass': _passController.text,
            // Tambahkan data lain yang perlu disimpan
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');

      }
    }
  }
}
