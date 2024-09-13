import 'package:get/get.dart';
import 'package:pandu_nyawa/screens/first_aid_page/view/first_aid_page.dart';
import 'package:pandu_nyawa/screens/home_page/Controller/home_controller.dart';
import 'package:pandu_nyawa/screens/home_page/View/home_page.dart';
import 'package:pandu_nyawa/screens/home_page/Binding/home_binding.dart';
import 'package:pandu_nyawa/screens/navigation_page/view/navigator_view.dart';

import '../screens/first_aid_page/binding/first_aid_binding.dart';
import '../screens/navigation_page/bindings/navigator_binding.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Route.BOTTOMNAVBAR;

  static final routes = [
    GetPage(
        name: Path.BOTTOMNAVBAR,
        page: () => BottomNavbar(),
        bindings: [
          NavigatorBinding(),
          HomeBinding(),
          FirstAidBinding()
        ],
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
      name: Path.HOMEVIEW_PAGE,
      page: () => HomePage(),
      binding: HomeBinding(),  // Bind HomeController here
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Path.FIRSTAID_PAGE,
      page: () => FirstAidPage(),
      binding: FirstAidBinding(),  // Bind HomeController here
      transition: Transition.noTransition,
    ),
    // other routes
  ];
}
