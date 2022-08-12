

import '../../../presentation/home_board/home_board_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String homeBoardScreen = '/homeBoardScreen';
}

final routes = {
  Routes.initialRoute: (context) => HomeBoardScreen(),
};
