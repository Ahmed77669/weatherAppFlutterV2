import 'package:weatherproject/screens/login.dart';
import 'package:weatherproject/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // final TextEditingController searchController = TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const welcome(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class BottomToTopPageRoute extends PageRouteBuilder {
  final Widget page;

  BottomToTopPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation =
                animation.drive(tween.chain(CurveTween(curve: curve)));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
}

class welcome extends StatefulWidget {
  const welcome({super.key});

  // final TextEditingController searchController;
  //
  // const NavigationExample({super.key, required this.searchController});

  @override
  State<welcome> createState() => _NavigationExampleState();

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
}

class _NavigationExampleState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
     return  Scaffold(
       body: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 289,
              ),
              const Image(
                image: AssetImage('assets/app_icon.png'),
                width: 64,
              ),
              const SizedBox(
                height: 17,
              ),
              const Text(
                'WeatherFlow',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(
                height: 47,
              ),
              SizedBox(
                  width: 340,
                  height: 200,
                  child: Text(
                    'Welcome to WeatherFlow – your personal weather companion. Get real-time weather updates and 5-day forecasts at your fingertips. Stay informed about the latest weather conditions and plan your day with ease',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sintony(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 142, 142, 147),
                    ),
                  )),
              const SizedBox(
                height: 120,
              ),
              SizedBox(
                width: 342,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context, BottomToTopPageRoute(page: const signup()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 120, 205),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: 342,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      BottomToTopPageRoute(page: const login()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color.fromARGB(255, 2, 120, 205),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 2, 120, 205),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
     ),

    backgroundColor:Colors.white,

    );
  }
}
