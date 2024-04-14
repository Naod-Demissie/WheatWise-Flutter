import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wheatwise/features/resources/constants.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CupertinoActivityIndicator(
                          color: kPrimaryColor,
                          radius: 16,
                        ),
                      ),
                      // SizedBox(height: 5),
                      Text('Loading...'

                      
                      
                      ),
                    ],
                  ),
                ),
              ),
            );

            // Simulate a time-consuming operation
            Future.delayed(const Duration(seconds: 6), () {
              Navigator.of(context).pop(); // Close the dialog
            });
          },
          child: const Text('Show Progress Dialog'),
        ),
      ),
    );
  }
}
