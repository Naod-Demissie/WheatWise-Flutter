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
