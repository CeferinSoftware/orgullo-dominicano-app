// Archivo de configuración de AdMob temporalmente deshabilitado
// Descomenta este código cuando quieras activar los anuncios

import 'dart:io';

class AdConfig {
  // IDs de prueba - Reemplazar con IDs reales cuando se configure AdMob
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test Banner Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // Test Banner iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test Interstitial Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // Test Interstitial iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Test Rewarded Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // Test Rewarded iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  // Configuración de cuándo mostrar anuncios
  static const int pagesViewedBeforeAd = 3;
  static const int minutesBetweenInterstitialAds = 2;
  
  // Configuración para testing
  static const bool useTestAds = true;
  static const List<String> testDeviceIds = [
    // Agregar IDs de dispositivos de prueba aquí
  ];
}

class AdManager {
  static int _pagesViewed = 0;
  static DateTime? _lastInterstitialShown;

  static bool shouldShowInterstitialAd() {
    _pagesViewed++;
    
    if (_pagesViewed >= AdConfig.pagesViewedBeforeAd) {
      if (_lastInterstitialShown == null || 
          DateTime.now().difference(_lastInterstitialShown!).inMinutes >= 
          AdConfig.minutesBetweenInterstitialAds) {
        _pagesViewed = 0;
        _lastInterstitialShown = DateTime.now();
        return true;
      }
    }
    
    return false;
  }

  static void resetPageCount() {
    _pagesViewed = 0;
  }
}

/*
class AdConfig {
  // IDs de prueba - Reemplazar con IDs reales cuando se configure AdMob
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111'; // Test Banner Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716'; // Test Banner iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712'; // Test Interstitial Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/4411468910'; // Test Interstitial iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/5224354917'; // Test Rewarded Android
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/1712485313'; // Test Rewarded iOS
    } else {
      throw UnsupportedError('Plataforma no soportada para anuncios');
    }
  }

  // Configuración de cuándo mostrar anuncios
  static const int pagesViewedBeforeAd = 3;
  static const int minutesBetweenInterstitialAds = 2;
  
  // Configuración para testing
  static const bool useTestAds = true;
  static const List<String> testDeviceIds = [
    // Agregar IDs de dispositivos de prueba aquí
  ];
}

class AdManager {
  static int _pagesViewed = 0;
  static DateTime? _lastInterstitialShown;

  static bool shouldShowInterstitialAd() {
    _pagesViewed++;
    
    if (_pagesViewed >= AdConfig.pagesViewedBeforeAd) {
      if (_lastInterstitialShown == null || 
          DateTime.now().difference(_lastInterstitialShown!).inMinutes >= 
          AdConfig.minutesBetweenInterstitialAds) {
        _pagesViewed = 0;
        _lastInterstitialShown = DateTime.now();
        return true;
      }
    }
    
    return false;
  }

  static void resetPageCount() {
    _pagesViewed = 0;
  }
}
*/ 