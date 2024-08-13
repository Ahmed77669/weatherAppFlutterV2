import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weatherproject/firebase/authService.dart';
import 'package:weatherproject/provider/UserInputProvider.dart';
import 'package:weatherproject/screens/login.dart';

import '../sqldb.dart';

SqlDb sqlDb = SqlDb();

Widget signupButton(
    String text,
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    ) {
  final Authservice authService = Authservice();
  return SizedBox(
    width: 342,
    height: 50,
    child: ElevatedButton(
      onPressed: () async {
        try {
          String name = nameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          String confirmPassword = confirmPasswordController.text;

          print('Name: $name');
          print('Email: $email');
          print('Password: $password');
          print('Confirm Password: $confirmPassword');

          // Call sign-up method
          await authService.signup(
            name: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword,
          );

          // Insert user data into local database
          int insertResult = await sqlDb.insertData(
            "INSERT INTO users (name, email) VALUES (?, ?)",
            [name, email],
          );
          print('Insert result: $insertResult');

          // Retrieve user data from local database
          List<Map<String, dynamic>> userData =
          await sqlDb.readData("SELECT * FROM users WHERE email = ?", [email]);
          print('Retrieved user data: $userData');

          if (userData.isNotEmpty) {
            print('Setting user data: Name: ${userData[0]['name']}, Email: ${userData[0]['email']}');

            // Update UserProvider with retrieved data
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            userProvider.setUserData(userData[0]['name'], userData[0]['email']);

            // Debugging print statements to verify
            print('UserProvider Name: ${userProvider.nameUser}');
            print('UserProvider Email: ${userProvider.emailUser}');
          } else {
            print('No user data found for the email: $email');
          }

          // Navigate to login screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login()),
          );
        } catch (e) {
          print('Error: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign-up failed. Please try again.')),
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