import '../models/service_model.dart';

class MockSpaService {
  Future<List<ServiceModel>> getServices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const ServiceModel(
        id: '1',
        name: 'Massage relaxant',
        description:
            'Un massage complet du corps conçu pour relâcher les tensions musculaires, améliorer la circulation et favoriser une relaxation profonde. Idéal pour évacuer le stress du quotidien.',
        durationMinutes: 60,
        price: 220,
      ),
      const ServiceModel(
        id: '2',
        name: 'Soin du visage',
        description:
            'Un soin purifiant et hydratant adapté à votre type de peau. Comprend un nettoyage en profondeur, une exfoliation douce, un masque nourrissant et un massage facial relaxant.',
        durationMinutes: 45,
        price: 55,
      ),
      const ServiceModel(
        id: '3',
        name: 'Hammam',
        description:
            'Une expérience traditionnelle de sudation dans un bain de vapeur chaud. Aide à éliminer les toxines, nettoyer la peau en profondeur et détendre les muscles. Gommage inclus.',
        durationMinutes: 30,
        price: 280,
      ),
      const ServiceModel(
        id: '4',
        name: 'Manucure',
        description:
            'Soin complet des mains et des ongles. Comprend le limage, le soin des cuticules, un modelage hydratant et la pose de vernis classique de votre choix.',
        durationMinutes: 45,
        price: 40,
      ),
    ];
  }
}
