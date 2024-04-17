import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';
import 'package:wheatwise/features/resources/constants.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_event.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_state.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';

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
      builder: (context, checkAuthState) {
        if (checkAuthState is CheckAuthSuccessState) {
          return BlocConsumer<EditProfileBloc, EditProfileState>(
            listener: (context, editProfileState) {
              if (editProfileState is EditProfileSuccessState) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Your profile updated successfully!'),
                  ),
                );
              } else if (editProfileState is EditProfileFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile update Failed!'),
                  ),
                );
              } else if (editProfileState is LoadingEditProfileState) {
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
            builder: (context, editProfileState) {
              return Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: BlocProvider.of<ThemeBloc>(context)
                        .state
                        .backgroundColor,
                    surfaceTintColor: Colors.white,
                    elevation: 3,
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
                                  },
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                      'Save'),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: customElevatedButton(() {
                                    Navigator.of(context).pop();
                                  },
                                      MaterialStateProperty.all<Color>(
                                          const Color.fromRGBO(
                                              248, 147, 29, 1)),
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
            },
          );
        } else if (checkAuthState is CheckAuthInitialState) {
          BlocProvider.of<CheckAuthBloc>(context).add(CheckAuthEvent());
        } else if (checkAuthState is CheckAuthFailedState) {
          return const Text("Unknown Error, If it persists please contact us.");
        }
        return const SizedBox.shrink();
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
      style: TextStyle(
        color: BlocProvider.of<ThemeBloc>(context).state.textColor,
        fontFamily: 'SF-Pro-Text',
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 21,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
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
      dropdownColor: BlocProvider.of<ThemeBloc>(context).state.cardColor,
      elevation: 5,
      style: TextStyle(
        color: BlocProvider.of<ThemeBloc>(context).state.textColor,
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
        labelStyle: TextStyle(
          fontFamily: 'Clash Display',
          fontWeight: FontWeight.w400,
          fontSize: 21,
          color: BlocProvider.of<ThemeBloc>(context).state.textColor,
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
