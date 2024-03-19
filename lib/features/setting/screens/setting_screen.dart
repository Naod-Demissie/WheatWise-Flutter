import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

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

                buildAccountOptionRow(
                    context, "Edit Profile", Icons.person_2_outlined, () {}),
                // const Divider(height: 0, thickness: 0.2),
                buildAccountOptionRow(
                    context, "Change Password", Icons.lock, () {}),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(context, "Sync Data", Icons.lock, () {}),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(context, "Logout", Icons.lock, () {}),
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
                buildAccountOptionRow(
                    context, "Dark Mode", Icons.feedback_outlined, () {}),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(
                    context, "Language", Icons.feedback_outlined, () {}),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(
                    context, "Notification", Icons.feedback_outlined, () {}),
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

                buildAccountOptionRow(
                  context,
                  "Terms And Conditions",
                  Icons.list_alt_sharp,
                  () {
                    showTermsAndConditionsDialog(context);
                  },
                ),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(
                  context, "Share the app",
                  Icons.share, () {},
                  //   () async {
                  // ShareResult result = await Share.shareWithResult(
                  //     'Check out this awesome app! Download it now: https://your-app-url.com');
                  // if (result.raw.isNotEmpty) {
                  //   showThankYouDialog(context);
                  // }
                  // },
                ),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(
                  context,
                  "Rate App",
                  Icons.rate_review_outlined,
                  () {
                    // _openAppStore();
                  },
                ),
                // const Divider(height: 0, thickness: 0.2),

                buildAccountOptionRow(
                    context, "About Us", Icons.info_outline_rounded, () {
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

  Container buildAccountOptionRow(
      BuildContext context, String title, IconData icon, Function()? onTap) {
    return Container(
      height: 40,
      // color: Colors.red,
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.grey),
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
