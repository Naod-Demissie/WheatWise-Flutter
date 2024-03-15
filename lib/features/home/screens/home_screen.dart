// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Home Screen'),
//     );
//   }
// }

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(),
                ],
              )
            ],
          ),
        ),
      ),
    )
        // appBar: AppBar(
        //   title: const Text('Home'),
        // ),

        // body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     // const Text(
        //     //   'Good evening',
        //     //   style: TextStyle(
        //     //     fontSize: 24,
        //     //     fontWeight: FontWeight.bold,
        //     //   ),
        //     // ),
        //     // const SizedBox(height: 20),
        //     // ElevatedButton(
        //     //   onPressed: () {
        //     //     // Implement logout logic here
        //     //   },
        //     //   child: const Text('Log out'),
        //     ),
        //   ],
        // ),
        // ),
        );
  }
}
