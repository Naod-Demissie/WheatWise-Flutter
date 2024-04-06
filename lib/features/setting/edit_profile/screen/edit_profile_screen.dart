import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_event.dart';

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
          centerTitle: true,
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
              color: Colors.white.withOpacity(0.8),
              width: double.infinity,
              height: double.infinity,
            ),

            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    // Profile Picture
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
  // late final TextEditingController _sexController;
  late String _regionController;
  late final TextEditingController _zoneController;
  late final TextEditingController _woredaController;

  List<String> regionItems = [
    "Addis Ababa",
    "Afar",
    "Amhara",
    "Benishangul-Gumuz",
    "Dire Dawa",
    "Gambela",
    "Harari",
    "Oromia",
    "Sidama",
    "Somali",
    "SWEP's, Region",
    "SNNP's Region",
    "Tigray"
  ];
  List<String> sexItems = ['Male', 'Female'];

  @override
  void initState() {
    super.initState();

    _userNameController =
        TextEditingController(text: widget.prefs.getString('username') ?? '');
    _prefixController =
        TextEditingController(text: widget.prefs.getString('prefix') ?? '');
    _firstNameController =
        TextEditingController(text: widget.prefs.getString('firstName') ?? '');
    _lastNameController =
        TextEditingController(text: widget.prefs.getString('lastName') ?? '');
    _regionController = widget.prefs.getString('region') ?? '';
    _zoneController =
        TextEditingController(text: widget.prefs.getString('zone') ?? '');
    _woredaController =
        TextEditingController(text: widget.prefs.getString('woreda') ?? '');
  }

  String? validateMinimumLength(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 2) {
      return 'Field must have at least 2 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckAuthBloc, CheckAuthState>(
      builder: (context, state) {
        if (state is CheckAuthSuccessState) {
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: customTextField(
                                validateMinimumLength,
                                _prefixController,
                                hintText: 'Prefix',
                                labelText: 'Prefix',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 4,
                              child: customTextField(
                                validateMinimumLength,
                                _firstNameController,
                                hintText: 'First Name',
                                labelText: 'First Name',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: customTextField(
                                validateMinimumLength,
                                _lastNameController,
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: customTextField(
                                validateMinimumLength,
                                _userNameController,
                                hintText: 'Username',
                                labelText: 'Username',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CustomDropdownMenu(
                            items: regionItems,
                            labelText: 'Region',
                            selectedItem: _regionController,
                            onChanged: (item) {
                              setState(() {
                                _regionController = item!;
                              });
                            },
                          ),
                        ),

                        // SizedBox(
                        //   width: double.infinity,
                        //   child: customDropdownMenu(
                        //     regionItems,
                        //     'Region',
                        //     _regionController,
                        //   ),
                        // ),

                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: customTextField(
                                validateMinimumLength,
                                _zoneController,
                                hintText: 'Zone',
                                labelText: 'Zone',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: customTextField(
                                validateMinimumLength,
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
                              child: customElevatedButton(() {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<EditProfileBloc>(context)
                                      .add(EditProfileEvent(
                                    username: _userNameController.text,
                                    prefix: _prefixController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    region: _regionController,
                                    zone: _zoneController.text,
                                    woreda: _woredaController.text,
                                  ));
                                }
                              }, MaterialStateProperty.all<Color>(Colors.black),
                                  'Save'),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: customElevatedButton(() {
                                Navigator.of(context).pop();
                              },
                                  MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(248, 147, 29, 1)),
                                  'Cancel'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Text("Unknown Error, If it persists please contact us.");
        }
      },
    );
  }
  //

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
          fontSize: 17.0,
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
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'SF-Pro-Text',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 21,
          color: Colors.black,
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

  // Widget customDropdownMenu(
  //   List<String> items,
  //   String? labelText,
  //   String? selectedItem,
  // ) {
  //   return DropdownButtonFormField(
  //     elevation: 5,
  //     style: const TextStyle(
  //       color: Colors.black,
  //       fontFamily: 'SF-Pro-Text',
  //       fontSize: 16.0,
  //       fontWeight: FontWeight.w400,
  //     ),
  //     value: selectedItem,
  //     items: items
  //         .map((item) =>
  //             DropdownMenuItem<String>(value: item, child: Text(item)))
  //         .toList(),
  //     onChanged: (item) => setState(() {
  //       selectedItem = item;
  //     }),
  //     icon: const Icon(Icons.arrow_drop_down),
  //     decoration: InputDecoration(
  //       labelText: labelText,
  //       labelStyle: const TextStyle(
  //         fontFamily: 'Clash Display',
  //         fontWeight: FontWeight.w400,
  //         fontSize: 21,
  //         color: Colors.black,
  //       ),
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       filled: false,
  //       hintStyle: const TextStyle(
  //         color: Color.fromRGBO(113, 113, 113, 1),
  //         fontFamily: 'SF-Pro-Text',
  //         fontSize: 14.0,
  //         fontWeight: FontWeight.w100,
  //       ),
  //       enabledBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(
  //           color: Color.fromRGBO(176, 176, 176, 1),
  //         ),
  //       ),
  //       focusedErrorBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.red),
  //       ),
  //       errorBorder:
  //           const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
  //       focusedBorder: const OutlineInputBorder(
  //         borderSide:
  //             BorderSide(width: 1.5, color: Color.fromRGBO(239, 188, 8, 1)),
  //       ),
  //     ),
  //   );
  // }
}

class CustomDropdownMenu extends StatelessWidget {
  final List<String> items;
  final String? labelText;
  final String? selectedItem;
  final void Function(String?) onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.items,
    this.labelText,
    this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      elevation: 5,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'SF-Pro-Text',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      value: selectedItem,
      items: items
          .map((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      icon: const Icon(Icons.arrow_drop_down),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 21,
          color: Colors.black,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: false,
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
    );
  }
}
