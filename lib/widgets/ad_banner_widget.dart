import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/ad_config.dart';

class AdBannerWidget extends StatefulWidget {
  final AdSize adSize;
  
  const AdBannerWidget({
    super.key,
    this.adSize = AdSize.banner,
  });

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdConfig.bannerAdUnitId,
      size: widget.adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
        onAdOpened: (ad) {
          debugPrint('BannerAd opened');
        },
        onAdClosed: (ad) {
          debugPrint('BannerAd closed');
        },
      ),
    );

    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAdLoaded || _bannerAd == null) {
      return Container(
        height: widget.adSize.height.toDouble(),
        color: Colors.grey[100],
        child: Center(
          child: Text(
            'Cargando anuncio...',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

class InterstitialAdManager {
  static InterstitialAd? _interstitialAd;
  static bool _isInterstitialAdReady = false;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdConfig.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
          
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (_isInterstitialAdReady && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          debugPrint('InterstitialAd showed fullscreen content');
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          debugPrint('InterstitialAd dismissed fullscreen content');
          ad.dispose();
          _isInterstitialAdReady = false;
          // Cargar el siguiente anuncio
          loadInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint('InterstitialAd failed to show fullscreen content: $error');
          ad.dispose();
          _isInterstitialAdReady = false;
          loadInterstitialAd();
        },
      );

      _interstitialAd!.show();
    } else {
      debugPrint('InterstitialAd is not ready yet');
      // Cargar anuncio si no está listo
      loadInterstitialAd();
    }
  }

  static bool get isReady => _isInterstitialAdReady;

  static void dispose() {
    _interstitialAd?.dispose();
    _isInterstitialAdReady = false;
  }
} 