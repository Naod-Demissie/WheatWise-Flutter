// import 'package:flutter/material.dart';

// class RecordsScreen extends StatelessWidget {
//   const RecordsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Records Screen'),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wheatwise/features/records/screens/record_image_card.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Records',
          style: TextStyle(
            fontFamily: 'Clash Display',
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(child: noRecordFound()),
      // body: ImageCard(
      //     imageUrl:
      //         'https://images.unsplash.com/photo-1543257580-7269da773bf5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      //     imageName: 'IMG-02312.JPG',
      //     dateCreated: DateTime.now())
    );
  }

  Widget noRecordFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 180,
          child: Image.asset('assets/images/no-file-found.png'),
        ),
        const Text(
          'No records found',
          style: TextStyle(
            fontFamily: 'Clash Display',
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
