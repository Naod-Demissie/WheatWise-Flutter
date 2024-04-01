// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:wheatwise/features/setting/change_password/screen/change_password_screen.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_bloc.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_event.dart';
import 'package:wheatwise/features/auth/login/screens/login_screen.dart';
import 'package:wheatwise/features/resources/constants.dart';
import 'package:wheatwise/features/setting/screens/edit_profile_screen.dart';
import 'term_and_conditions_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/wheat-field-bg2.png',
              fit: BoxFit.cover,
            ),
          ),

          // White filter
          Container(
            color: Colors.white.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: settingMenus(),
          ),
          // Positioned(

          //   // bottom: 100,
          //   top: 160, //! change this to be in media query height
          //   left: 0,
          //   right: 0,
          //   child: settingMenus(),
          // ),
          const Positioned(
            // bottom: 100,
            top: 80, //! change this to be in media query height
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  radius: 60,
                ),
                // menu card
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget settingMenus() {
    return Center(
      child: Container(
        height: 700,
        margin: const EdgeInsets.only(top: 160),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Account Setting',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(
                  context, "Edit Profile", 'assets/icons/profile-icon2.svg',
                  () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
              }),
              settingMenu(context, "Change Password",
                  'assets/icons/change-password-icon.svg', () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen()));
              }),
              settingMenu(context, "Sync Data",
                  'assets/icons/sync-data-icon.svg', () {}),
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Preferences',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(context, "Dark Mode",
                  'assets/icons/dark-mode-icon.svg', () {}),
              settingMenu(
                  context, "Language", 'assets/icons/language-icon.svg', () {}),
              settingMenu(context, "Notification",
                  'assets/icons/notification-icon2.svg', () {}),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('General',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Clash Display',
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              const Divider(height: 0, thickness: 0.2),
              settingMenu(
                context,
                "Terms And Conditions",
                'assets/icons/terms-and-condition-icon.svg',
                () {
                  showTermsAndConditionsDialog(context);
                },
              ),
              settingMenu(
                context,
                "Share the app",
                'assets/icons/share-icon2.svg',
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
                'assets/icons/rate-icon.svg',
                () {
                  // _openAppStore();
                },
              ),
              settingMenu(context, "About Us", 'assets/icons/info-icon2.svg',
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
      BuildContext context, String title, String iconPath, Function()? onTap) {
    return SizedBox(
      height: 40,
      // color: Colors.red,
      child: ListTile(
        onTap: onTap,
        // leading: Icon(icon, color: Colors.grey),
        leading: SvgPicture.asset(
          iconPath,
          color: kPrimaryColor,
          width: 18,
          height: 18,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontFamily: 'Clash Display',
            fontWeight: FontWeight.w400,
            // color: BlocProvider.of<ThemeBloc>(context).state.blackColor ==
            //         Colors.white
            //     ? const Color.fromARGB(255, 197, 196, 196)
            //     : BlocProvider.of<ThemeBloc>(context).state.blackColor),
          ),
        ),
      ),
    );
  }
}
