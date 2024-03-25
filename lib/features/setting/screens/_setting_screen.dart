import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wheatwise/features/auth/change_password/screen/change_password_screen.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_bloc.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_event.dart';
import 'package:wheatwise/features/auth/login/screens/login_screen.dart';
import 'package:wheatwise/features/resources/constants.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:flutter_svg/flutter_svg.dart';
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
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  radius: 50,
                ),
                // Divider(thickness: 0.2, height: 0),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Account Setting',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Clash Display',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Edit Profile",
                    SvgPicture.asset(
                      'assets/icons/profile-icon2.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ),
                    () {}),
                // const Divider(height: 0, thickness: 0.2),
                settingMenu(
                    context,
                    "Change Password",
                    SvgPicture.asset(
                      'assets/icons/change-password-icon.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ), () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen()));
                }),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Sync Data",
                    SvgPicture.asset(
                      'assets/icons/sync-data-icon.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ),
                    () {}),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Logout",
                    SvgPicture.asset(
                      'assets/icons/logout-icon.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ), () {
                  BlocProvider.of<LogoutBloc>(context)
                      .add(LogoutButtonPressed());
                  // !signOut(context); implement this method
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                }),
                // const Divider(height: 0, thickness: 0.2),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Preferences',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Clash Display',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Dark Mode",
                    SvgPicture.asset(
                      'assets/icons/dark-mode-icon.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ),
                    () {}),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Language",
                    SvgPicture.asset(
                      'assets/icons/language-icon.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ),
                    () {}),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "Notification",
                    SvgPicture.asset(
                      'assets/icons/notification-icon2.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ),
                    () {}),
                // const Divider(height: 0, thickness: 0.2),

                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('General',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Clash Display',
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                const Divider(height: 0, thickness: 0.2),

                settingMenu(
                  context,
                  "Terms And Conditions",
                  SvgPicture.asset(
                    'assets/icons/terms-and-condition-icon.svg',
                    color: kPrimaryColor,
                    width: 20,
                    height: 20,
                  ),
                  () {
                    showTermsAndConditionsDialog(context);
                  },
                ),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                  context, "Share the app",
                  SvgPicture.asset(
                    'assets/icons/share-icon2.svg',
                    color: kPrimaryColor,
                    width: 20,
                    height: 20,
                  ),
                  () {},
                  //   () async {
                  // ShareResult result = await Share.shareWithResult(
                  //     'Check out this awesome app! Download it now: https://your-app-url.com');
                  // if (result.raw.isNotEmpty) {
                  //   showThankYouDialog(context);
                  // }
                  // },
                ),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                  context,
                  "Rate App",
                  SvgPicture.asset(
                    'assets/icons/rate-icon.svg',
                    color: kPrimaryColor,
                    width: 20,
                    height: 20,
                  ),
                  () {
                    // _openAppStore();
                  },
                ),
                // const Divider(height: 0, thickness: 0.2),

                settingMenu(
                    context,
                    "About Us",
                    SvgPicture.asset(
                      'assets/icons/info-icon2.svg',
                      color: kPrimaryColor,
                      width: 20,
                      height: 20,
                    ), () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  // builder: (context) => About(),
                  // ));
                }),
                // const Divider(height: 0, thickness: 0.2),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget settingMenu(
      BuildContext context, String title, Widget leading, Function()? onTap) {
    return SizedBox(
      height: 40,
      // color: Colors.red,
      child: ListTile(
        onTap: onTap,
        // leading: Icon(icon, color: Colors.grey),
        leading: leading,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
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
//   Container settingMenu(
//       BuildContext context, String title, IconData icon, Function()? onTap) {
//     return Container(
//       height: 40,
//       // color: Colors.red,
//       child: ListTile(
//         onTap: onTap,
//         leading: Icon(icon, color: Colors.grey),
//         title: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 13,
//             fontFamily: 'Clash Display',
//             fontWeight: FontWeight.w400,
//             // color: BlocProvider.of<ThemeBloc>(context).state.blackColor ==
//             //         Colors.white
//             //     ? const Color.fromARGB(255, 197, 196, 196)
//             //     : BlocProvider.of<ThemeBloc>(context).state.blackColor),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class SettingScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> settings = [
//     {
//       "icon": Icons.person,
//       "title": "Profile",
//       "trailingIcon": Icons.arrow_forward
//     },
//     {
//       "icon": Icons.notifications,
//       "title": "Notifications",
//       "trailingIcon": Icons.arrow_forward
//     },
//     {
//       "icon": Icons.security,
//       "title": "Security",
//       "trailingIcon": Icons.arrow_forward
//     },
//     {
//       "icon": Icons.language,
//       "title": "Language",
//       "trailingIcon": Icons.arrow_forward
//     },
//     {
//       "icon": Icons.help,
//       "title": "Help & Support",
//       "trailingIcon": Icons.arrow_forward
//     },
//     {"icon": Icons.info, "title": "About", "trailingIcon": Icons.arrow_forward},
//   ];

//   SettingScreen({super.key});

//   Widget _buildListView() {
//     return ListView.builder(
//       itemCount: settings.length * 2 - 1, // Add dividers
//       itemBuilder: (context, index) {
//         if (index.isOdd) {
//           return const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Divider(
//               thickness: 1,
//             ),
//           );
//         }
//         final settingIndex = index ~/ 2;
//         return ListTile(
//           leading: Icon(settings[settingIndex]["icon"]),
//           title: Text(settings[settingIndex]["title"]),
//           trailing:
//               const Icon(Icons.chevron_right), // Greater sign-looking arrow
//           onTap: () {
//             // Add your logic here for handling tap events
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//       ),
//       body: _buildListView(),
//     );
//   }
// }
