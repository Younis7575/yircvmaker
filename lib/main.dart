// import 'package:cvmaker/views/dashboard/dashboard_screen.dart';
// import 'package:cvmaker/views/generate_cv/generate_cv_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'controllers/portfolio_controller.dart';
// import 'views/cv_sections/edit_profile_screen.dart';
// import 'views/cv_sections/skills_screen.dart';
// import 'views/cv_sections/projects_screen.dart';
// import 'views/cv_sections/experience_screen.dart';
// import 'views/cv_sections/education_screen.dart';
// import 'views/cv_sections/achievements_screen.dart';
// import 'views/cv_sections/hobbies_screen.dart';
// import 'views/templates/preview_screen.dart';
// import 'views/templates/template_selection_screen.dart'; 
// import 'views/downlaod/my_downloads_screen.dart';
// import 'widgets/download_progress_widget.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await GetStorage.init();
//   Get.put(PortfolioController());

//   runApp(const PortfolioMakerApp());
// }

// class PortfolioMakerApp extends StatelessWidget {
//   const PortfolioMakerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Portfolio Maker',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.light,
//         primaryColor: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.blue,
//           foregroundColor: Colors.white,
//           elevation: 0,
//         ),
//         colorScheme: const ColorScheme.light(
//           primary: Colors.blue,
//           secondary: Colors.cyan,
//           surface: Colors.white,
//           background: Colors.white,
//           onPrimary: Colors.white,
//           onSecondary: Colors.black,
//           onSurface: Colors.black,
//           onBackground: Colors.black,
//           error: Colors.red,
//           onError: Colors.white,
//         ),
//         textTheme: TextTheme(
//           // Headings → Oswald
//           displayLarge: GoogleFonts.oswald(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
//           displayMedium: GoogleFonts.oswald(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
//           displaySmall: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
//           headlineMedium: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           headlineSmall: GoogleFonts.oswald(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//           titleLarge: GoogleFonts.oswald(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//           // Subtitles / body → Montserrat
//           titleMedium: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
//           titleSmall: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87),
//           bodyLarge: GoogleFonts.montserrat(fontSize: 16, color: Colors.black87),
//           bodyMedium: GoogleFonts.montserrat(fontSize: 14, color: Colors.black87),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.grey[200],
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.blue, width: 2),
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//         outlinedButtonTheme: OutlinedButtonThemeData(
//           style: OutlinedButton.styleFrom(
//             foregroundColor: Colors.blue,
//             side: const BorderSide(color: Colors.blue),
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//       ),
//       initialRoute: '/dashboard',
//       getPages: [
//         GetPage(name: '/dashboard', page: () => DashboardScreen()), 
//         GetPage(name: '/downloads', page: () => MyDownloadsScreen()),
//         GetPage(name: '/edit-profile', page: () => const EditProfileScreen()),
//         GetPage(name: '/skills', page: () => const SkillsScreen()),
//         GetPage(name: '/projects', page: () => const ProjectsScreen()),
//         GetPage(name: '/add-project', page: () => const AddProjectScreen()),
//         GetPage(name: '/experience', page: () => const ExperienceScreen()),
//         GetPage(name: '/add-experience', page: () => const AddExperienceScreen()),
//         GetPage(name: '/education', page: () => const EducationScreen()),
//         GetPage(name: '/add-education', page: () => const AddEducationScreen()),
//         GetPage(name: '/achievements', page: () => const AchievementsScreen()),
//         GetPage(name: '/add-achievement', page: () => const AddAchievementScreen()),
//         GetPage(name: '/hobbies', page: () => const HobbiesScreen()),
//         GetPage(name: '/preview', page: () => const PreviewScreen()),
//         GetPage(
//           name: '/select-template',
//           page: () => const TemplateSelectionScreen(isForShare: false),
//         ),
//         GetPage(
//           name: '/select-template-share',
//           page: () => const TemplateSelectionScreen(isForShare: true),
//         ),
//       ],
//       builder: (context, child) {
//         return Stack(
//           children: [
//             child!,
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: DownloadProgressWidget(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }



import 'package:cvmaker/views/dashboard/dashboard_screen.dart';
import 'package:cvmaker/views/generate_cv/generate_cv_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:appwrite/appwrite.dart';

import 'controllers/portfolio_controller.dart';

import 'views/cv_sections/edit_profile_screen.dart';
import 'views/cv_sections/skills_screen.dart';
import 'views/cv_sections/projects_screen.dart';
import 'views/cv_sections/experience_screen.dart';
import 'views/cv_sections/education_screen.dart';
import 'views/cv_sections/achievements_screen.dart';
import 'views/cv_sections/hobbies_screen.dart';

import 'views/templates/preview_screen.dart';
import 'views/templates/template_selection_screen.dart';

import 'views/downlaod/my_downloads_screen.dart';

import 'widgets/download_progress_widget.dart';

/// ================= APPWRITE CONFIG =================

class AppwriteConfig {
  static Client client = Client()
      .setEndpoint('https://fra.cloud.appwrite.io/v1')
      .setProject('699ca3590014509581d2')
      .setSelfSigned(status: true);

  static Account account = Account(client);

  static Databases databases = Databases(client);

  static Storage storage = Storage(client);
}

/// ================= MAIN =================

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Local Storage
  await GetStorage.init();

  /// GetX Controller
  Get.put(PortfolioController());

  /// Appwrite Initialize
  AppwriteConfig.client;

  runApp(const PortfolioMakerApp());
}

/// ================= APP =================

class PortfolioMakerApp extends StatelessWidget {
  const PortfolioMakerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio Maker',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.cyan,
          surface: Colors.white,
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          error: Colors.red,
          onError: Colors.white,
        ),

        /// Fonts

        textTheme: TextTheme(

          /// Headings → Oswald

          displayLarge: GoogleFonts.oswald(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          displayMedium: GoogleFonts.oswald(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          displaySmall: GoogleFonts.oswald(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          headlineMedium: GoogleFonts.oswald(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          headlineSmall: GoogleFonts.oswald(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          titleLarge: GoogleFonts.oswald(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black),

          /// Body → Montserrat

          titleMedium: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87),

          titleSmall: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black87),

          bodyLarge: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.black87),

          bodyMedium: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.black87),
        ),

        /// TextFields

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],

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
            borderSide:
            const BorderSide(color: Colors.blue, width: 2),
          ),
        ),

        /// Buttons

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,

            side: const BorderSide(color: Colors.blue),

            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      /// Routes

      initialRoute: '/dashboard',

      getPages: [

        GetPage(
            name: '/dashboard',
            page: () => DashboardScreen()),

        GetPage(
            name: '/downloads',
            page: () => MyDownloadsScreen()),

        GetPage(
            name: '/edit-profile',
            page: () => const EditProfileScreen()),

        GetPage(
            name: '/skills',
            page: () => const SkillsScreen()),

        GetPage(
            name: '/projects',
            page: () => const ProjectsScreen()),
            

        GetPage(
            name: '/experience',
            page: () => const ExperienceScreen()),

        GetPage(
            name: '/education',
            page: () => const EducationScreen()),

        GetPage(
            name: '/achievements',
            page: () => const AchievementsScreen()),

        GetPage(
            name: '/hobbies',
            page: () => const HobbiesScreen()),

        GetPage(
            name: '/preview',
            page: () => const PreviewScreen()),

        GetPage(
          name: '/select-template',
          page: () =>
          const TemplateSelectionScreen(
              isForShare: false),
        ),

        GetPage(
          name: '/select-template-share',
          page: () =>
          const TemplateSelectionScreen(
              isForShare: true),
        ),

      ],

      /// Download Widget Overlay

      builder: (context, child) {
        return Stack(
          children: [

            child!,

          
          ],
        );
      },
    );
  }
}