import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  bool _isShowingAd = false;
  DateTime? _loadTime;

  /// 🔴 REAL App Open ID (Play Store Only)
  static const String _realAdUnitId =
      'ca-app-pub-5609093810718993/7247471872';

  /// 🟢 TEST App Open ID (Debug Only)
  static String get _testAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/3419835294';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5662855259';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  String get _adUnitId =>
      kReleaseMode ? _realAdUnitId : _testAdUnitId;

  /// Load App Open Ad
  void loadAd() {
    AppOpenAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _loadTime = DateTime.now();
          debugPrint(
              '✅ App Open Ad Loaded (${kReleaseMode ? "REAL" : "TEST"})');
        },
        onAdFailedToLoad: (error) {
          debugPrint('❌ App Open Ad Failed: $error');
        },
      ),

      // orientation: AppOpenAd.orientationPortrait,
    );
  }

  /// Show App Open Ad
  void showAdIfAvailable() {
    if (_appOpenAd == null) {
      debugPrint('ℹ App Open Ad not ready');
      loadAd();
      return;
    }

    if (_isShowingAd) return;

    if (_isAdExpired()) {
      debugPrint('ℹ App Open Ad expired, reloading');
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback =
        FullScreenContentCallback(
          onAdShowedFullScreenContent: (ad) {
            _isShowingAd = true;
            debugPrint('▶ App Open Ad showing');
          },
          onAdDismissedFullScreenContent: (ad) {
            debugPrint('⏹ App Open Ad dismissed');
            _isShowingAd = false;
            ad.dispose();
            _appOpenAd = null;
            loadAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            debugPrint('❌ Failed to show App Open Ad: $error');
            _isShowingAd = false;
            ad.dispose();
            _appOpenAd = null;
            loadAd();
          },
        );

    _appOpenAd!.show();
  }

  bool _isAdExpired() {
    if (_loadTime == null) return true;
    return DateTime.now().difference(_loadTime!).inHours >= 4;
  }
}
