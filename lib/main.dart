import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/change_password/bloc/change_password_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_bloc.dart';
import 'package:wheatwise/features/auth/login/screens/login_screen.dart';
import 'package:wheatwise/features/file_upload/bloc/upload_bloc.dart';
import 'package:wheatwise/features/page_navigator/screens/page_navigator.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'features/auth/login/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Hive.initFlutter();
  Hive.registerAdapter(DiagnosisAdapter());
  await Hive.openBox<Diagnosis>("Diagnosis");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  bool isLoggedIn = token != null;

  print('Hwllo');
  printAllRecords();

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    prefs: prefs,
  ));
}

void printAllRecords() {
  var box = Hive.box<Diagnosis>("Diagnosis");
  print(box.length);
  for (var i = 0; i < box.length; i++) {
    var record = box.getAt(i);
    print(record);
    print('$i $record');
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final SharedPreferences prefs;

  const MyApp({
    super.key,
    required this.isLoggedIn,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
        BlocProvider<CheckAuthBloc>(
            create: (context) => CheckAuthBloc(prefs: prefs)),
        BlocProvider(create: (context) => ChangePasswordBloc()),
        BlocProvider(create: (context) => UploadBloc()),
      ],
      child: MaterialApp(
        title: 'WheatWise',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(),
          useMaterial3: true,
        ),
        home: BlocBuilder<CheckAuthBloc, CheckAuthStates>(
          builder: (context, checkAuthState) {
            return checkAuthState is CheckAuthSuccessState ||
                    (isLoggedIn && checkAuthState is LoadingCheckAuthState)
                ? const PageNavigator()
                : const LoginScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
