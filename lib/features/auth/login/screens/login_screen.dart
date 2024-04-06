import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_event.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_state.dart';
import 'package:wheatwise/features/auth/login/bloc/login_bloc.dart';
import 'package:wheatwise/features/auth/login/bloc/login_event.dart';
import 'package:wheatwise/features/auth/login/bloc/login_state.dart';
import 'package:wheatwise/features/page_navigator/screens/page_navigator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//! implement the code that scroll to the next field when typing
//! track the state when the email is corrected

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _showLoginForm = true;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  TextFormField customTextField({
    String? hintText,
    String? helperText,
    String? Function(String?)? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool isPassword = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        filled: false,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'SF-Pro-Text',
          fontSize: 15.0,
          fontWeight: FontWeight.w100,
        ),
        helperText: helperText,
        helperStyle: GoogleFonts.manrope(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: Colors.black,
        ),
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: const Color.fromRGBO(113, 113, 113, 1),
                ),
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(176, 176, 176, 1),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(239, 188, 8, 0.6)),
        ),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(239, 188, 8, 1))),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
        ),
        focusColor: const Color.fromRGBO(239, 188, 8, 1),
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      controller: controller,
      obscureText: isPassword ? _obscureText : false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/wheat-field-bg2.png',
                fit: BoxFit.cover,
              ),
            ),

            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),

            // wheatwise logo
            Positioned(
              // bottom: 100,
              top: 170, //! change this to be in media query height
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Image.asset(
                    'assets/logo/wheatwise-logo-white.png',
                    height: 65,
                  ),

                  // login/forget password card
                  showLoginCard(context),
                ],
              ),
            ),

            // Copyright text
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '© 2024 EAII. All rights reserved.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showLoginCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, loginState) {
        if (loginState is LoginSuccessState) {
          BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthEvent());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const PageNavigator(),
              ),
              (route) => false);
        }
        if (loginState is LoginFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Failed!'),
            ),
          );
        } else if (loginState is LoginInitialState) {
          _formKey.currentState?.reset();

          setState(() {
            _emailController.clear();
            _passwordController.clear();
            _showLoginForm = false;
          });
        }
      },
      builder: (context, loginState) {
        return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, forgetPasswordState) {
            if (forgetPasswordState is ForgetPasswordSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset is successful!'),
                ),
              );
              _formKey.currentState?.reset();

              setState(() {
                _emailController.clear();
                _passwordController.clear();
                _showLoginForm = true;
              });
            } else if (forgetPasswordState is ForgetPasswordFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset is Failed!'),
                ),
              );
            } else if (forgetPasswordState is ForgetPasswordInitialState) {
              _formKey.currentState?.reset();

              setState(() {
                _emailController.clear();
                _passwordController.clear();
                _showLoginForm = true;
              });
            }
          },
          builder: (context, forgetPasswordState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.02),

                          // title text
                          Text(
                            _showLoginForm ? 'Welcome Back' : 'Forgot Password',
                            style: const TextStyle(
                              fontFamily: 'Clash Display',
                              fontWeight: FontWeight.w600,
                              fontSize: 26,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: height * 0.03),

                          // email form field
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                customTextField(
                                  hintText: _showLoginForm
                                      ? 'Username or Email'
                                      : 'Email',
                                  helperText: !_showLoginForm
                                      ? 'Enter the email for your password reset OTP.'
                                      : null,
                                  validator: _emailValidator,
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: _showLoginForm
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                ),

                                const SizedBox(height: 10),

                                // password form field
                                _showLoginForm
                                    ? customTextField(
                                        hintText: 'Password',
                                        validator: _passwordValidator,
                                        controller: _passwordController,
                                        textInputAction: TextInputAction.done,
                                        isPassword: true,
                                      )
                                    : const SizedBox.shrink(),

                                _showLoginForm
                                    ? const SizedBox(height: 10)
                                    : const SizedBox.shrink(),

                                // forget password text
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<LoginBloc>(context)
                                          .add((InitialEvent()));
                                    },
                                    child: _showLoginForm
                                        ? const Text(
                                            'Forgot password?',
                                            style: TextStyle(
                                              color: Color(0xFF3D80DE),
                                              fontFamily: 'SF-Pro-Text',
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w200,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_showLoginForm) {
                                  // login button pressed
                                  String email = _emailController.text;
                                  String password = _passwordController.text;
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginButtonPressed(
                                      username: email,
                                      password: password,
                                    ),
                                  );
                                } else {
                                  // submit button pressed for the forget password page
                                  String email = _emailController.text;
                                  BlocProvider.of<ForgetPasswordBloc>(context)
                                      .add(ForgetPasswordEvent(email: email));
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(248, 147, 29, 1),
                              ),
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 52),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (forgetPasswordState
                                          is LoadingForgetPasswordState ||
                                      loginState is LoginLoadingState)
                                  ? Center(
                                      child: JumpingDots(
                                        color: Colors.white,
                                        radius: 5,
                                        numberOfDots: 3,
                                        verticalOffset: 10,
                                      ),
                                    )
                                  : Text(
                                      _showLoginForm ? 'Login' : 'Submit',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'SF-Pro-Text',
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                            ),
                          ),

                          // Go Back text button
                          const SizedBox(height: 16),
                          !_showLoginForm
                              ? Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ForgetPasswordBloc>(
                                              context)
                                          .add((LoadForgetPasswordEvent()));
                                    },
                                    child: const Text(
                                      // 'Go Back',
                                      'Back To Login',
                                      style: TextStyle(
                                        color: Color(0xFF3D80DE),
                                        fontFamily: 'SF-Pro-Text',
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
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
