import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'bloc/spa_bloc.dart';
import 'screens/home_screen.dart';
import 'services/mock_spa_service.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting for French locales used in DateFormat
  await initializeDateFormatting('fr_FR', null);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const BoldBeautyLoungeApp());
}

class BoldBeautyLoungeApp extends StatelessWidget {
  const BoldBeautyLoungeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SpaBloc>(
          create: (context) => SpaBloc(spaService: MockSpaService()),
        ),
      ],
      child: MaterialApp(
        title: 'Bold Beauty Lounge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          fontFamily:
              'Inter', // Defaulting to system font if Inter isn't loaded, could add google_fonts later if needed
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.textMain),
            titleTextStyle: AppStyles.titleMedium,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
