import 'package:weatherproject/createWidgets/resetPasswordButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherproject/createWidgets/createTextField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: resetPassword(),
    );
  }

  @override

  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}

class resetPassword extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<resetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NavigationBar(
      //   backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       currentPageIndex = index;
      //     });
      //   },
      //   selectedIndex: currentPageIndex,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home_outlined),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.map_outlined),
      //       label: 'Map',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      // ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 152),
              const Image(
                image: AssetImage('assets/app_icon.png'),
                width: 64,
              ),
              const SizedBox(
                height: 82,
              ),
              Text(
                'Reset Password',
                style: GoogleFonts.inika(fontSize: 30),
              ),
              const SizedBox(
                height: 28,
              ),
              createTextField('Email', false, _emailController),
              const SizedBox(
                height: 60,
              ),
              resetPasswordButton(context, _emailController),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
    );
  }
}
