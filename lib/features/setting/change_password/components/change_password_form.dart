import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/constants.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_bloc.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_event.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_state.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

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

  String? _oldPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckAuthBloc, CheckAuthState>(
        builder: (context, checkAuthState) {
      if (checkAuthState is CheckAuthSuccessState) {
        return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, changePasswordState) {
            if (changePasswordState is ChangePasswordSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                    ),
                    SizedBox(width: 10),
                    Text('Your password updated successfully!',
                        style: TextStyle(
                            fontFamily: 'Clash Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  showCloseIcon: true,
                  // duration: const Duration(milliseconds: 400),
                  elevation: 0,
                  backgroundColor: Colors.amber,
                  closeIconColor: Colors.black,
                ),
              );
            } else if (changePasswordState is ChangePasswordFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(children: [
                    Icon(Icons.error_outline_rounded),
                    SizedBox(width: 10),
                    Text(
                      'Your password update Failed!',
                      style: TextStyle(
                          fontFamily: 'Clash Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ]),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  showCloseIcon: true,
                  // duration: const Duration(seconds: 2),
                  backgroundColor: Colors.redAccent.shade200,
                  closeIconColor: Colors.black,
                ),
              );
            } else if (changePasswordState is LoadingChangePasswordState) {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.cardColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CupertinoActivityIndicator(
                        color: kPrimaryColor,
                        radius: 16,
                      ),
                    ),
                  ),
                ),
              );
            }
          },
          builder: (context, changePasswordState) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  // sub-title text
                  Text(
                    'Secure your account with a new password.',
                    style: TextStyle(
                      fontFamily: 'Clash Display',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Old Password Textfield
                  TextFormField(
                    style: TextStyle(
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                    ),
                    controller: _currentPsdController,
                    textInputAction: TextInputAction.next,
                    obscureText: _obscureCurrentPsd,
                    cursorColor: kPrimaryColor,
                    validator: (psd) {
                      return _oldPasswordValidator(psd) == null
                          ? BCrypt.checkpw(psd!, checkAuthState.password)
                              ? null
                              : "wrong old password, \nplease contact support team to reset."
                          : "old password is required.";
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          BlocProvider.of<ThemeBloc>(context).state.cardColor,
                      hintText: "Old Password",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(113, 113, 113, 1),
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 16.0,
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
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 1))),
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
                    style: TextStyle(
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                    ),
                    controller: _newPsdController,
                    textInputAction: TextInputAction.next,
                    obscureText: _obscureNewPsd,
                    cursorColor: const Color(0xFFEFBC08),
                    validator: (psd) {
                      return _passwordValidator(psd);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          BlocProvider.of<ThemeBloc>(context).state.cardColor,
                      hintText: "New password",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(113, 113, 113, 1),
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 16.0,
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
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 1))),
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
                    style: TextStyle(
                      color:
                          BlocProvider.of<ThemeBloc>(context).state.textColor,
                      fontFamily: 'SF-Pro-Text',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w100,
                    ),
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
                      fillColor:
                          BlocProvider.of<ThemeBloc>(context).state.cardColor,
                      hintText: "Confirm password",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(113, 113, 113, 1),
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 16.0,
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
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 1))),
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
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      } else if (checkAuthState is CheckAuthInitialState) {
        BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthEvent());
      } else if (checkAuthState is CheckAuthFailedState) {
        return const Text("Unknown Error, If it persists please contact us.");
      }
      return const SizedBox.shrink();
    });
  }
}
