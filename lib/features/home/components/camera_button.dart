// // import 'dart:io';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:wheatwise/features/resources/constants.dart';

// // class CameraButton extends StatefulWidget {
// //   const CameraButton({super.key});

// //   @override
// //   State<CameraButton> createState() => _CameraButtonState();
// // }

// // class _CameraButtonState extends State<CameraButton> {
// //   File? _image;
// //   final imagePicker = ImagePicker();

// //   Future<void> getImage() async {
// //     final image = await imagePicker.pickImage(source: ImageSource.camera);

// //     setState(() {
// //       _image = image?.path != null ? File(image!.path) : null;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double iconSize = MediaQuery.of(context).size.width *
// //         0.07; // calculate icon size based on screen width

// //     return ElevatedButton(
// //       onPressed: getImage,
// //       style: ButtonStyle(
// //         backgroundColor: MaterialStateProperty.all<Color>(
// //             const Color.fromRGBO(248, 147, 29, 1)),
// //         minimumSize: MaterialStateProperty.all(
// //           const Size(double.infinity, 52),
// //         ),
// //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //           RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           SvgPicture.asset(
// //             'assets/icons/scan-icon.svg',
// //             color: Colors.white,
// //             width: 18,
// //             height: 18,
// //           ),
// //           SizedBox(width: 5),
// //           const Text(
// //             "Detect Now",
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontFamily: 'SF-Pro-Text',
// //               fontSize: 14.0,
// //               fontWeight: FontWeight.w800,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';



// class ImagePickerPage extends StatefulWidget {
//   @override
//   _ImagePickerPageState createState() => _ImagePickerPageState();
// }

// class _ImagePickerPageState extends State<ImagePickerPage> {

//   Future<void> _getImageFromCamera() async {
//     final imagePicker = ImagePicker();
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     if (image != null) {
//       setState(() {
//         _image = image;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: _getImageFromCamera,
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromRGBO(248, 147, 29, 1)),
//               minimumSize: MaterialStateProperty.all(
//                 const Size(double.infinity, 52),
//               ),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(
//                   'assets/icons/scan-icon.svg',
//                   color: Colors.white,
//                   width: 18,
//                   height: 18,
//                 ),
//                 const SizedBox(width: 5),
//                 const Text(
//                   "Capture from Camera",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'SF-Pro-Text',
//                     fontSize: 15.0,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//               ],
//             ),
//           );
    
//   }
// }
