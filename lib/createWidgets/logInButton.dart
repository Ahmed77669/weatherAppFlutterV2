import 'package:weatherproject/firebase/authService.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'signUpButton.dart';
Widget logInButton(
  String text,
  BuildContext context,
  Widget screen,
  TextEditingController emailController,
  TextEditingController passwordController,
) {
  final Authservice authService = Authservice();
  return SizedBox(
    width: 342,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        try {
          String email = emailController.text;
          String password = passwordController.text;

          await authService.login(
            email: email,
            password: password,

          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),

          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('login failed. Please try again.')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 2, 120, 205),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}
