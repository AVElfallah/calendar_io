import 'package:calendar_io/app/extensions/context_extensions.dart';
import 'package:calendar_io/app/locator.dart';
import 'package:calendar_io/core/utils/colors_helper.dart';
import 'package:calendar_io/app/routes/routes_manager.dart';
import 'package:calendar_io/app/routes/routes_names.dart';
import 'package:calendar_io/data/data_sources/storage_data_source.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // init storage data source
  StorageDataSource.i;
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    textScaleFactor(double fontScale) =>
        MediaQuery.of(context).textScaler.scale(fontScale).toDouble();
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF735BF2),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, context.height * .06),
            textStyle: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.roboto(
              fontSize: textScaleFactor(18),
              fontWeight: FontWeight.w400,
              color: ColorsHelper.appGray),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFFEDF1F7),
              width: 13,
            ),
          ),
        ),
        textTheme: TextTheme(
            bodyLarge: GoogleFonts.roboto(
              fontSize: textScaleFactor(38),
              fontWeight: FontWeight.bold,
              color: ColorsHelper.appMainColorPurple,
            ),
            bodyMedium: GoogleFonts.roboto(
              fontSize: textScaleFactor(18),
              fontWeight: FontWeight.w400,
            ),
            bodySmall: GoogleFonts.roboto(
              fontSize: textScaleFactor(12),
              fontWeight: FontWeight.w400,
            ),
            headlineSmall: GoogleFonts.roboto(
              fontSize: textScaleFactor(14),
              color: ColorsHelper.appGray,
              fontWeight: FontWeight.w400,
            ),
            headlineMedium: GoogleFonts.roboto(
              fontSize: textScaleFactor(16),
              fontWeight: FontWeight.w600,
              color: ColorsHelper.appGray,
            ),
            headlineLarge: GoogleFonts.roboto(
              fontSize: textScaleFactor(20),
              fontWeight: FontWeight.w600,
              color: ColorsHelper.appMainColorPurple,
            )),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.onGenerateRoute,
      title: 'Calendar.IO',
      initialRoute: RoutesNames.splash,
    );
  }
}
