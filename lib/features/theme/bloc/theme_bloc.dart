import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/theme/bloc/theme_event.dart';
import 'package:wheatwise/features/theme/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(InitialThemeState()) {
    on<ChangeThemeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? theme = prefs.getBool('theme');
      if (theme == null) {
        await prefs.setBool('theme', true);
        theme = true;
      }

      await prefs.setBool('theme', !theme);
      theme = !theme;

      if (theme) emit(LightThemeState());
      if (!theme) emit(DarkThemeState());

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        systemNavigationBarColor: state.backgroundColor,
        statusBarColor:
            state.backgroundColor, // Replace with your desired color
        statusBarIconBrightness: theme ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            theme ? Brightness.dark : Brightness.light,
      ));

      try {} catch (error) {
        // rethrow;
      }
    });

    on<LoadThemeEvent>((event, emit) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? theme = prefs.getBool('theme');
        if (theme == null) {
          await prefs.setBool('theme', true);
          theme = true;
        }
        if (theme) emit(LightThemeState());
        if (!theme) emit(DarkThemeState());

        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarDividerColor: null,
          systemNavigationBarColor: state.backgroundColor,
          statusBarColor:
              state.backgroundColor, // Replace with your desired color
          statusBarIconBrightness: theme ? Brightness.dark : Brightness.light,
          systemNavigationBarIconBrightness:
              theme ? Brightness.dark : Brightness.light,
        ));
      } catch (error) {
        // rethrow;
      }
    });
  }
}
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wheatwise/features/theme/bloc/theme_event.dart';
// import 'package:wheatwise/features/theme/bloc/theme_state.dart';

// class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
//   ThemeBloc() : super(InitialThemeState()) {
//     on<ChangeThemeEvent>((event, emit) async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       bool? theme = prefs.getBool('theme');
//       if (theme == null) {
//         await prefs.setBool('theme', true);
//         theme = true;
//       }

//       await prefs.setBool('theme', !theme);
//       theme = !theme;

//       print(theme);

//       if (theme) emit(LightThemeState());
//       if (!theme) emit(DarkThemeState());

//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         systemNavigationBarDividerColor: null,
//         systemNavigationBarColor: state.whiteColor,
//         statusBarColor: state.whiteColor, // Replace with your desired color
//         statusBarIconBrightness: theme ? Brightness.dark : Brightness.light,
//         systemNavigationBarIconBrightness:
//             theme ? Brightness.dark : Brightness.light,
//       ));

//       try {} catch (error) {
//         // rethrow;
//       }
//     });

//     on<LoadThemeEvent>((event, emit) async {
//       try {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         bool? theme = prefs.getBool('theme');
//         if (theme == null) {
//           await prefs.setBool('theme', true);
//           theme = true;
//         }
//         if (theme) emit(LightThemeState());
//         if (!theme) emit(DarkThemeState());

//         SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//           systemNavigationBarDividerColor: null,
//           systemNavigationBarColor: state.whiteColor,
//           statusBarColor: state.whiteColor, // Replace with your desired color
//           statusBarIconBrightness: theme ? Brightness.dark : Brightness.light,
//           systemNavigationBarIconBrightness:
//               theme ? Brightness.dark : Brightness.light,
//         ));
//       } catch (error) {
//         // rethrow;
//       }
//     });
//   }
// }
