import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:wheatwise/features/home/bloc/diagnosis_statistics_bloc.dart';
import 'package:wheatwise/features/records/bookmark/bloc/bookmark_bloc.dart';
import 'package:wheatwise/features/records/delete_record/bloc/delete_record_bloc.dart';
import 'package:wheatwise/features/records/manual_diagnosis/bloc/manual_diagnosis_bloc.dart';
import 'package:wheatwise/features/records/mobile_diagnosis/bloc/mobile_diagnosis_bloc.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_bloc.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_bloc.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_bloc.dart';
import 'package:wheatwise/features/records/file_upload/bloc/upload_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/bloc/diagnosis_detail_bloc.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:wheatwise/features/splash/screens/splash_screen.dart';
import 'package:wheatwise/features/theme/bloc/theme_bloc.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';
import 'package:wheatwise/features/theme/theme.dart';
import 'features/auth/login/bloc/login_bloc.dart';
import 'features/records/recent_records/bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Hive.initFlutter();
  Hive.registerAdapter(DiagnosisAdapter());
  await Hive.openBox<Diagnosis>("Diagnosis");

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({
    super.key,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => LogoutBloc()),
        BlocProvider(create: (context) => CheckAuthBloc(prefs: prefs)),
        BlocProvider(create: (context) => ChangePasswordBloc()),
        BlocProvider(create: (context) => UploadBloc()),
        BlocProvider(create: (context) => DiagnosisDetailBloc()),
        BlocProvider(create: (context) => RecentRecordsBloc()),
        BlocProvider(create: (context) => DeleteRecordBloc()),
        BlocProvider(create: (context) => BookmarkBloc()),
        BlocProvider(create: (context) => ManualDiagnosisBloc()),
        BlocProvider(create: (context) => EditProfileBloc()),
        BlocProvider(create: (context) => ForgetPasswordBloc()),
        BlocProvider(create: (context) => MobileDiagnosisBloc()),
        BlocProvider(create: (context) => DiagnosisStatisticsBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'WheatWise',
            // theme: ThemeData(
            //   colorScheme: const ColorScheme.light(),
            //   useMaterial3: true,
            // ),
            home: const SplashScreen(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                themeState is DarkThemeState ? ThemeMode.dark : ThemeMode.light,

            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final SharedPreferences prefs;

//   const MyApp({
//     super.key,
//     required this.prefs,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => LoginBloc()),
//         BlocProvider(create: (context) => LogoutBloc()),
//         BlocProvider(create: (context) => CheckAuthBloc(prefs: prefs)),
//         BlocProvider(create: (context) => ChangePasswordBloc()),
//         BlocProvider(create: (context) => UploadBloc()),
//         BlocProvider(create: (context) => DiagnosisDetailBloc()),
//         BlocProvider(create: (context) => RecentRecordsBloc()),
//         BlocProvider(create: (context) => DeleteRecordBloc()),
//         BlocProvider(create: (context) => BookmarkBloc()),
//         BlocProvider(create: (context) => ManualDiagnosisBloc()),
//         BlocProvider(create: (context) => EditProfileBloc()),
//         BlocProvider(create: (context) => ForgetPasswordBloc()),
//         BlocProvider(create: (context) => MobileDiagnosisBloc()),
//         BlocProvider(create: (context) => ThemeBloc()),
//       ],
//       child: const MaterialApp(
//         title: 'WheatWise',
//         // theme: ThemeData(
//         //   colorScheme: const ColorScheme.light(),
//         //   useMaterial3: true,
//         // ),
//         home: SplashScreen(),

//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load();

//   await Hive.initFlutter();
//   Hive.registerAdapter(DiagnosisAdapter());
//   await Hive.openBox<Diagnosis>("Diagnosis");

//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('token');
//   bool isLoggedIn = token != null;

//   runApp(MyApp(
//     isLoggedIn: isLoggedIn,
//     prefs: prefs,
//   ));
// }

// class MyApp extends StatelessWidget {
//   final bool isLoggedIn;
//   final SharedPreferences prefs;

//   const MyApp({
//     super.key,
//     required this.isLoggedIn,
//     required this.prefs,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => LoginBloc()),
//         BlocProvider(create: (context) => LogoutBloc()),
//         BlocProvider<CheckAuthBloc>(
//             create: (context) => CheckAuthBloc(prefs: prefs)),
//         BlocProvider(create: (context) => ChangePasswordBloc()),
//         BlocProvider(create: (context) => UploadBloc()),
//         BlocProvider(create: (context) => DiagnosisDetailBloc()),
//         BlocProvider(create: (context) => RecentRecordsBloc()),
//         BlocProvider(create: (context) => DeleteRecordBloc()),
//         BlocProvider(create: (context) => BookmarkBloc()),
//         BlocProvider(create: (context) => ManualDiagnosisBloc()),
//       ],
//       child: const MaterialApp(
//         title: 'WheatWise',
//         // theme: ThemeData(
//         //   colorScheme: const ColorScheme.light(),
//         //   useMaterial3: true,
//         // ),
//         home: SplashScreen(),
//         // home: BlocBuilder<CheckAuthBloc, CheckAuthState>(
//         //   builder: (context, checkAuthState) {
//         //     return checkAuthState is CheckAuthSuccessState || isLoggedIn
//         //         ? const PageNavigator()
//         //         : const LoginScreen();
//         //   },
//         // ),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
