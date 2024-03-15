import 'package:flutter/material.dart';
import 'package:wheatwise/features/auth/screens/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

//! implement the code that scroll to the next field when typing

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.05),
                  // Image.asset(
                  //   'assets/logo/wheatwise-logo-black.png',
                  //   height: 40, //! change this with media query height
                  // ),
                  Image.asset(
                    'assets/logo/aii.png',
                    height: 100, //! change this with media query height
                  ),
                  SizedBox(height: height * 0.05),
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                      fontFamily: 'Clash Display',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
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
                              // color: Colors.grey,
                            ),
                            labelText: 'Email',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              fontFamily: 'SF-Pro-Text',
                              fontSize: 13.0,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                              // color: state.hasError
                              //   ? Constant.errorColor
                              //   : Constant.greyColor,
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
                        Container(
                          alignment: Alignment.centerLeft,
                          // height: 54,
                          // width: 361,
                          child: TextFormField(
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
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(239, 188, 8, 0.6)),
                                // Color of the border when focused
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(239, 188, 8, 1))),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Color.fromRGBO(239, 188, 8, 1)),
                              ),

                              focusColor: const Color.fromRGBO(239, 188, 8, 1),
                              //  contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                            ),
                            validator: _passwordValidator,
                            controller: _passwordController,
                            obscureText: _obscureText,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _navigateToForgotPassword,
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Color(0xFF3D80DE),
                                fontFamily: 'SF-Pro-Text',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 38),
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
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SF-Pro-Text',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
