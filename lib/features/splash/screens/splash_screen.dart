import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';
import 'package:wheatwise/features/auth/login/screens/login_screen.dart';
import 'package:wheatwise/features/page_navigator/screens/page_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    initializeApp();
  }

  void initializeApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool isLoggedIn = token != null;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 2), () {
      final checkAuthState = BlocProvider.of<CheckAuthBloc>(context).state;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          if (checkAuthState is CheckAuthSuccessState || isLoggedIn) {
            return const PageNavigator();
          } else {
            return const LoginScreen();
          }
        }),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/wheat-field-bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xFF111122)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 150),
                      child: Image.asset(
                        'assets/logo/wheatwise-logo-white.png',
                        height: 70,
                        // width: 90, //! change this with media query height
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          ' Powered By',
                          style: TextStyle(
                            fontFamily: 'Clash Display',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Image.asset(
                          'assets/logo/aii.png',
                          // height: 80,
                          width: 100, //! change this with media query height
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
    );
  }
}

