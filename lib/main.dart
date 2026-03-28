import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/scan_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/onboarding_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/result_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const CropCareApp());
}

class CropCareApp extends StatelessWidget {
  const CropCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => ScanProvider()..initialize()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'CropCare AI',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: Locale(settings.locale),
            supportedLocales: const [
              Locale('en'),
              Locale('sw'),
            ],
            home: const SplashScreen(),
            routes: {
              '/onboarding': (context) => const OnboardingScreen(),
              '/home': (context) => const HomeScreen(),
              '/result': (context) => const ResultScreen(),
            },
          );
        },
      ),
    );
  }
}
