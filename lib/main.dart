import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostel_management/api_services/api_provider.dart';
import 'package:hostel_management/api_services/api_utils.dart';
import 'package:hostel_management/features/auth/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // final isUserLoggedIn = await checkUserLoginStatus();

  runApp(
    const MyApp(
        // isUserLoggedIn: isUserLoggedIn,
        ),
  );
}

// Future<bool> checkUserLoginStatus() async {
//   final prefs = await SharedPreferences.getInstance();
//   final authToken = prefs.getString(ApiUtils.authTokenKey);
//   return authToken != null;
// }

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;
  const MyApp({super.key, this.isUserLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApiProvider(
            baseUrl: ApiUrls.baseUrl,
            httpClient: http.Client(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        // Screen Responsiveness
        useInheritedMediaQuery: true,
        designSize: const Size(375, 825),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final ThemeData theme = ThemeData();

          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyApp',
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
