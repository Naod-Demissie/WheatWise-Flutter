import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/login/bloc/login_bloc.dart';
import 'package:wheatwise/features/auth/login/bloc/login_event.dart';
import 'package:wheatwise/features/auth/login/bloc/login_state.dart';
// import 'package:wheatwise/features/auth/auth_bloc/login_bloc/login_event.dart';
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
    } //! add the logic to pass this validation when in forget page
    return null;
  }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginStates>(listener: (context, state) {
      if (state is LoginSuccessState) {
        BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthEvent());
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const PageNavigator(),
            ),
            (route) => false);
      }
    }, builder: (context, state) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                    // login card
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
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget showLoginCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                    _showLoginForm ? 'Welcome back' : 'Forgot Password',
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
                        TextFormField(
                          decoration: InputDecoration(
                            filled: false,
                            hintText:
                                _showLoginForm ? 'Username or Email' : 'Email',
                            hintStyle: const TextStyle(
                              color: Color.fromRGBO(113, 113, 113, 1),
                              fontFamily: 'SF-Pro-Text',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w100,
                            ),
                            helperText: !_showLoginForm
                                ? 'Enter the email for your password reset OTP.'
                                : null,
                            helperStyle: !_showLoginForm
                                ? GoogleFonts.manrope(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    color: Colors.black,
                                  )
                                : null,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(176, 176, 176, 1),
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(239, 188, 8, 1)),
                            ),
                          ),
                          validator: _emailValidator,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 10),

                        // password form field
                        _showLoginForm
                            ? TextFormField(
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'SF-Pro-Text',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  suffixIcon: IconButton(
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
                                      color: const Color.fromRGBO(
                                          113, 113, 113, 1),
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(176, 176, 176, 1),
                                    ),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(239, 188, 8, 0.6)),
                                    // Color of the border when focused
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromRGBO(239, 188, 8, 1))),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: Color.fromRGBO(239, 188, 8, 1)),
                                  ),
                                  focusColor:
                                      const Color.fromRGBO(239, 188, 8, 1),
                                ),
                                validator: _passwordValidator,
                                controller: _passwordController,
                                obscureText: _obscureText,
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
                              setState(() {
                                _showLoginForm = !_showLoginForm;
                                _emailController.clear();
                                _passwordController.clear();
                                _formKey.currentState?.reset();
                              });
                              setState(() {});
                            },
                            child: _showLoginForm
                                ? const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: Color(0xFF3D80DE),
                                      fontFamily: 'SF-Pro-Text',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100,
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
                                username: email, password: password),
                          );
                        } else {
                          // // submit button pressed for the forget password page
                          // String email = _emailController.text;
                          // BlocProvider.of<LoginBloc>(context).add(
                          //   LoginButtonPressed(
                          //       username: email, password: password),
                          // );
                          // //! send a pop up message with

                          setState(
                            () {
                              _showLoginForm = !_showLoginForm;
                            },
                          );
                        }
                      }
                      setState(
                        () {
                          _emailController.clear();
                          _passwordController.clear();
                        },
                      );
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
                    child: Text(
                      _showLoginForm ? 'Login' : "Submit",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  !_showLoginForm
                      ? Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showLoginForm = !_showLoginForm;
                                _emailController.clear();
                                _passwordController.clear();
                                _formKey.currentState?.reset();
                              });
                              setState(() {});
                            },
                            child: const Text(
                              // 'Go Back',
                              'Back To Login',
                              style: TextStyle(
                                color: Color(0xFF3D80DE),
                                fontFamily: 'SF-Pro-Text',
                                fontSize: 13.0,
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
  }
}
