import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'controllers/portfolio_controller.dart';
import 'views/home_screen.dart';
import 'views/edit_profile_screen.dart';
import 'views/skills_screen.dart';
import 'views/projects_screen.dart';
import 'views/experience_screen.dart';
import 'views/preview_screen.dart';
import 'ads/app_open_ad_manager.dart';

final AppOpenAdManager _appOpenAdManager = AppOpenAdManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize Google Mobile Ads
  await MobileAds.instance.initialize();

  // Initialize GetX Controller
  Get.put(PortfolioController());

  runApp(const PortfolioMakerApp());
}

class PortfolioMakerApp extends StatefulWidget {
  const PortfolioMakerApp({super.key});

  @override
  State<PortfolioMakerApp> createState() => _PortfolioMakerAppState();
}

class _PortfolioMakerAppState extends State<PortfolioMakerApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Load App Open Ad
    _appOpenAdManager.loadAd();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Show ad when app comes to foreground
      _appOpenAdManager.showAdIfAvailable();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.blue,
          secondary: Colors.cyan,
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF121212),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.white,
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomeScreen()),
        GetPage(name: '/edit-profile', page: () => const EditProfileScreen()),
        GetPage(name: '/skills', page: () => const SkillsScreen()),
        GetPage(name: '/projects', page: () => const ProjectsScreen()),
        GetPage(name: '/add-project', page: () => const AddProjectScreen()),
        GetPage(name: '/experience', page: () => const ExperienceScreen()),
        GetPage(
            name: '/add-experience',
            page: () => const AddExperienceScreen()),
        GetPage(name: '/preview', page: () => const PreviewScreen()),
      ],
    );
  }
}
