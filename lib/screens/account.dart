import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/UserInputProvider.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<account> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    print('UserProvider Name: ${userProvider.nameUser}');
    print('UserProvider Email: ${userProvider.emailUser}');

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 152),
              const Image(
                image: AssetImage('assets/account.png'),
                width: 128,
              ),
              const SizedBox(height: 32),
              Text(
                'Name: ${userProvider.nameUser}',
                style: GoogleFonts.inika(fontSize: 20),
              ),
              Text(
                'Email: ${userProvider.emailUser}',
                style: GoogleFonts.inika(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
    );
  }
}
