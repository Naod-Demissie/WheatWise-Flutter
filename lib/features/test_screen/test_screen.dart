// ignore_for_file: use_build_context_synchronously

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:wheatwise/features/setting/change_password/screen/change_password_screen.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_bloc.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_event.dart';
import 'package:wheatwise/features/auth/login/screens/login_screen.dart';
import 'package:wheatwise/features/resources/constants.dart';
import 'package:wheatwise/features/setting/edit_profile/screen/edit_profile_screen.dart';
import 'package:wheatwise/features/setting/screens/term_and_conditions_dialog.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_event.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late SharedPreferences prefs;

  String? profilePicPath;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profilePicPath');
    if (imagePath != null) {
      final File imageFile = File(imagePath);
      setState(() {
        profilePicPath = imageFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                // Background image
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/wheat-field-bg2.png',
                    fit: BoxFit.cover,
                  ),
                ),
                // White filter
                Container(
                  color: BlocProvider.of<ThemeBloc>(context)
                      .state
                      .backgroundColor
                      .withOpacity(0.5),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: settingMenus(context, themeState),
                ),
                Positioned(
                  top: 80, //! change this to be in media query height
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            profilePicPath != null ? null : Colors.purple,
                        backgroundImage: profilePicPath != null
                            ? FileImage(File(profilePicPath!))
                            : null,
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

  Widget settingMenus(BuildContext context, ThemeState themeState) {
    return Center(
      child: Container(
        height: 700,
        margin: const EdgeInsets.only(top: 160),
        decoration: BoxDecoration(
            color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Account Setting',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                        color:
                            BlocProvider.of<ThemeBloc>(context).state.textColor,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(
                  context, "Edit Profile", 'assets/icons/profile-icon3.svg',
                  () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
              }),
              settingMenu(
                  context, "Change Password", 'assets/icons/password-icon.svg',
                  () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()));
              }),
              settingMenu(
                  context,
                  "Sync Data",
                  // 'assets/icons/sync-data-icon.svg', () {}),
                  'assets/icons/sync-data-icon3.svg',
                  () {}),
              settingMenu(context, "Logout", 'assets/icons/logout-icon.svg',
                  () {
                BlocProvider.of<LogoutBloc>(context).add(LogoutButtonPressed());
                // !signOut(context); implement this method
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              }),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Preferences',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                        color:
                            BlocProvider.of<ThemeBloc>(context).state.textColor,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(
                  context, "Dark Mode", 'assets/icons/dark-mode-icon2.svg', () {
                BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent());
              },
                  trailing: Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      value: themeState is DarkThemeState,
                      // activeColor: Colors.black,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        BlocProvider.of<ThemeBloc>(context)
                            .add(ChangeThemeEvent());
                      },
                    ),
                  )),
              settingMenu(
                context,
                "Language",
                'assets/icons/language-icon3.svg',
                () {},
                trailing: DropdownButton<String>(
                  dropdownColor:
                      BlocProvider.of<ThemeBloc>(context).state.cardColor,
                  elevation: themeState is DarkThemeState ? 0 : 3,
                  value: 'English',
                  onChanged: (String? value) {},
                  items: ['አማርኛ', 'English']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: TextStyle(
                            color: BlocProvider.of<ThemeBloc>(context)
                                .state
                                .textColor,
                            fontFamily: 'SF-Pro-Text',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w300,
                          )),
                    );
                  }).toList(),
                  underline: Container(
                    height: 0,
                    color: Colors.transparent,
                  ),
                ),
              ),
              settingMenu(context, "Notification",
                  'assets/icons/notification-icon3.svg', () {}),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('General',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                        color:
                            BlocProvider.of<ThemeBloc>(context).state.textColor,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(
                context,
                "Terms And Conditions",
                'assets/icons/terms-and-conditions-icon3.svg',
                () {
                  showTermsAndConditionsDialog(context);
                },
              ),
              settingMenu(
                context,
                "Share the app",
                'assets/icons/share-icon3.svg',
                () async {
                  // ShareResult result = await Share.shareWithResult(
                  //   'Check out this awesome app! Download it now: https://your-app-url.com',
                  // );
                  // if (result.raw.isNotEmpty) {
                  //   showThankYouDialog(context);
                  // }
                },
              ),
              settingMenu(
                context,
                "Rate App",
                'assets/icons/rate-icon3.svg',
                () {
                  // _openAppStore();
                },
              ),
              settingMenu(context, "About Us", 'assets/icons/info-icon3.svg',
                  () {
                // Navigator.of(context).push(MaterialPageRoute(
                // builder: (context) => About(),
                // ));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingMenu(
    BuildContext context,
    String title,
    String iconPath,
    Function()? onTap, {
    Widget? trailing,
  }) {
    return Container(
      height: 43,
      // color: Colors.red,
      color: BlocProvider.of<ThemeBloc>(context).state.backgroundColor,

      child: ListTile(
        onTap: onTap,
        // leading: Icon(icon, color: Colors.grey),
        leading: SvgPicture.asset(
          iconPath,
          color: kPrimaryColor,
          width: 22,
          height: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Clash Display',
            fontWeight: FontWeight.w400,
            color: BlocProvider.of<ThemeBloc>(context).state.textColor,
          ),
        ),

        trailing: trailing,
      ),
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:wheatwise/features/resources/constants.dart';

// class TestScreen extends StatefulWidget {
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Progress Dialog Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) => Center(
//                 child: Container(
//                   width: 120.0,
//                   height: 120.0,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(4.0),
//                   ),
//                   child: const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: CupertinoActivityIndicator(
//                           color: kPrimaryColor,
//                           radius: 16,
//                         ),
//                       ),
//                       // SizedBox(height: 5),
//                       Text('Loading...'),
//                     ],
//                   ),
//                 ),
//               ),
//             );

//             // Simulate a time-consuming operation
//             Future.delayed(const Duration(seconds: 6), () {
//               Navigator.of(context).pop(); // Close the dialog
//             });
//           },
//           child: const Text('Show Progress Dialog'),
//         ),
//       ),
//     );
//   }
// }
