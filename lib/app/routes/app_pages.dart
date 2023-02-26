import 'package:get/get.dart';
import '../modules/chat_text/bindings/chat_text_binding.dart';
import '../modules/chat_text/views/chat_text_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CHAT_TEXT;

  static final routes = [
    GetPage(
      name: _Paths.CHAT_TEXT,
      page: () => const ChatTextView(),
      binding: ChatTextBinding(),
    ),
  ];
}
