import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static BannerAd? bannerAd;
  static InterstitialAd? interstitialAd;
  static RewardedAd? rewardedAd;

  static void initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Banner ad loaded'),
        onAdFailedToLoad: (ad, error) => print('Banner ad failed: $error'),
      ),
    );
    bannerAd!.load();
    return bannerAd!;
  }

  static void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Test ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (error) => print('Interstitial ad failed: $error'),
      ),
    );
  }

  static void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    }
  }

  static void createRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917', // Test ID
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) => print('Rewarded ad failed: $error'),
      ),
    );
  }

  static void showRewardedAd(Function onRewarded) {
    if (rewardedAd != null) {
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          onRewarded();
        },
      );
    }
  }
}