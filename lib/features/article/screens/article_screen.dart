import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ImageCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1543257580-7269da773bf5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                imageName: 'IMG-02312.JPG',
                dateCreated: DateTime.now(),
              ),
              ImageCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1529159942819-334f07de4fe5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fHw%3D',
                imageName: 'wheat_leaf_rust_01.jpg',
                dateCreated: DateTime.now(),
              ),
              ImageCard(
                imageUrl:
                    'https://images.unsplash.com/photo-1499959944748-fc3bed325ca3?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE5fHx8ZW58MHx8fHx8',
                imageName: 'wheat_leaf_blotch_06.png',
                dateCreated: DateTime.now(),
              ),
            ],
          ),
        ),
      ),
      // body: ImageCard(
      //     imageUrl:
      //         'https://images.unsplash.com/photo-1543257580-7269da773bf5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      //     imageName: 'IMG-02312.JPG',
      //     dateCreated: DateTime.now())
    );
  }
}

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String imageName;
  final DateTime dateCreated;

  const ImageCard({
    required this.imageUrl,
    required this.imageName,
    required this.dateCreated,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        elevation: 4,
        surfaceTintColor: const Color.fromARGB(255, 211, 206, 206),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.zero,
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image name
                      Text(
                        imageName,
                        style: const TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd HH:mm').format(dateCreated),
                        // style: const TextStyle(
                        //   fontFamily: 'SF-Pro-Text',
                        //   fontSize: 10,
                        //   fontWeight: FontWeight.w100,
                        // ),
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
// class ImageCard extends StatelessWidget {
//   final String imageUrl;
//   final String imageName;
//   final DateTime dateCreated;

//   const ImageCard({
//     required this.imageUrl,
//     required this.imageName,
//     required this.dateCreated,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 90,
//       child: Card(
//         elevation: 4,
//         surfaceTintColor: const Color.fromARGB(255, 211, 206, 206),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.zero,
//                   bottomLeft: Radius.circular(12),
//                   bottomRight: Radius.zero,
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//                 flex: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // image name
//                       Text(
//                         imageName,
//                         style: const TextStyle(
//                           fontFamily: 'Clash Display',
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Text(
//                         DateFormat('yyyy-MM-dd HH:mm').format(dateCreated),
//                         // style: const TextStyle(
//                         //   fontFamily: 'SF-Pro-Text',
//                         //   fontSize: 10,
//                         //   fontWeight: FontWeight.w100,
//                         // ),
//                         style: GoogleFonts.manrope(
//                           fontWeight: FontWeight.w300,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
