import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wheatwise/features/auth/screens/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  //! implement the code that scroll to the next field when typing

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: height * 0.05),
                  // Image.asset(
                  //   'assets/logo/aii.png',
                  //   // height: 80,
                  //   width: 100, //! change this with media query height
                  // ),
                  SizedBox(height: height * 0.005),
                  const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontFamily: 'Clash Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  const Text(
                    'Please enter the email address you\'d like your password reset OTP sent to',
                    style: TextStyle(
                      fontFamily: 'Clash Display',
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            filled: false,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontFamily: 'SF-Pro-Text',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w100,
                            ),
                            labelText: 'Email',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              // color: state.hasError
                              //     ? Constants.errorColor
                              //     : Constant.greyColor,
                              fontFamily: 'SF-Pro-Text',
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(239, 188, 8, 0.6)),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 1))),
                            focusedBorder: OutlineInputBorder(
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
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(248, 147, 29, 1)),
                      minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 52),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Adjust the border radius as needed
                        ),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: GestureDetector(
                  //     onTap: _navigateToLogin,
                  //     child: const Text(
                  //       // 'Go Back',
                  //       'Back To Login',
                  //       style: TextStyle(
                  //         color: Color(0xFF3D80DE),
                  //         fontFamily: 'SF-Pro-Text',
                  //         fontSize: 13.0,
                  //         fontWeight: FontWeight.w300,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
