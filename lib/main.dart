import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:weatherproject/consts&globals/consts.dart';
import 'package:weatherproject/provider/UserInputProvider.dart';
import 'package:weatherproject/screens/account.dart';
import 'package:weatherproject/screens/login.dart';
import 'consts&globals/globals.dart';
import 'firebase/firebase_options.dart';
import 'screens/Welcome.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: welcome(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  List<Weather> _hourlyForecast = [];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  void fetchWeather() async {
    try {
      Weather? weather = await _wf.currentWeatherByCityName(userInput);
      List<Weather> forecast = await _wf.fiveDayForecastByCityName(userInput);
      List<Weather> filteredDailyForecast = forecast
          .where((f) => f.date != null && [12].contains(f.date!.hour))
          .toList();
      setState(() {
        _weather = weather;
        _hourlyForecast = filteredDailyForecast;
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  String changeIcon() {
    final description = _weather?.weatherDescription?.toLowerCase() ?? '';
    if (description.contains('rain')) {
      return 'rain_w';
    } else if (description.contains('cloud')) {
      return 'cloud_w';
    } else if (description.contains('clear')) {
      return 'clear_w';
    } else if (description.contains('drizzle')) {
      return 'drizzle_w';
    } else if (description.contains('snow')) {
      return 'snow_w';
    } else if (description.contains('snowy')) {
      return 'snow_w';
    } else if (description.contains('storm')) {
      return 'storm_w';
    } else if (description.contains('sto')) {
      return 'storm_w';
    } else {
      return 'cloud_w';
    }
  }

  String changeBackground() {
    final description = _weather?.weatherDescription?.toLowerCase() ?? '';
    if (description.contains('rain')) {
      return 'rain';
    } else if (description.contains('cloud')) {
      return 'cloud';
    } else if (description.contains('clear')) {
      return 'clear';
    } else if (description.contains('drizzle')) {
      return 'drizzle';
    } else if (description.contains('snow')) {
      return 'snow';
    } else if (description.contains('snowy')) {
      return 'snow';
    } else if (description.contains('storm')) {
      return 'storm';
    } else if (description.contains('stormy')) {
      return 'storm';
    } else {
      return 'cloud';
    }
  }

  @override
  Widget build(BuildContext context) {
    String x = changeIcon();
    String y = changeBackground();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/$y.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 70),
                  SizedBox(
                    width: 360,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter Name of City',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              userInput = searchController.text;
                              fetchWeather();
                            });
                            print('Search icon pressed: $userInput');
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image(
                    image: AssetImage("assets/$x.png"),
                    width: 160,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _weather?.areaName ?? "",
                            style: GoogleFonts.asap(
                              color: Colors.white,
                              fontSize: 54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${_weather?.temperature?.celsius?.toStringAsFixed(0)} Cº',
                            style: GoogleFonts.asap(
                              color: Colors.white,
                              fontSize: 54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${_weather?.weatherDescription?.toString()}',
                            style: GoogleFonts.asap(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}º   Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}º',
                            style: GoogleFonts.asap(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 59,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 233, 233, 233),
                        image: const DecorationImage(
                          image: AssetImage("assets/him.png"),
                          fit: BoxFit.none,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_weather?.humidity?.toStringAsFixed(0)}%",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Humidity',
                      style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 136, 136, 136)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 59,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 233, 233, 233),
                        image: const DecorationImage(
                          image: AssetImage("assets/wind.png"),
                          fit: BoxFit.none,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Wind',
                      style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 136, 136, 136)),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 59,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 233, 233, 233),
                        image: const DecorationImage(
                          image: AssetImage("assets/rain_w.png"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _weather?.rainLast3Hours != null
                          ? "${_weather?.rainLast3Hours?.toStringAsFixed(0)}%"
                          : "0%",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Rain',
                      style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 136, 136, 136)),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Text(
                  'Next 5 days : ',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ..._hourlyForecast.map((forecast) {
                  return weekWeather(
                    '${forecast.date!.day.toString().padLeft(2, '0')}/${forecast.date!.month.toString().padLeft(2, '0')}',
                    '${forecast.temperature?.celsius?.toStringAsFixed(0)}º',
                    'assets/${changeIcon()}.png',
                  );
                }),
              ],
            ),
            const SizedBox(height: 40),
            accountButton('Your account > ', context),
            const SizedBox(height: 40),
          ],
        ),
      ),
      backgroundColor:Colors.white,
    );
  }

  Widget weekWeather(String time, String temperature, String path) {
    return Container(
      width: 60,
      height: 110,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image(
            image: AssetImage(path),
            width: 100,
          ),
          Text(
            temperature,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),


        ],
      ),
    );
  }

  Widget accountButton(
      String text,
      BuildContext context,
      ) {
    return SizedBox(
      width: 342,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
         Navigator.push(context, BottomToTopPageRoute(page: account()));
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

}
