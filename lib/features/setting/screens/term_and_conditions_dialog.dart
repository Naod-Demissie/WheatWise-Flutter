import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

void showTermsAndConditionsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return AlertDialog(
            surfaceTintColor: Colors.grey.shade700,
            backgroundColor:
                BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
            contentPadding: const EdgeInsets.all(16),
            titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: themeState is DarkThemeState
                ? Image.asset(
                    'assets/logo/wheatwise-logo-white.png',
                    height: 40,
                  )
                : Image.asset(
                    'assets/logo/wheatwise-logo-black.png',
                    height: 40,
                  ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''These Terms and Conditions are an agreement between Ethiopian Artificial Intelligence Institute and you. This Agreement sets forth the general terms and conditions of your use of the Wheat Disease Diagnosis mobile application and any of its products or services (collectively, "Mobile Application" or "Services").''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''\nSubscription''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''Some parts of the Service are billed on a subscription basis. You will be billed in advance on a recurring and periodic basis. Billing cycles are set either on a monthly or annual basis, depending on the type of subscription plan you select when purchasing a Subscription.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''At the end of each Billing Cycle, your Subscription will automatically renew under the exact same conditions unless you cancel it or Ethiopian Artificial Intelligence Institute cancels it. You may cancel your Subscription renewal either through your online account management page or by contacting Ethiopian Artificial Intelligence Institute customer support team.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '\nIntellectual Property',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''The Mobile Application and its original content (excluding Content provided by users), features, and functionality are and will remain the exclusive property of Ethiopian Artificial Intelligence Institute and its licensors. The Mobile Application is protected by copyright, trademark, and other laws of both the Ethiopia and foreign countries. Our trademarks and trade dress may not be used in connection with any product or service without the prior written consent of Ethiopian Artificial Intelligence Institute.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '\nContent',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''Our Mobile Application allows you to post, link, store, share, and otherwise make available certain information, text, graphics, videos, or other material ("Content"). You are responsible for the Content that you post on or through the Mobile Application, including its legality, reliability, and appropriateness.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''By posting Content on or through the Mobile Application, You represent and warrant that: (i) the Content is yours (you own it) and/or you have the right to use it and the right to grant us the rights and license as provided in these Terms, and (ii) that the posting of your Content on or through the Mobile Application does not violate the privacy rights, publicity rights, copyrights, contract rights, or any other rights of any person or entity. We reserve the right to terminate the account of anyone found to be infringing on a copyright.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '\nChanges to This Agreement',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''We reserve the right, at our sole discretion, to modify or replace these Terms of Service by posting the updated terms on the Mobile Application. Your continued use of the Mobile Application after any such changes constitute your acceptance of the new Terms of Service. Please review this Agreement periodically for changes. If you do not agree to any of this Agreement or any changes to this Agreement, do not use, access, or continue to access the Mobile Application or discontinue any use of the Mobile Application immediately.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '\nContact Us',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '''If you have any questions about this Agreement, please contact us at Ethiopian Artificial Intelligence Institute.''',
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 3),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.black,
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'SF-Pro-Text',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
