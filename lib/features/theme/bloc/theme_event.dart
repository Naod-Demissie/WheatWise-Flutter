abstract class ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  ChangeThemeEvent();
}

class LoadThemeEvent extends ThemeEvent {
  LoadThemeEvent();
}
