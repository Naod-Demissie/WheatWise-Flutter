import 'package:flutter/material.dart';

class DiagnosisDetailScreen extends StatefulWidget {
  const DiagnosisDetailScreen({super.key});

  @override
  State<DiagnosisDetailScreen> createState() => _DiagnosisDetailScreenState();
}

class _DiagnosisDetailScreenState extends State<DiagnosisDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [],
        ),
      ),
    );
  }
}

// import 'package:coffeenet/application/manual_diagnosis_bloc/manual_diagnosis_bloc.dart';
// import 'package:multiselect/multiselect.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';

// import 'detail_page_imports.dart';

// class DetailPage extends StatefulWidget {
//   const DetailPage({Key? key}) : super(key: key);
//   @override
//   State<DetailPage> createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;
//   bool clicked = false;
//   int imagePage = 1;
//   _DetailPageState();

//   late final ManualDiagnosisBloc manualDiagnosisBloc;
//   TextEditingController textEditingController = TextEditingController();

//   List<String> selectedResults = [];
//   // Initial Selected Value
//   String finalDiagnosis = 'Healthy';
//   int severityLevel = 0;
//   bool copperBasedSynthetic = false;
//   bool resistantVarieties = false;

//   // List of items in our dropdown menu
//   var items = [
//     'Healthy',
//     'Un-Healthy',
//   ];
//   var severityOptions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

//   void _changeImage(int page) {
//     setState(() {
//       imagePage = page;
//     });
//   }

//   void _changePage(int page) {
//     setState(() {
//       // _currentPage = (_currentPage + 1) % 4;
//       _currentPage = page;
//       _pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   // final ScrollController _imageController = ScrollController();
//   final PageController _imageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     manualDiagnosisBloc = BlocProvider.of<ManualDiagnosisBloc>(context);
//   }

//   @override
//   void dispose() {
//     _imageController.dispose();
//     manualDiagnosisBloc.add(ManualDiagnosisCancel());
//     super.dispose();
//   }

//   Widget diseaseNotDetected(BuildContext context, Color color) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.check_circle,
//             color: color,
//             size: 60,
//           ),
//           const SizedBox(height: 10),
//           Text(
//             "No disease is detected in this leaf.",
//             textAlign: TextAlign.center,
//             style: GoogleFonts.montserrat(
//               fontSize: 25.0,
//               fontWeight: FontWeight.normal,
//               color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                       Colors.white
//                   ? const Color(0xFF2C2C2C)
//                   : Color.fromARGB(255, 194, 193, 193),
//             ),
//           )
//         ],
//       );

//   List<String> aboutDisease = [
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Free Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//   ];

//   List<String> preventDisease = [
//     """\tTo prevent Free Feeder Coffee Leaf Disease (FFCLD) in your coffee plants, follow these key steps:
//     1. Maintain Good Hygiene: Remove and destroy infected leaves and plant debris promptly to prevent the spread of the disease.
//     2. Pruning and Shading: Proper pruning practices promote airflow and sunlight penetration, creating an unfavorable environment for the disease.
//     3. Plant Resistant Varieties: Choose coffee cultivars that show resistance or tolerance to FFCLD to minimize the risk of infection.
//     4. Balanced Fertilization: Ensure optimal nutrient levels in the soil to keep coffee plants healthy and less susceptible to diseases.
//     5. Regular Monitoring: Keep a close eye on your plants for early detection of FFCLD symptoms. Act swiftly to isolate and treat infected plants.
//     6. Training and Education: Stay informed about FFCLD management strategies through farmer training programs and agricultural extension services.
//     """,
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//   ];
//   List<String> mitigateDisease = [
//     """To mitigate the impact of Free Feeder Coffee Leaf Disease (FFCLD) on your coffee farm, consider the following effective methods:
//     1. Timely Pruning: Regularly prune infected branches and remove diseased plant material to prevent the spread of the disease.
//     2. Fungicide Application: Apply appropriate fungicides as recommended by agricultural experts to control FFCLD. Follow label instructions and use them judiciously.
//     3. Sanitation Practices: Practice proper sanitation by disposing of fallen leaves and debris, reducing the potential for disease recurrence.
//     4. Plant Resistant Varieties: Opt for coffee cultivars with resistance or tolerance to FFCLD to minimize the disease's impact on your crops.
//     5. Crop Rotation: Implement crop rotation strategies to break the disease cycle and reduce the disease pressure.
//     6. Integrated Pest Management (IPM): Adopt holistic IPM approaches, including monitoring, biological control agents, and cultural practices, to manage FFCLD sustainably.""",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//     "Feeder Coffee Leaf Disease (FFCLD) is a harmful infection that affects coffee plants, and as a farmer, it's crucial to be aware of its impact. FFCLD is caused by a fungus called Phaeochoropsis neowallichii, and it primarily attacks the leaves of coffee plants. You can identify the disease by circular lesions on the leaves, surrounded by yellow halos. These lesions grow and merge, leading to leaf loss and reduced plant health. FFCLD mainly affects Arabica coffee, leading to lower yields and poorer bean quality. To manage FFCLD, practice good agricultural techniques, consider resistant coffee varieties, monitor your crops regularly, and stay informed about effective farming practices. By taking proactive measures, you can minimize the impact of FFCLD and protect your coffee plants.",
//   ];

//   List<Color> colors = [
//     Color.fromARGB(255, 255, 0, 0),
//     Color.fromARGB(255, 0, 0, 255),
//     Color.fromARGB(255, 0, 100, 100),
//   ];

//   Widget diseaseDetected(
//       _aboutDisease, mitigationMethod, moreReco, width, color) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(width * 0.1, 16.0, 0, 0),
//             child: Text('About The Disease',
//                 style: GoogleFonts.openSans(
//                     fontSize: 24,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//             child: Text(_aboutDisease,
//                 selectionColor: color,
//                 style: GoogleFonts.sourceCodePro(
//                     fontSize: 18,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.normal)),
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(width * 0.1, 16.0, 0, 0),
//             child: Text('Mitigation',
//                 style: GoogleFonts.openSans(
//                     fontSize: 24,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//             child: Text(mitigationMethod,
//                 // textAlign: TextAlign.justify,
//                 // style: GoogleFonts.roboto(
//                 //   fontSize: 16.0,
//                 //   fontWeight: FontWeight.normal,
//                 // ),
//                 style: GoogleFonts.sourceCodePro(
//                     fontSize: 18,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.normal)),
//           ),
//           Container(
//             padding: EdgeInsets.fromLTRB(width * 0.1, 16.0, 0, 0),
//             child: Text('Preventation',
//                 // style: TextStyle(fontSize: 18.0),
//                 style: GoogleFonts.openSans(
//                     fontSize: 24,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.bold)),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.1),
//             child: Text(moreReco,
//                 // textAlign: TextAlign.justify,
//                 // style: GoogleFonts.roboto(
//                 //   fontSize: 16.0,
//                 //   fontWeight: FontWeight.normal,
//                 // ),
//                 style: GoogleFonts.sourceCodePro(
//                     fontSize: 18,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                     fontWeight: FontWeight.normal)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DetailPageBloc, DetailPageState>(
//         builder: (context, state) {
//       if (state is DetailPageSuccessState) {
//         return SafeArea(
//           child: Scaffold(
//             extendBodyBehindAppBar: true,
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               actions: [
//                 BlocBuilder<BookmarkBloc, BookmarkState>(
//                     builder: (context, state2) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       elevation: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 3.0),
//                         child: IconButton(
//                           icon: state.leafDetail.detectedLeaf.bookmarked
//                               ? Icon(Icons.bookmark, color: kPrimaryColor)
//                               : Icon(Icons.bookmark_outline_outlined,
//                                   color: kPrimaryColor),
//                           onPressed: () {
//                             BlocProvider.of<BookmarkBloc>(context).add(
//                                 AddBookmarkEvent(
//                                     bookmark: state.leafDetail.detectedLeaf));
//                             BlocProvider.of<DetailPageBloc>(context).add(
//                                 LoadDetailPageEvent(
//                                     leaf: state.leafDetail.detectedLeaf));
//                           },
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ],
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 2.0),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15)),
//                     color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
//                     child: Icon(
//                       Icons.chevron_left_rounded,
//                       size: 30,
//                       color:
//                           BlocProvider.of<ThemeBloc>(context).state.blackColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Container(
//                 color: BlocProvider.of<ThemeBloc>(context).state.whiteColor,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(
//                       height: MediaQuery.of(context).size.height / 2.5,
//                       child: Stack(children: [
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                               bottomLeft: Radius.circular(0)),
//                           child: SizedBox(
//                             child: PageView(
//                               controller: _imageController,
//                               scrollDirection: Axis.horizontal,
//                               allowImplicitScrolling: true,
//                               onPageChanged: (page) {
//                                 // print(page);
//                                 setState(() {
//                                   imagePage = page + 1;
//                                 });
//                               },
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => FullScreenImage(
//                                             imagefile:
//                                                 state.leafDetail.detectedImage),
//                                       ),
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width,
//                                     child: RotatedBox(
//                                       quarterTurns: 3,
//                                       child: Image.file(
//                                           state.leafDetail.detectedImage,
//                                           fit: BoxFit.fill),
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => FullScreenImage(
//                                           imagefile:
//                                               state.leafDetail.originalImage,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: SizedBox(
//                                     width: MediaQuery.of(context).size.width,
//                                     child: RotatedBox(
//                                       quarterTurns: 3,
//                                       child: Image.file(
//                                           state.leafDetail.originalImage,
//                                           fit: BoxFit.fill),
//                                     ),
//                                   ),
//                                 ),
//                                 // Add more images as needed
//                               ],
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           imagePage == 1
//                               ? Text(
//                                   "Severity: ${state.leafDetail.detectedLeaf.severity}",
//                                   style: TextStyle(
//                                       color: BlocProvider.of<ThemeBloc>(context)
//                                           .state
//                                           .blackColor,
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.w600))
//                               : Text(" Original Image",
//                                   style: TextStyle(
//                                       color: BlocProvider.of<ThemeBloc>(context)
//                                           .state
//                                           .blackColor,
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.w600)),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               IconButton(
//                                   onPressed: imagePage == 1
//                                       ? null
//                                       : () {
//                                           _imageController.animateTo(0,
//                                               duration:
//                                                   Duration(milliseconds: 500),
//                                               curve: Curves.easeOut);
//                                         },
//                                   icon: Icon(
//                                     Icons.chevron_left_rounded,
//                                     color: imagePage == 1
//                                         ? kPrimaryColor.withAlpha(50)
//                                         : kPrimaryColor,
//                                     size: 40,
//                                   )),
//                               IconButton(
//                                 onPressed: imagePage == 2
//                                     ? null
//                                     : () {
//                                         _imageController.animateTo(
//                                             MediaQuery.of(context).size.width,
//                                             duration:
//                                                 Duration(milliseconds: 500),
//                                             curve: Curves.easeOut);
//                                       },
//                                 icon: Icon(
//                                   Icons.chevron_right_rounded,
//                                   color: imagePage == 2
//                                       ? kPrimaryColor.withAlpha(50)
//                                       : kPrimaryColor,
//                                   size: 40,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(),
//                     Container(
//                       height: MediaQuery.of(context).size.height / 22,
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount:
//                               state.leafDetail.detectedLeaf.diseases.length,
//                           itemBuilder: (context, ind) {
//                             print(ind);
//                             return Row(children: [
//                               Container(
//                                 padding: EdgeInsets.fromLTRB(12, 10, 12, 10),
//                                 margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
//                                 decoration: BoxDecoration(
//                                   color: 0 == ind ? colors[0] : colors[1],
//                                 ),
//                                 child: Text(
//                                   state.leafDetail.detectedLeaf.diseases[ind]
//                                       .split("_")
//                                       .join(" ")
//                                       .toUpperCase(),
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                               // OutlinedButton(
//                               //   onPressed: () {
//                               //     clicked = true;
//                               //     _changePage(ind);
//                               //   },
//                               //   style: ElevatedButton.styleFrom(
//                               //     backgroundColor: _currentPage == ind
//                               //         ? colors[ind % 3]
//                               //         : null,
//                               //     foregroundColor: _currentPage == ind
//                               //         ? BlocProvider.of<ThemeBloc>(context)
//                               //             .state
//                               //             .whiteColor
//                               //         : colors[ind % 3],
//                               //   ),
//                               //   child: Text(
//                               //     state.leafDetail.detectedLeaf.diseases[ind]
//                               //         .split("_")
//                               //         .join(" "),
//                               //   ),
//                               // ),
//                               // const SizedBox(width: 10.0),
//                             ]);
//                           }),
//                     ),
//                     // manual diagnosis checkbox
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       child: BlocConsumer<ManualDiagnosisBloc,
//                           ManualDiagnosisState>(
//                         listener: (context, state) {
//                           // TODO: implement listener
//                         },
//                         builder: (context, manualState) {
//                           if (manualState is ManualDiagnosisEditing) {
//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding:
//                                         const EdgeInsets.fromLTRB(10, 5, 10, 0),
//                                     child: manualDiagnosisDropdown(
//                                         state.leafDetail.detectedLeaf.dataId),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }
//                           if (manualState is ManualDiagnosisLoaded) {
//                             return Padding(
//                               padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Text(
//                                     "Manual Diagnosis",
//                                     softWrap: true,
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Checkbox(value: true, onChanged: null),
//                                       Text(
//                                         "Disease:",
//                                         style: GoogleFonts.openSans(
//                                             fontSize: 18,
//                                             color: BlocProvider.of<ThemeBloc>(
//                                                             context)
//                                                         .state
//                                                         .whiteColor ==
//                                                     Colors.white
//                                                 ? const Color(0xFF2C2C2C)
//                                                 : Color.fromARGB(
//                                                     255, 194, 193, 193),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           manualState.diseases.join(', '),
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.italic,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Checkbox(value: true, onChanged: null),
//                                       Text(
//                                         "Severity:",
//                                         style: GoogleFonts.openSans(
//                                             fontSize: 18,
//                                             color: BlocProvider.of<ThemeBloc>(
//                                                             context)
//                                                         .state
//                                                         .whiteColor ==
//                                                     Colors.white
//                                                 ? const Color(0xFF2C2C2C)
//                                                 : Color.fromARGB(
//                                                     255, 194, 193, 193),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           manualState.severity,
//                                           style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w400,
//                                             fontStyle: FontStyle.italic,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     "Management Suggestion",
//                                     style: GoogleFonts.openSans(
//                                         fontSize: 18,
//                                         color:
//                                             BlocProvider.of<ThemeBloc>(context)
//                                                         .state
//                                                         .whiteColor ==
//                                                     Colors.white
//                                                 ? const Color(0xFF2C2C2C)
//                                                 : Color.fromARGB(
//                                                     255, 194, 193, 193),
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   manualState.resistantVarieties != null
//                                       ? Row(
//                                           children: [
//                                             Checkbox(
//                                                 value: true, onChanged: null),
//                                             Expanded(
//                                               child: Text(
//                                                 manualState.resistantVarieties!,
//                                                 style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.italic,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : const SizedBox(),
//                                   manualState.copperBasedSynthetic != null
//                                       ? Row(
//                                           children: [
//                                             Checkbox(
//                                                 value: true, onChanged: null),
//                                             Expanded(
//                                               child: Text(
//                                                 manualState
//                                                     .copperBasedSynthetic!,
//                                                 style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.w400,
//                                                   fontStyle: FontStyle.italic,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : const SizedBox(),
//                                   manualState.additionalSuggestion != null
//                                       ? Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               "Additional Suggestions",
//                                               style: GoogleFonts.openSans(
//                                                   fontSize: 18,
//                                                   color: BlocProvider.of<
//                                                                       ThemeBloc>(
//                                                                   context)
//                                                               .state
//                                                               .whiteColor ==
//                                                           Colors.white
//                                                       ? const Color(0xFF2C2C2C)
//                                                       : Color.fromARGB(
//                                                           255, 194, 193, 193),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Checkbox(
//                                                   value: true,
//                                                   onChanged: null,
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     manualState
//                                                         .additionalSuggestion!,
//                                                     style: TextStyle(
//                                                       fontSize: 17,
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       fontStyle:
//                                                           FontStyle.italic,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                       : const SizedBox(),
//                                   (manualState.resistantVarieties == null &&
//                                           manualState.copperBasedSynthetic ==
//                                               null &&
//                                           manualState.additionalSuggestion ==
//                                               null)
//                                       ? Row(
//                                           children: [
//                                             Checkbox(
//                                                 value: true, onChanged: null),
//                                             Text(
//                                               "No Suggestion Added!",
//                                               style: TextStyle(
//                                                 fontSize: 17,
//                                                 fontWeight: FontWeight.w400,
//                                                 fontStyle: FontStyle.italic,
//                                               ),
//                                             ),
//                                           ],
//                                         )
//                                       : const SizedBox(),
//                                 ],
//                               ),
//                             );
//                           }
//                           if (manualState is ManualDiagnosisNotAdded) {
//                             return TextButton(
//                               style: ButtonStyle(
//                                 padding:
//                                     MaterialStateProperty.all(EdgeInsets.zero),
//                               ),
//                               onPressed: () => manualDiagnosisBloc
//                                   .add(ManualDiagnosisEdit()),
//                               child: Container(
//                                 padding:
//                                     const EdgeInsets.fromLTRB(5, 10, 10, 10),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(6),
//                                     border: Border.all(
//                                       color: Colors.black,
//                                     )),
//                                 child: Text(
//                                   "Add Manual Diagnosis",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                           if (manualState is ManualDiagnosisFailed) {
//                             // QuickAlert.show(
//                             //     context: context,
//                             //     type: QuickAlertType.error,
//                             //     title: 'Adding Manual Diagnosis Failed...',
//                             //     text: 'Sorry, something went wrong.',
//                             //     confirmBtnColor: Colors.green,
//                             //     onConfirmBtnTap: () {
//                             //       // Navigator.of(context).pop();
//                             //     });
//                             // return Text(manualState.errMsg);
//                             return Container(
//                               margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.error,
//                                         // color: Colors.red,
//                                         size: 30,
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         "Failed To Load Manual Diagnosis",
//                                         style: GoogleFonts.openSans(
//                                             fontSize: 15,
//                                             color: BlocProvider.of<ThemeBloc>(
//                                                             context)
//                                                         .state
//                                                         .whiteColor ==
//                                                     Colors.white
//                                                 ? const Color(0xFF2C2C2C)
//                                                 : Color.fromARGB(
//                                                     255, 194, 193, 193),
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       manualDiagnosisBloc.add(
//                                         ManualDiagnosisLoad(
//                                             diagnosisId: (state.leafDetail
//                                                     .detectedLeaf.dataId)
//                                                 .toString()),
//                                       );
//                                     },
//                                     child: Text(
//                                       "Retry",
//                                       style: GoogleFonts.openSans(
//                                           fontSize: 15,
//                                           color: Colors.blue,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           }
//                           if (manualState is ManualDiagnosisLoading) {
//                             return Container(
//                               padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                               child: Center(
//                                   child: CircularProgressIndicator.adaptive()),
//                             );
//                           }
//                           manualDiagnosisBloc.add(
//                             ManualDiagnosisLoad(
//                                 diagnosisId:
//                                     (state.leafDetail.detectedLeaf.dataId)
//                                         .toString()),
//                           );
//                           return const SizedBox();
//                         },
//                       ),
//                     ),
//                     // Expanded(
//                     //   child: Padding(
//                     //     padding: const EdgeInsets.only(bottom: 8.0),
//                     //     child: state.leafDetail.detectedLeaf.diseases.length == 0
//                     //         ? diseaseNotDetected(context, Colors.green)
//                     //         : PageView.builder(
//                     //             itemCount:
//                     //                 state.leafDetail.detectedLeaf.diseases.length,
//                     //             controller: _pageController,
//                     //             onPageChanged: (int page) {
//                     //               if (clicked == false) {
//                     //                 setState(() async {
//                     //                   _currentPage = page;
//                     //                 });
//                     //                 clicked = false;
//                     //               }
//                     //             },
//                     //             itemBuilder: (BuildContext context, int index) {
//                     //               return state.leafDetail.detectedLeaf.diseases
//                     //                       .isNotEmpty
//                     //                   ? diseaseDetected(
//                     //                       aboutDisease[index],
//                     //                       mitigateDisease[index],
//                     //                       preventDisease[index],
//                     //                       MediaQuery.of(context).size.width,
//                     //                       colors[index % 3])
//                     //                   : diseaseNotDetected(
//                     //                       context, colors[index % 3]);
//                     //             },
//                     //           ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       } else if (state is DetailPageLoadingState) {
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       } else {
//         return const Scaffold(
//             body: Center(child: Text("Error Loading Detail page!")));
//       }
//     });
//   }

//   Widget manualDiagnosisDropdown(int dataId) {
//     return Column(
//       children: [
//         finalDecisionSelector(),
//         finalDiagnosis == "Un-Healthy"
//             ? Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ),
//                 child: leafDiseaseSelector(),
//               )
//             : const SizedBox(),
//         finalDiagnosis == "Un-Healthy"
//             ? Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ),
//                 child: severityLevelSelector(),
//               )
//             : const SizedBox(),
//         finalDiagnosis == "Un-Healthy"
//             ? Container(
//                 width: double.infinity,
//                 margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     top: BorderSide(
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ),
//                 child: managementOptions(),
//               )
//             : const SizedBox(),
//         SizedBox(
//           height: 15,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             saveManualDiagnosis(dataId),
//             cancelManualDiagnosis(),
//           ],
//         ),
//         SizedBox(
//           height: 15,
//         ),
//       ],
//     );
//   }

//   Widget finalDecisionSelector() {
//     return Row(
//       children: [
//         Text(
//           "Final Decision",
//           style: GoogleFonts.openSans(
//               fontSize: 15,
//               color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                       Colors.white
//                   ? const Color(0xFF2C2C2C)
//                   : Color.fromARGB(255, 194, 193, 193),
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Container(
//           padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(
//               color: Colors.black,
//             ),
//           ),
//           child: DropdownButton<String>(
//             // Initial Value
//             value: finalDiagnosis,

//             underline: Container(),
//             padding: EdgeInsets.all(0),

//             // Down Arrow Icon
//             icon: const Icon(Icons.keyboard_arrow_down),

//             // Array list of items
//             items: items.map((String items) {
//               return DropdownMenuItem(
//                 value: items,
//                 child: Text(
//                   items,
//                   style: GoogleFonts.openSans(
//                     // fontSize: 15,
//                     color:
//                         BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                                 Colors.white
//                             ? const Color(0xFF2C2C2C)
//                             : Color.fromARGB(255, 194, 193, 193),
//                   ),
//                 ),
//               );
//             }).toList(),
//             // After selecting the desired option,it will
//             // change button value to selected value
//             onChanged: (String? newValue) {
//               setState(() {
//                 finalDiagnosis = newValue!;
//                 if (finalDiagnosis == "Healthy") {
//                   selectedResults = [];
//                   severityLevel = 0;
//                 }
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget leafDiseaseSelector() {
//     return Row(
//       children: [
//         Text("Leaf Disease",
//             style: GoogleFonts.openSans(
//                 fontSize: 15,
//                 color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                         Colors.white
//                     ? const Color(0xFF2C2C2C)
//                     : Color.fromARGB(255, 194, 193, 193),
//                 fontWeight: FontWeight.bold)),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: DropDownMultiSelect(
//             onChanged: (List<String> x) {
//               setState(() {
//                 selectedResults = x;
//               });
//             },
//             options: ['Free Feeder', 'Leaf Rust', 'Leaf Skeletonizer'],
//             selected_values_style: GoogleFonts.openSans(
//               // fontSize: 15,
//               color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                       Colors.white
//                   ? const Color(0xFF2C2C2C)
//                   : Color.fromARGB(255, 194, 193, 193),
//             ),
//             selectedValues: selectedResults,
//             whenEmpty: 'Select Leaf Disease',
//             decoration: InputDecoration(
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide(
//                   color: Colors.black,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide(
//                   color: Colors.black,
//                 ),
//               ),
//               fillColor: Colors.white,
//               filled: true,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget severityLevelSelector() {
//     return Row(
//       children: [
//         Text(
//           "Severity Level",
//           style: GoogleFonts.openSans(
//               fontSize: 15,
//               color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                       Colors.white
//                   ? const Color(0xFF2C2C2C)
//                   : Color.fromARGB(255, 194, 193, 193),
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           child: Container(
//             padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               border: Border.all(
//                 color: Colors.black,
//               ),
//             ),
//             child: DropdownButton<int>(
//               // Initial Value
//               value: severityLevel,

//               underline: Container(),
//               padding: EdgeInsets.all(0),

//               // Down Arrow Icon
//               icon: const Icon(Icons.keyboard_arrow_down),

//               // Array list of items
//               items: severityOptions.map((int items) {
//                 return DropdownMenuItem(
//                   value: items,
//                   child: Text(items.toString()),
//                 );
//               }).toList(),
//               // After selecting the desired option,it will
//               // change button value to selected value
//               onChanged: (int? newValue) {
//                 setState(() {
//                   severityLevel = newValue!;
//                 });
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget managementOptions() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Management Suggestion",
//           style: GoogleFonts.openSans(
//               fontSize: 15,
//               color: BlocProvider.of<ThemeBloc>(context).state.whiteColor ==
//                       Colors.white
//                   ? const Color(0xFF2C2C2C)
//                   : Color.fromARGB(255, 194, 193, 193),
//               fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         CheckboxListTile(
//           title: Text("Using copper based synthetic fungicides"),
//           value: copperBasedSynthetic,
//           onChanged: (value) {
//             setState(() {
//               copperBasedSynthetic = !copperBasedSynthetic;
//             });
//           },
//           controlAffinity: ListTileControlAffinity.leading,
//         ),
//         CheckboxListTile(
//           title: Text("Using resistant varieties"),
//           value: resistantVarieties,
//           onChanged: (value) {
//             setState(() {
//               resistantVarieties = !resistantVarieties;
//             });
//           },
//           controlAffinity: ListTileControlAffinity.leading,
//         ),
//         Text(
//           "Additionally",
//           style: TextStyle(
//             fontSize: 18,
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         TextFormField(
//           minLines: 2,
//           maxLines: 5,
//           controller: textEditingController,
//           decoration: InputDecoration(
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: Colors.black,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide(
//                 color: Colors.black,
//               ),
//             ),
//             fillColor: Colors.white,
//             filled: true,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget saveManualDiagnosis(int dataId) {
//     return TextButton(
//       onPressed: () {
//         if (selectedResults.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'All form field must be filled!',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           );
//         } else {
//           manualDiagnosisBloc.add(
//             ManualDiagnosisSave(
//               dataId: dataId,
//               selectedResults: selectedResults,
//               severityLevel: severityLevel,
//               resistantVarieties: resistantVarieties,
//               copperBasedSynthetic: copperBasedSynthetic,
//               additionalSuggestion: textEditingController.text,
//             ),
//           );
//         }
//       },
//       child: Row(
//         children: [
//           Icon(
//             Icons.file_upload_outlined,
//             color: Colors.green,
//             size: 30,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             "Save",
//             style: TextStyle(
//               color: Colors.green,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget cancelManualDiagnosis() {
//     return TextButton(
//       onPressed: () {
//         severityLevel = 0;
//         finalDiagnosis = "Healthy";
//         selectedResults.clear();
//         textEditingController.clear();
//         manualDiagnosisBloc.add(ManualDiagnosisCancel());
//       },
//       child: Row(
//         children: [
//           Icon(
//             Icons.cancel_presentation_rounded,
//             color: Colors.redAccent,
//             size: 30,
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Text(
//             "Cancel",
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final File imagefile;

//   FullScreenImage({super.key, required this.imagefile});
//   final PhotoViewController photoViewController = PhotoViewController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: Center(
//           child: PhotoView(
//             controller: photoViewController,
//             // enablePanAlways: true,
//             backgroundDecoration: const BoxDecoration(color: kPrimaryColor),
//             enableRotation: true,
//             imageProvider: FileImage(imagefile),
//             minScale: PhotoViewComputedScale.contained * 0.8,
//             maxScale: PhotoViewComputedScale.covered * 10.0,
//             initialScale: PhotoViewComputedScale.contained,
//           ),
//         ),
//       ),
//     );
//   }
// }
