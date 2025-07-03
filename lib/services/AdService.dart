import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  static final adUnitId = 'ca-app-pub-3940256099942544/5224354917';

  static void loadAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          print('ad loaded');
          _rewardedAd=ad;
          showAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('ad failed to load');
        },
      ),
    );


  }
  static RewardedAd? _rewardedAd;
  static void showAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('reward gained: ${reward.type}');
        },
      );
      _rewardedAd = null;
    } else {
      print('Ad not loaded yet.');
    }
  }
}
