import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  void _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {}); // Update the UI after loading SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // title: const Text(
          //   'Edit Profile',
          //   style: TextStyle(
          //     fontFamily: 'Clash Display',
          //     fontWeight: FontWeight.w600,
          //     fontSize: 26,
          //     color: Colors.black,
          //   ),
          // ),
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
              color: Colors.white.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
            ),

            Center(
              child: Column(
                children: [
                  // const SizedBox(height: 40),
                  // Profile Pciture
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                        radius: 65,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  // Profile Edit Card
                  EditProfileForm(_prefs)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  final SharedPreferences prefs;

  const EditProfileForm(
    this.prefs, {
    super.key,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _userNameController;
  late final TextEditingController _prefixController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _sexController;
  late final TextEditingController _regionController;
  late final TextEditingController _zoneController;
  late final TextEditingController _woredaController;

  @override
  void initState() {
    super.initState();

    _userNameController =
        TextEditingController(text: widget.prefs.getString('username') ?? '');
    _prefixController =
        TextEditingController(text: widget.prefs.getString('prefix') ?? '');
    _firstNameController =
        TextEditingController(text: widget.prefs.getString('firstname') ?? '');
    _lastNameController =
        TextEditingController(text: widget.prefs.getString('lastname') ?? '');
    _emailController =
        TextEditingController(text: widget.prefs.getString('email') ?? '');
    _sexController =
        TextEditingController(text: widget.prefs.getString('sex') ?? '');
    _regionController =
        TextEditingController(text: widget.prefs.getString('region') ?? '');
    _zoneController =
        TextEditingController(text: widget.prefs.getString('zone') ?? '');
    _woredaController =
        TextEditingController(text: widget.prefs.getString('woreda') ?? '');
  }

  String? _passwordValidator(String? password) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<CheckAuthBloc, CheckAuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      // title text

                      // email form field
                      customTextField(
                        null,
                        _userNameController,
                        hintText: 'Username',
                        labelText: 'Username',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: customTextField(
                              null,
                              _firstNameController,
                              hintText: 'First Name',
                              labelText: 'First Name',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: customTextField(
                              null,
                              _lastNameController,
                              hintText: 'Last Name',
                              labelText: 'Last Name',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      customTextField(
                        null,
                        _emailController,
                        hintText: 'Email',
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: customTextField(
                              null,
                              _sexController,
                              hintText: 'Sex',
                              labelText: 'Sex',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            flex: 4,
                            child: customTextField(
                              null,
                              _regionController,
                              hintText: 'Region',
                              labelText: 'Region',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: customTextField(
                              null,
                              _zoneController,
                              hintText: 'Zone',
                              labelText: 'Zone',
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: customTextField(
                              null,
                              _woredaController,
                              hintText: 'Woreda',
                              labelText: 'Woreda',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Buttons
                      Row(
                        children: [
                          Expanded(
                              child: customElevatedButton(
                                  () {},
                                  MaterialStateProperty.all<Color>(
                                      Colors.black),
                                  'Save')),
                          const SizedBox(width: 20),
                          Expanded(
                              child: customElevatedButton(() {
                            Navigator.of(context).pop();
                          },
                                  MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(248, 147, 29, 1)),
                                  'Cancel')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget customElevatedButton(void Function()? onPressed,
      MaterialStateProperty<Color?>? buttonColor, String buttonText) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: buttonColor,
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
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'SF-Pro-Text',
          fontSize: 15.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  TextFormField customTextField(
    String? Function(String?)? validator,
    TextEditingController controller, {
    String? hintText,
    String? helperText,
    String? labelText,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromRGBO(113, 113, 113, 1),
          fontFamily: 'SF-Pro-Text',
          fontSize: 17.0,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(113, 113, 113, 1),
          fontFamily: 'SF-Pro-Text',
          fontSize: 14.0,
          fontWeight: FontWeight.w100,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(176, 176, 176, 1),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
        ),
      ),
      validator: validator,
      controller: controller,
    );
  }
}