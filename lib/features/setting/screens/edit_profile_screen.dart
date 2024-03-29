import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_bloc.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_event.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';

import 'package:wheatwise/features/resources/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wheatwise/features/auth/change_password/bloc/change_password_bloc.dart';
// import 'package:wheatwise/features/auth/change_password/bloc/change_password_event.dart';
// import 'package:wheatwise/features/auth/change_password/bloc/change_password_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Clash Display',
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: Colors.black,
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
                color: Colors.white.withOpacity(0.9),
                width: double.infinity,
                height: double.infinity,
              ),

              // wheatwise logo
              const Positioned(
                // bottom: 100,
                top: 100, //! change this to be in media query height
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          // title text
                          Text(
                            'Secure your account with a new password.',
                            style: TextStyle(
                              fontFamily: 'Clash Display',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),

                          ResetPasswordForm()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPsdController = TextEditingController();
  final TextEditingController _newPsdController = TextEditingController();
  final TextEditingController _confirmPsdController = TextEditingController();

  bool _obscureCurrentPsd = true;
  bool _obscureNewPsd = true;
  bool _obscureConfirmPsd = true;

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    if (!password.contains(RegExp(r'\d'))) {
      return 'Password must contain at least one numerical character';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase character';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one symbol';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckAuthBloc, CheckAuthStates>(
        builder: (context, state) {
      if (state is CheckAuthSuccessState) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              // Old Password Textfield
              TextFormField(
                controller: _currentPsdController,
                textInputAction: TextInputAction.next,
                obscureText: _obscureCurrentPsd,
                cursorColor: kPrimaryColor,
                validator: (psd) {
                  return _passwordValidator(psd) == null
                      ? BCrypt.checkpw(psd!, state.password)
                          ? null
                          : "wrong old password, \nplease contact support team to reset."
                      : "old password is required.";
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Current Password",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(113, 113, 113, 1),
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w100,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPsd = !_obscureCurrentPsd;
                      });
                    },
                    icon: Icon(
                      _obscureCurrentPsd
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: const Color.fromRGBO(113, 113, 113, 1),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(176, 176, 176, 1),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(239, 188, 8, 0.6)),
                    // Color of the border when focused
                  ),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(239, 188, 8, 1))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
                  ),
                  focusColor: const Color.fromRGBO(239, 188, 8, 1),
                ),
              ),
              const SizedBox(height: 12),

              // New Password Textfield
              TextFormField(
                controller: _newPsdController,
                textInputAction: TextInputAction.next,
                obscureText: _obscureNewPsd,
                cursorColor: const Color(0xFFEFBC08),
                validator: (psd) {
                  return _passwordValidator(psd);
                },
                decoration: InputDecoration(
                  filled: true,
                  hintText: "New password",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(113, 113, 113, 1),
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w100,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureNewPsd = !_obscureNewPsd;
                      });
                    },
                    icon: Icon(
                      _obscureNewPsd
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: const Color.fromRGBO(113, 113, 113, 1),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(176, 176, 176, 1),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(239, 188, 8, 0.6)),
                    // Color of the border when focused
                  ),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(239, 188, 8, 1))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
                  ),
                  focusColor: const Color.fromRGBO(239, 188, 8, 1),
                ),
              ),
              const SizedBox(height: 12),

              // Confirm Password Textfield
              TextFormField(
                controller: _confirmPsdController,
                textInputAction: TextInputAction.done,
                cursorColor: const Color(0xFFEFBC08),
                validator: (psd) {
                  return _passwordValidator(psd) == null
                      ? psd! == _newPsdController.text
                          ? null
                          : "password does not mach"
                      : "confirm password is required";
                },
                obscureText: _obscureConfirmPsd,
                decoration: InputDecoration(
                  filled: true,
                  hintText: "Confirm password",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(113, 113, 113, 1),
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w100,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPsd = !_obscureConfirmPsd;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPsd
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: const Color.fromRGBO(113, 113, 113, 1),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(176, 176, 176, 1),
                    ),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(239, 188, 8, 0.6)),
                    // Color of the border when focused
                  ),
                  errorBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(239, 188, 8, 1))),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
                  ),
                  focusColor: const Color.fromRGBO(239, 188, 8, 1),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<ChangePasswordBloc>(context).add(
                        ChangePasswordEvent(
                            currentPassword: _currentPsdController.text,
                            newPassword: _newPsdController.text,
                            newPassword2: _confirmPsdController.text));
                  }
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
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Text',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      } else
        return Container(
            child:
                const Text("Unknown Error, If it persists please contact us."));
    });
  }
}
