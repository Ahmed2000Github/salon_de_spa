import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'services_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // A simple illustration using a container and icon representing a spa
            Container(
              width: 200,
              height: 200,
              child: Center(
                child: Image.asset(
                  'assets/images/spa.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 48),
            Text(
              'BOLD BEAUTY\nLOUNGE',
              textAlign: TextAlign.center,
              style: AppStyles.titleLarge.copyWith(height: 1.2),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'L\'élégance et le bien-être à portée de main. Découvrez nos services exclusifs.',
                textAlign: TextAlign.center,
                style: AppStyles.bodyMedium,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ServicesListScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Voir les services',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
