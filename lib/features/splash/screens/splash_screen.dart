import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Image.asset(
                          'assets/logo/aii.png',
                          // height: 80,
                          width: 90, //! change this with media query height
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
