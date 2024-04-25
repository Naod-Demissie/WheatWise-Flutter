import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

String aboutUsText = '''
The Ethiopian Artificial Intelligence Institute (EAII) is a pioneering institution dedicated to advancing Ethiopia's interests through the strategic application of artificial intelligence (AI) services, products, and solutions. Founded with a vision to become the premier AI research and development center in Africa by 2030, the EAII aims to lead in creating innovative AI-enabled solutions that benefit the nation. With a mission to foster a nationally recognized AI ecosystem and skilled workforce, the EAII seeks to digitally empower and transform Ethiopia for peace and prosperity. The institute's core values, including loyalty, integrity, humanity, diversity, transparency, and accountability, guide its operations and interactions.

Empowered with various responsibilities, the EAII is tasked with providing research-based AI products and services essential for the country's development. It designs and implements AI research plans and strategies aligned with the country's development direction, establishing national infrastructure for AI research and development. Additionally, the institute formulates national AI policies, laws, and regulatory frameworks, and facilitates the development of AI skills and innovation capacity nationally. Through its work, the EAII aims to support national security decision-making processes, contribute to economic and social programs, and enhance decision-making processes in areas such as urban administration, disaster prevention, and environmental challenges.

The EAII extends its impact across key sectors such as agriculture, health, finance, and natural language processing (NLP) by producing AI-based products and applications. In agriculture, the institute's AI solutions enhance crop monitoring, disease detection, and yield prediction, contributing to improved agricultural practices and food security. In the health sector, AI applications enable better diagnosis, patient monitoring, and treatment planning, leading to improved healthcare delivery and outcomes. The EAII also plays a pivotal role in the financial sector by developing AI tools for fraud detection, risk assessment, and customer service, promoting financial inclusion and stability. Furthermore, in the realm of NLP, the institute's AI technologies facilitate language translation, language transcription, and optical character recognition, empowering individuals and organizations with efficient communication and information access capabilities.

''';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreen();
}

class _AboutScreen extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
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
                // Background image
                Image.asset(
                  'assets/images/wheat-field-bg2.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),

                // White filter
                Container(
                  color: BlocProvider.of<ThemeBloc>(context)
                      .state
                      .backgroundColor
                      .withOpacity(0.8),
                  width: double.infinity,
                  height: double.infinity,
                ),

                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Image.asset(
                        'assets/logo/aii.png',
                        height: 120,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // title text
                            Text(
                              'About Us',
                              style: TextStyle(
                                fontFamily: 'Clash Display',
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .textColor,
                              ),
                            ),

                            Text(
                              aboutUsText,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Clash Display',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
