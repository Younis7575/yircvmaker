import 'package:flutter/foundation.dart';

class AdHelper {

  static String get bannerAdUnitId {
    if (kDebugMode) {
      return "ca-app-pub-3940256099942544/6300978111"; // TEST
    } else {
      return "ca-app-pub-5609093810718993/1643791401"; // YOUR REAL BANNER
    }
  }

  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return "ca-app-pub-3940256099942544/1033173712"; // TEST
    } else {
      return "ca-app-pub-5609093810718993/9256464218"; // YOUR REAL INTERSTITIAL
    }
  }

  static String get rewardedAdUnitId {
    if (kDebugMode) {
      return "ca-app-pub-3940256099942544/5224354917"; // TEST
    } else {
      return "ca-app-pub-5609093810718993/7340747319"; // YOUR REAL REWARD
    }
  }

  static String get appOpenAdUnitId {
    if (kDebugMode) {
      return "ca-app-pub-3940256099942544/3419835294"; // TEST
    } else {
      return "ca-app-pub-5609093810718993/7247471872"; // YOUR REAL APP OPEN
    }
  }
}
