import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheatwise/features/home/components/camera_button.dart';
import 'package:wheatwise/features/home/screens/pick_image_screen.dart';
import 'package:wheatwise/features/records/diagnosis_details/screens/diagnosis_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _currentPage = 0;

  List<String> assetPaths = [
    'assets/images/wheat-banner.jpg',
    'assets/images/wheat-banner2.jpg',
    'assets/images/wheat-banner3.jpg',
    'assets/images/wheat-banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Pic
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello Naod',
                    style: TextStyle(
                      fontFamily: 'Clash Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    radius: 30,
                  ),
                ],
              ),

              // PageView.builder(
              //   itemCount: assetPaths.length,
              //   onPageChanged: (int page) {
              //     setState(() {
              //       _currentPage = page;
              //     });
              //   },
              //   itemBuilder: (context, index) {
              //     return Container(
              //       // color: Colors.red,
              //       padding: const EdgeInsets.all(16),
              //       height: 200,
              //       width: double.infinity,
              //     );
              //     // return Image.asset(
              //     //   assetPaths[index],
              //     //   fit: BoxFit.cover,
              //     // );
              //   },
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(assetPaths.length, (index) {
              //     return Container(
              //       width: 8.0,
              //       height: 8.0,
              //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: _currentPage == index ? Colors.blue : Colors.grey,
              //       ),
              //     );
              //   }),
              // ),
              // const CameraButton()
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Card(
              //     elevation: 5,
              //     child: Stack(
              //       children: [
              //         Positioned.fill(
              //           child: Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               gradient: const LinearGradient(
              //                 begin: Alignment.topLeft,
              //                 end: Alignment.bottomRight,
              //                 colors: [
              //                   Colors.transparent,
              //                   Colors.black,
              //                 ],
              //               ),
              //             ),
              //             child: Image.asset(
              //               assetPaths[2],
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           bottom: 10,
              //           right: 10,
              //           child: Image.asset(
              //             'assets/logo/wheatwise-logo-white.png',
              //             fit: BoxFit.cover,
              //             height: 50,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              // Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          assetPaths[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(12),
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //         gradient: LinearGradient(
                    //           begin: Alignment.topLeft,
                    //           end: Alignment.bottomRight,
                    //           colors: [
                    //             Colors.transparent,
                    //             Colors.black,
                    //           ],
                    //         ),
                    //       ),
                    //       child: Image.asset(
                    //         assetPaths[2],
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // wheatwise logo
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Image.asset(
                        'assets/logo/wheatwise-logo-white.png',
                        fit: BoxFit.cover,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12))),
                    context: context,
                    builder: (context) => detectNowPopup()),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(248, 147, 29, 1)),
                  minimumSize: MaterialStateProperty.all(
                    const Size(double.infinity, 52),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/scan-icon.svg',
                      color: Colors.white,
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "Detect Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget detectNowPopup() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Detect disease using',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DiagnosisDetailScreen()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(248, 147, 29, 1)),
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 52),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/scan-icon.svg',
                  color: Colors.white,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Choose from Gallery",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'or',
            style: TextStyle(
              fontFamily: 'Clash Display',
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DiagnosisDetailScreen()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(248, 147, 29, 1)),
              minimumSize: MaterialStateProperty.all(
                const Size(double.infinity, 52),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/scan-icon.svg',
                  color: Colors.white,
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 5),
                const Text(
                  "Capture from Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
