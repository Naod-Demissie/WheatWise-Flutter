import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/setting/change_password/components/change_password_form.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
                      // Icons.chevron_left_rounded,
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

                // wheatwise logo
                Positioned(
                  // bottom: 100,
                  top: 100, //! change this to be in media query height
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      themeState is DarkThemeState
                          ? Image.asset(
                              'assets/logo/wheatwise-logo-white.png',
                              height: 55,
                            )
                          : Image.asset(
                              'assets/logo/wheatwise-logo-black.png',
                              height: 40,
                            ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // title text
                            Text(
                              'Change Password',
                              style: TextStyle(
                                fontFamily: 'Clash Display',
                                fontWeight: FontWeight.w600,
                                fontSize: 26,
                                color: BlocProvider.of<ThemeBloc>(context)
                                    .state
                                    .textColor,
                              ),
                            ),
                            const SizedBox(height: 20),

                            //Reset Password Form
                            const ResetPasswordForm()
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
