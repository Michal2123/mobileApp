import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter_mobile_app/helper/error_handling.dart';
import 'package:flutter_mobile_app/helper/navigator_rout_observer.dart';
import 'package:flutter_mobile_app/repository/dio_client.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_room_service.dart';
import 'package:flutter_mobile_app/service/messanger_service/messanger_connection_service.dart';
import 'package:flutter_mobile_app/utils/aplication_theme.dart';
import 'package:flutter_mobile_app/utils/color_constant.dart';
import 'package:flutter_mobile_app/utils/enums.dart';
import 'package:flutter_mobile_app/view/login/login_page/login_page.dart';
import 'package:flutter_mobile_app/view/widgets/lifecycle_watcher_widget.dart';
import 'package:flutter_mobile_app/utils/multi_provider_registrator.dart';
import 'helper/url_config_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'view/swipe/swipe_page/swipe_page.dart';
import 'package:kiwi/kiwi.dart';

UrlConfigHelper _urlConfigHelper = UrlConfigHelper();
late Map<String, dynamic> config;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KiwiContainer container = KiwiContainer();
  HttpOverrides.global = MyHttpOverrides();
  config = await _urlConfigHelper.readJson();

  container.registerInstance(const FlutterSecureStorage());
  container.registerSingleton(
    (container) => ExceptionHandler(),
  );
  container.registerInstance(DioClient());
  container.registerInstance(MessangerConnectionService());
  container.registerInstance(NavigatorRoutObserver());

  PlatformDispatcher.instance.onError = (error, stack) {
    container<ExceptionHandler>().fromOtherError(error as Exception);
    return true;
  };
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  runApp(MultiProviderRegistrator(
    child: LifecycleWatcher(
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  final _observer = KiwiContainer().resolve<NavigatorRoutObserver>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [_observer],
      title: 'psiapp',
      theme: AplicationTheme.customTheme().theme,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'login':
            return MaterialPageRoute(builder: (context) => const Login());
          default:
            return MaterialPageRoute(builder: (context) => const MyHomePage());
        }
      },
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(
              backgroundColor: ColorConstant.backgroundScaffoldColor,
              body: Expanded(child: Center(child: error)));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _storage = KiwiContainer().resolve<FlutterSecureStorage>();
  bool? _token;

  @override
  void initState() {
    super.initState();
    storageCheck();
  }

  storageCheck() async {
    await Future.delayed(const Duration(seconds: 2));
    await _storage.containsKey(key: StorageKeys.token.name).then((value) => {
          setState((() {
            _token = value;
          }))
        });
  }

  Stream<dynamic>? _stream() {
    return Stream.value(_token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: _stream(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data) {
            context
                .read<MessangerConnectionService>()
                .openChatConnection()
                .then((value) =>
                    context.read<MessangerRoomService>().joinRooms());

            return Swipe();
          }
          return const Login();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
