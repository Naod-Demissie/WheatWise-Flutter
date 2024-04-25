// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:path_provider/path_provider.dart';

import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

Map<String, Map<String, String>> diseases = {
  'Yellow Rust': {
    'title': "Understanding Yellow Rust: A Devastating Wheat Disease",
    'Introduction':
        "Wheat production is a critical component of global food security, providing a staple food for billions of people. However, wheat crops face numerous challenges, one of the most significant being yellow rust, also known as stripe rust. This fungal disease can cause severe yield losses if not managed effectively. Understanding the causes, symptoms, and management strategies for yellow rust is crucial for farmers and agricultural professionals.",
    'Causes of Yellow Rust':
        'Yellow rust is caused by the fungus Puccinia striiformis, which infects wheat plants through airborne spores. These spores can travel long distances, making the disease difficult to control, especially in areas with favorable environmental conditions. Cool and moist weather, typically between 10°C to 20°C, promotes the development and spread of yellow rust.',
    'Symptoms of Yellow Rust':
        'The symptoms of yellow rust vary depending on the stage of infection. Initially, small, yellowish flecks appear on the leaves, often resembling dust. As the disease progresses, these flecks enlarge and merge, forming yellow stripes or bands along the length of the leaf. In severe cases, the entire leaf can turn yellow or brown, and the plant may exhibit stunted growth.',
    'Impact on Wheat Crops':
        'Yellow rust can have a significant impact on wheat crops, leading to yield losses of up to 50% or more in severe cases. The disease affects photosynthesis, reducing the plant\'s ability to produce energy and nutrients. Weakened plants are more susceptible to other stresses, such as drought or nutrient deficiencies, further exacerbating yield losses.',
    'Management Strategies':
        'Managing yellow rust requires an integrated approach that combines cultural, chemical, and genetic methods. Crop rotation can help break the disease cycle, as the fungus cannot survive without a host plant. Planting resistant wheat varieties is another effective strategy, as these varieties have genes that provide immunity or high levels of resistance to yellow rust. \n\n Chemical control methods, such as fungicide application, can be used to manage yellow rust outbreaks. However, fungicides should be applied preventively, before the disease becomes widespread. Proper timing and application techniques are essential for effective control.',
    'Conclusion':
        'Yellow rust remains a significant threat to wheat production worldwide. Farmers and agricultural professionals must be vigilant in monitoring for the disease and implementing effective management strategies. By understanding the causes, symptoms, and management options for yellow rust, we can work towards minimizing its impact and ensuring the continued productivity of wheat crops.'
  },
  'Brown Rust': {
    'title': "Brown Rust in Wheat: Identification and Control",
    'Introduction':
        "Brown rust, caused by the fungus Puccinia recondita, is a common and destructive disease affecting wheat crops worldwide. Understanding the characteristics, symptoms, and management strategies for brown rust is essential for farmers and agricultural professionals to protect their wheat yields.",
    'Causes of Brown Rust':
        'Brown rust is favored by moderate temperatures ranging from 15°C to 22°C and high humidity. The fungus spreads through airborne spores, which can travel long distances, especially in windy conditions. Brown rust can overwinter on alternate host plants or as spores on wheat stubble, contributing to its persistence and ability to re-infect crops.',
    'Symptoms of Brown Rust':
        'The symptoms of brown rust first appear as small, circular to elongated, reddish-brown pustules on the leaves, stems, and sometimes even the heads of wheat plants. As the disease progresses, these pustules enlarge and coalesce, forming larger, dark brown lesions. Infected leaves may become chlorotic (yellowing) and eventually senesce, leading to reduced photosynthetic capacity and yield loss.',
    'Impact on Wheat Crops':
        'Brown rust can have a significant impact on wheat crops, especially in regions with favorable environmental conditions. Yield losses of up to 30% or more have been reported in severe outbreaks. In addition to direct yield losses, brown rust can also reduce grain quality, affecting marketability and economic returns for farmers.',
    'Management Strategies':
        'Effective management of brown rust requires an integrated approach that includes cultural, chemical, and genetic strategies. Crop rotation can help reduce the buildup of inoculum in the soil, while planting resistant wheat varieties is the most sustainable and cost-effective strategy for long-term control. \n\n Chemical control methods, such as fungicide application, can be used to manage brown rust outbreaks. Fungicides should be applied preventively, before the disease becomes widespread, and according to label instructions to minimize the risk of resistance development.',
    'Medications for Brown Rust':
        'Several fungicides are effective against brown rust, including triazoles, strobilurins, and benzimidazoles. Common active ingredients include tebuconazole, epoxiconazole, and propiconazole. These fungicides can be applied as foliar sprays, either alone or in combination with other active ingredients, to control brown rust and protect wheat yields.',
    'Conclusion':
        'Brown rust remains a significant threat to wheat production worldwide. Farmers and agricultural professionals must be vigilant in monitoring for the disease and implementing effective management strategies. By understanding the causes, symptoms, and management options for brown rust, we can work towards minimizing its impact and ensuring the continued productivity of wheat crops.'
  },
  'Mildew': {
    'title': "Wheat Mildew: Recognizing and Preventing Outbreaks",
    'Introduction':
        "Wheat mildew, caused by the fungus Blumeria graminis, is a common disease that can affect wheat crops at various growth stages. Recognizing the symptoms, understanding the factors that contribute to its development, and implementing effective management strategies are crucial for minimizing its impact on crop yield and quality.",
    'Causes of Wheat Mildew':
        'Wheat mildew thrives in cool, humid conditions, with optimal growth occurring between 15°C to 20°C. The fungus spreads through airborne spores, which can travel long distances. Overcrowded planting, dense canopy, and high nitrogen levels can create conditions favorable for mildew development by reducing air circulation and increasing humidity within the crop canopy.',
    'Symptoms of Wheat Mildew':
        'The first signs of wheat mildew typically appear as white to grayish powdery patches on the leaves, stems, and heads of infected plants. As the disease progresses, these patches enlarge and may cover the entire surface of the plant. Infected leaves may become chlorotic (yellowing) and eventually die, leading to reduced photosynthetic capacity and yield loss.',
    'Impact on Wheat Crops':
        'Wheat mildew can have a significant impact on crop yield and quality. Severe infections can lead to yield losses of up to 40% or more, depending on the timing and severity of the outbreak. In addition to direct yield losses, mildew can also reduce grain quality, affecting marketability and economic returns for farmers.',
    'Management Strategies':
        'Effective management of wheat mildew requires an integrated approach that includes cultural, chemical, and genetic strategies. Crop rotation can help reduce the buildup of inoculum in the soil, while planting resistant wheat varieties is the most sustainable and cost-effective strategy for long-term control. \n\n Chemical control methods, such as fungicide application, can be used to manage mildew outbreaks. Fungicides should be applied preventively, before the disease becomes widespread, and according to label instructions to minimize the risk of resistance development.',
    'Medications for Wheat Mildew':
        'Several fungicides are effective against wheat mildew, including triazoles, strobilurins, and quinone outside inhibitors (QoIs). Common active ingredients include azoxystrobin, propiconazole, and tebuconazole. These fungicides can be applied as foliar sprays, either alone or in combination with other active ingredients, to control mildew and protect wheat yields.',
    'Conclusion':
        'Wheat mildew is a common disease that can have a significant impact on crop yield and quality. Farmers and agricultural professionals must be vigilant in monitoring for the disease and implementing effective management strategies. By understanding the causes, symptoms, and management options for wheat mildew, we can work towards minimizing its impact and ensuring the continued productivity of wheat crops.'
  },
  'Septoria': {
    'title': "Septoria Leaf Blotch: A Persistent Threat to Wheat",
    'Introduction':
        "Septoria leaf blotch, caused by the fungus Septoria tritici, is a common and destructive disease that affects wheat crops worldwide. Recognizing the symptoms, understanding the factors that contribute to its development, and implementing effective management strategies are crucial for minimizing its impact on crop yield and quality.",
    'Causes of Septoria Leaf Blotch':
        'Septoria leaf blotch thrives in warm, humid conditions, with optimal growth occurring between 15°C to 25°C. The fungus survives in crop residue and soil, making it difficult to eradicate completely. Overhead irrigation, dense crop canopy, and high humidity levels can create conditions favorable for disease development by promoting spore production and spread.',
    'Symptoms of Septoria Leaf Blotch':
        'The first symptoms of septoria leaf blotch typically appear as small, dark brown to black lesions with yellow halos on the lower leaves of the wheat plant. As the disease progresses, these lesions enlarge and coalesce, covering larger areas of the leaf surface. Infected leaves may become chlorotic (yellowing) and eventually senesce, leading to reduced photosynthetic capacity and yield loss.',
    'Impact on Wheat Crops':
        'Septoria leaf blotch can have a significant impact on wheat crops, especially in regions with favorable environmental conditions. Yield losses of up to 50% or more have been reported in severe outbreaks. In addition to direct yield losses, septoria leaf blotch can also reduce grain quality, affecting marketability and economic returns for farmers.',
    'Management Strategies':
        'Effective management of septoria leaf blotch requires an integrated approach that includes cultural, chemical, and genetic strategies. Crop rotation can help reduce the buildup of inoculum in the soil, while planting resistant wheat varieties is the most sustainable and cost-effective strategy for long-term control. \n\n Chemical control methods, such as fungicide application, can be used to manage septoria leaf blotch outbreaks. Fungicides should be applied preventively, before the disease becomes widespread, and according to label instructions to minimize the risk of resistance development.',
    'Medications for Septoria Leaf Blotch':
        'Several fungicides are effective against septoria leaf blotch, including triazoles, strobilurins, and benzimidazoles. Common active ingredients include azoxystrobin, propiconazole, and tebuconazole. These fungicides can be applied as foliar sprays, either alone or in combination with other active ingredients, to control septoria leaf blotch and protect wheat yields.',
    'Conclusion':
        'Septoria leaf blotch is a persistent threat to wheat production worldwide. Farmers and agricultural professionals must be vigilant in monitoring for the disease and implementing effective management strategies. By understanding the causes, symptoms, and management options for septoria leaf blotch, we can work towards minimizing its impact and ensuring the continued productivity of wheat crops.'
  },
  'Stem Rust': {
    'title': "Stem Rust: The Menace of Wheat Fields",
    'Introduction':
        "Stem rust, caused by the fungus Puccinia graminis, is a devastating disease that has plagued wheat crops for centuries. Recognizing the symptoms, understanding the factors that contribute to its development, and implementing effective management strategies are crucial for minimizing its impact on crop yield and food security.",
    'Causes of Stem Rust':
        'Stem rust thrives in warm, humid conditions, with optimal growth occurring between 20°C to 25°C. The fungus spreads through airborne spores, which can travel long distances. Overcrowded planting, dense crop canopy, and high humidity levels can create conditions favorable for disease development by promoting spore production and spread.',
    'Symptoms of Stem Rust':
        'The first symptoms of stem rust typically appear as small, reddish-brown pustules on the stems, leaves, and heads of infected wheat plants. These pustules contain masses of spores, giving them a powdery appearance. As the disease progresses, the pustules enlarge and coalesce, causing the affected tissue to wither and die. Severe infections can lead to lodging, where the stems of the plants become weak and bend or break, further reducing yield.',
    'Impact on Wheat Crops':
        'Stem rust can have a devastating impact on wheat crops, especially in regions with favorable environmental conditions. Yield losses of up to 100% have been reported in severe outbreaks. In addition to direct yield losses, stem rust can also reduce grain quality, affecting marketability and economic returns for farmers.',
    'Management Strategies':
        'Effective management of stem rust requires an integrated approach that includes cultural, chemical, and genetic strategies. Crop rotation can help reduce the buildup of inoculum in the soil, while planting resistant wheat varieties is the most sustainable and cost-effective strategy for long-term control. \n\n Chemical control methods, such as fungicide application, can be used to manage stem rust outbreaks. Fungicides should be applied preventively, before the disease becomes widespread, and according to label instructions to minimize the risk of resistance development.',
    'Medications for Stem Rust':
        'Several fungicides are effective against stem rust, including triazoles, strobilurins, and benzimidazoles. Common active ingredients include azoxystrobin, propiconazole, and tebuconazole. These fungicides can be applied as foliar sprays, either alone or in combination with other active ingredients, to control stem rust and protect wheat yields.',
    'Conclusion':
        'Stem rust remains a significant threat to wheat production worldwide. Farmers and agricultural professionals must be vigilant in monitoring for the disease and implementing effective management strategies. By understanding the causes, symptoms, and management options for stem rust, we can work towards minimizing its impact and ensuring the continued productivity of wheat crops.'
  },
};
Map<String, List<String>> imagePaths = {
  'Yellow Rust': [
    'assets/images/article_images/yellow-rust4.jpg',
    'assets/images/article_images/yellow-rust1.jpg',
    'assets/images/article_images/yellow-rust2.jpg',
  ],
  'Brown Rust': [
    'assets/images/article_images/brown-rust2.jpg',
    'assets/images/article_images/brown-rust1.jpg',
    'assets/images/article_images/brown-rust3.jpg',
  ],
  'Mildew': [
    'assets/images/article_images/mildew1.jpeg',
    'assets/images/article_images/mildew2.jpg',
    'assets/images/article_images/mildew3.png',
  ],
  'Septoria': [
    'assets/images/article_images/septoria1.jpg',
    'assets/images/article_images/septoria2.jpg',
    'assets/images/article_images/septoria4.png',
  ],
  'Stem Rust': [
    'assets/images/article_images/stem-rust.jpeg',
    'assets/images/article_images/stem-rust2.jpg',
  ],
};

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String selectedFilterCategory = 'All';
  bool showFilterCategories = false;

  List<ArticleCard> articles = [
    ArticleCard(
      diseaseName: 'Yellow Rust',
      assetPath: imagePaths['Yellow Rust']![0],
      articleTitle: "Understanding Yellow Rust: A Devastating Wheat Disease",
      articleSubtitle: "Causes, Symptoms, and Management Strategies",
    ),
    ArticleCard(
      diseaseName: 'Brown Rust',
      assetPath: imagePaths['Brown Rust']![0],
      articleTitle: "Brown Rust in Wheat: Identification and Control",
      articleSubtitle:
          "Combatting a Common Fungal Disease Threatening Wheat Crops",
    ),
    ArticleCard(
      diseaseName: 'Septoria',
      assetPath: imagePaths['Septoria']![0],
      articleTitle: "Septoria Leaf Blotch: A Persistent Threat to Wheat",
      articleSubtitle: "Symptoms, Prevention, and Treatment Options",
    ),
    ArticleCard(
      diseaseName: 'Mildew',
      assetPath: imagePaths['Mildew']![0],
      articleTitle: "Wheat Mildew: Recognizing and Preventing Outbreaks",
      articleSubtitle:
          "A Comprehensive Guide to Dealing with Powdery Mildew in Wheat",
    ),
    ArticleCard(
      diseaseName: 'Stem Rust',
      assetPath: imagePaths['Stem Rust']![0],
      articleTitle: "Stem Rust: The Menace of Wheat Fields",
      articleSubtitle: "Exploring the Impact and Management of Wheat Stem Rust",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: themeState is DarkThemeState
            ? BlocProvider.of<ThemeBloc>(context).state.backgroundColor
            : const Color.fromARGB(255, 243, 243, 243),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Articles',
            style: TextStyle(
                fontFamily: 'Clash Display',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: BlocProvider.of<ThemeBloc>(context).state.textColor),
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 10),
          child: Center(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return articles[index];
              },
            ),
          ),
        ),
      ));
    });
  }
}

class ArticleCard extends StatefulWidget {
  final String diseaseName;
  final String assetPath;
  final String articleTitle;
  final String articleSubtitle;

  const ArticleCard({
    super.key,
    required this.diseaseName,
    required this.assetPath,
    required this.articleTitle,
    required this.articleSubtitle,
  });

  @override
  _ArticleCardState createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  late Future<XFile> _compressedImageFuture;

  @override
  void initState() {
    super.initState();
    _compressedImageFuture = compressImage();
  }

  Future<XFile> compressImage() async {
    ByteData imageData = await rootBundle.load(widget.assetPath);
    List<int> bytes = Uint8List.view(imageData.buffer).toList();

    final tempDir = await getTemporaryDirectory();
    final targetPath =
        '${tempDir.absolute.path}/optimized_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    await File(targetPath).writeAsBytes(bytes);

    var result = await FlutterImageCompress.compressAndGetFile(
      targetPath,
      targetPath,
      quality: 50,
      minWidth: 100,
      minHeight: 100,
    );
    return XFile(result!.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<XFile>(
      future: _compressedImageFuture,
      builder: (context, snapshot) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return SizedBox(
              height: 115,
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: BlocProvider.of<ThemeBloc>(context).state.cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: themeState is DarkThemeState
                      ? Border.all(
                          width: 0.7,
                          color: Colors.grey.shade800,
                        )
                      : Border.all(
                          width: 0.7,
                          color: Colors.grey.shade400,
                        ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: ((context) => ArticleDetailScreen(
                            diseaseName: widget.diseaseName)),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      // card image
                      Expanded(
                        flex: 2,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.zero,
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.zero,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(widget.assetPath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.articleTitle,
                                style: TextStyle(
                                  fontFamily: 'Clash Display',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .textColor,
                                ),
                              ),
                              Text(
                                widget.articleSubtitle,
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: BlocProvider.of<ThemeBloc>(context)
                                      .state
                                      .textColor
                                      .withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ArticleDetailScreen extends StatefulWidget {
  final String diseaseName;

  const ArticleDetailScreen({
    super.key,
    required this.diseaseName,
  });

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final _controller = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    List<Widget> widgets = [];
    Map<String, String> diseaseMap = diseases[widget.diseaseName]!;
    diseaseMap.forEach((key, value) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            key == 'title' || key == 'Introduction'
                ? const SizedBox.shrink()
                : Text(
                    key,
                    style: TextStyle(
                        fontFamily: 'Clash Display',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .textColor),
                  ),
            const SizedBox(height: 4.0),
            key == 'title'
                ? Text(
                    value,
                    style: TextStyle(
                        fontFamily: 'Clash Display',
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .textColor),
                  )
                : Text(
                    value,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontFamily: 'Clash Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: BlocProvider.of<ThemeBloc>(context)
                            .state
                            .textColor),
                  )
          ],
        ),
      ));
    });
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Card(
              elevation: 0,
              shape: const CircleBorder(),
              color: Colors.black.withOpacity(0.6),
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: screenHeight * 0.35,
                width: double.infinity,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: imagePaths[widget.diseaseName]!.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imagePaths[widget.diseaseName]![index],
                      fit: BoxFit.cover,
                    );
                  },
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPageNotifier.value = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.35 - 24.0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CirclePageIndicator(
                  itemCount: imagePaths[widget.diseaseName]!.length,
                  currentPageNotifier: _currentPageNotifier,
                  dotColor: Colors.grey.shade500,
                  selectedDotColor: Colors.white,
                  size: 6.0,
                  selectedSize: 8.0,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.35,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// // stack image scrollable paragraph
// class ArticleDetailScreen extends StatefulWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     Key? key,
//     required this.diseaseName,
//   }) : super(key: key);

//   @override
//   _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   final _controller = PageController();
//   final _currentPageNotifier = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[widget.diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: SizedBox(
//                 height: screenHeight * 0.35,
//                 width: double.infinity,
//                 child: PageView.builder(
//                   controller: _controller,
//                   itemCount: imagePaths[widget.diseaseName]!.length,
//                   itemBuilder: (context, index) {
//                     return Image.asset(
//                       imagePaths[widget.diseaseName]![index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                   onPageChanged: (int index) {
//                     setState(() {
//                       _currentPageNotifier.value = index;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             Positioned(
//               top: screenHeight * 0.35,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class ArticleDetailScreen extends StatefulWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     Key? key,
//     required this.diseaseName,
//   }) : super(key: key);

//   @override
//   _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   final _controller = PageController();
//   final _currentPageNotifier = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[widget.diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Positioned(
//               child: SizedBox(
//                 height: screenHeight * 0.35,
//                 width: double.infinity,
//                 child: PageView.builder(
//                   controller: _controller,
//                   itemCount: imagePaths[widget.diseaseName]!.length,
//                   itemBuilder: (context, index) {
//                     return Image.asset(
//                       imagePaths[widget.diseaseName]![index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                   onPageChanged: (int index) {
//                     setState(() {
//                       _currentPageNotifier.value = index;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               padding: EdgeInsets.only(top: screenHeight * 0.35),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class ArticleDetailScreen extends StatefulWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     super.key,
//     required this.diseaseName,
//   });

//   @override
//   _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   final _controller = PageController();
//   final _currentPageNotifier = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[widget.diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.35,
//                     width: double.infinity,
//                     child: PageView.builder(
//                       controller: _controller,
//                       itemCount: imagePaths[widget.diseaseName]!.length,
//                       itemBuilder: (context, index) {
//                         return Image.asset(
//                           imagePaths[widget.diseaseName]![index],
//                           fit: BoxFit.cover,
//                         );
//                       },
//                       onPageChanged: (int index) {
//                         setState(() {
//                           _currentPageNotifier.value = index;
//                         });
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CirclePageIndicator(
//                       itemCount: imagePaths[widget.diseaseName]!.length,
//                       currentPageNotifier: _currentPageNotifier,
//                       dotColor: Colors.grey.shade500,
//                       selectedDotColor: Colors.white,
//                       size: 6.0,
//                       selectedSize: 8.0,
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // working code with moving images
// class ArticleDetailScreen extends StatefulWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     super.key,
//     required this.diseaseName,
//   });

//   @override
//   _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   final _controller = PageController();
//   final _currentPageNotifier = ValueNotifier<int>(0);

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[widget.diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.35,
//                 width: double.infinity,
//                 child: PageView.builder(
//                   controller: _controller,
//                   itemCount: imagePaths[widget.diseaseName]!.length,
//                   itemBuilder: (context, index) {
//                     return Image.asset(
//                       imagePaths[widget.diseaseName]![index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                   onPageChanged: (int index) {
//                     setState(() {
//                       _currentPageNotifier.value = index;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CirclePageIndicator(
//                   itemCount: imagePaths[widget.diseaseName]!.length,
//                   currentPageNotifier: _currentPageNotifier,
//                   dotColor: Colors.grey.shade300,
//                   selectedDotColor: Colors.grey,
//                   size: 6.0,
//                   selectedSize: 9.0,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// class ArticleDetailScreen extends StatelessWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     super.key,
//     required this.diseaseName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.35,
//                 width: double.infinity,
//                 child: PageView.builder(
//                   itemCount: imagePaths[diseaseName]!.length,
//                   itemBuilder: (context, index) {
//                     return Image.asset(
//                       imagePaths[diseaseName]![index],
//                       fit: BoxFit.cover,
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ArticleDetailScreen extends StatelessWidget {
//   final String diseaseName;

//   const ArticleDetailScreen({
//     super.key,
//     required this.diseaseName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     List<Widget> widgets = [];
//     Map<String, String> diseaseMap = diseases[diseaseName]!;
//     diseaseMap.forEach((key, value) {
//       widgets.add(Padding(
//         padding: const EdgeInsets.symmetric(vertical: 4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             key == 'title' || key == 'Introduction'
//                 ? const SizedBox.shrink()
//                 : Text(
//                     key,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),
//             const SizedBox(height: 4.0),
//             key == 'title'
//                 ? Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 21,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//                 : Text(
//                     value,
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 15,
//                         fontWeight: FontWeight.w400,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   )
//           ],
//         ),
//       ));
//     });
//     return SafeArea(
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 2.0),
//             child: Card(
//               elevation: 0,
//               shape: const CircleBorder(),
//               color: Colors.black.withOpacity(0.6),
//               margin: const EdgeInsets.all(10),
//               child: InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: screenHeight * 0.35,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                       imagePaths[diseaseName]![0],
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: widgets,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ArticleDetailScreen extends StatefulWidget {
//   const ArticleDetailScreen({super.key});

//   @override
//   State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
// }

// class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
//   late final DiagnosisDetailBloc diagnosisDetailBloc;
//   final List<String> diseaseList = [
//     'Brown Rust',
//     'Yellow Rust',
//     'Septoria',
//     'Mildew',
//     'Healthy',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     diagnosisDetailBloc = BlocProvider.of<DiagnosisDetailBloc>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     // double screenWidth = MediaQuery.of(context).size.width;
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         return SafeArea(
//           child: Scaffold(
//             extendBodyBehindAppBar: true,
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               leading: Padding(
//                 padding: const EdgeInsets.only(left: 2.0),
//                 child: Card(
//                   elevation: 0,
//                   shape: const CircleBorder(),
//                   color: Colors.black.withOpacity(0.6),
//                   margin: const EdgeInsets.all(10),
//                   child: InkWell(
//                     onTap: () => Navigator.of(context).pop(),
//                     child: Icon(
//                       Icons.close,
//                       size: 20,
//                       color: Colors.grey.shade200,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // wheat image
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => FullScreenImage(
//                             assetPaths: imagePaths['Yellow Rust']!,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       height: screenHeight * 0.35,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(
//                               'assets/images/article_images/yellow-rust4.jpg'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Disease Title
//                   Text(
//                     'Understanding Yellow Rust: A Devastating Wheat Disease',
//                     style: TextStyle(
//                         fontFamily: 'Clash Display',
//                         fontSize: 22,
//                         fontWeight: FontWeight.w600,
//                         color: BlocProvider.of<ThemeBloc>(context)
//                             .state
//                             .textColor),
//                   ),

//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Description',
//                           style: TextStyle(
//                               fontFamily: 'Clash Display',
//                               fontSize: 22,
//                               fontWeight: FontWeight.w600,
//                               color: BlocProvider.of<ThemeBloc>(context)
//                                   .state
//                                   .textColor),
//                         ),
//                         const SizedBox(height: 5),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final File imageFile;

//   FullScreenImage({super.key, required this.imageFile});
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
//             backgroundDecoration: const BoxDecoration(color: Colors.black),
//             imageProvider: FileImage(imageFile),
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 5.0,
//             initialScale: PhotoViewComputedScale.contained,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FullScreenImage extends StatelessWidget {
//   final List<String> assetPaths;
//   final int initialIndex;

//   FullScreenImage({Key? key, required this.assetPaths, this.initialIndex = 0})
//       : super(key: key);

//   final PageController _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: PageView.builder(
//           controller: _pageController,
//           itemCount: assetPaths.length,
//           itemBuilder: (context, index) {
//             return Center(
//               child: PhotoView(
//                 controller: PhotoViewController(),
//                 backgroundDecoration: const BoxDecoration(color: Colors.black),
//                 imageProvider: AssetImage(assetPaths[index]),
//                 minScale: PhotoViewComputedScale.contained,
//                 maxScale: PhotoViewComputedScale.covered * 5.0,
//                 initialScale: PhotoViewComputedScale.contained,
//               ),
//             );
//           },
//           onPageChanged: (index) {
//             // Handle page change if needed
//           },
//           physics: const BouncingScrollPhysics(),
//           pageSnapping: true,
//           scrollDirection: Axis.horizontal,
//           reverse: false,
//           controller: _pageController,
//         ),
//       ),
//     );
//   }
// }
