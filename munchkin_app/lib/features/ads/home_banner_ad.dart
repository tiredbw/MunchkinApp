import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../l10n/app_localizations.dart';

class HomeBannerAd extends StatefulWidget {
  const HomeBannerAd({super.key});

  @override
  State<HomeBannerAd> createState() => _HomeBannerAdState();
}

class _HomeBannerAdState extends State<HomeBannerAd> {
  static const _productionAndroidBannerId =
      'ca-app-pub-2170280504838164/1563476607';
  static const _testAndroidBannerId = 'ca-app-pub-3940256099942544/9214589741';

  BannerAd? _bannerAd;
  bool _requestStarted = false;
  bool _privacyOptionsRequired = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_requestStarted || !Platform.isAndroid) return;
    _requestStarted = true;
    final width = MediaQuery.sizeOf(context).width.truncate();
    _requestConsentAndLoadAd(width);
  }

  Future<void> _requestConsentAndLoadAd(int width) async {
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((_) {});
        await _updatePrivacyOptionsRequirement();
        await _loadAdIfAllowed(width);
      },
      (_) async {
        await _updatePrivacyOptionsRequirement();
        await _loadAdIfAllowed(width);
      },
    );
  }

  Future<void> _updatePrivacyOptionsRequirement() async {
    final status = await ConsentInformation.instance
        .getPrivacyOptionsRequirementStatus();
    if (!mounted) return;
    setState(() {
      _privacyOptionsRequired =
          status == PrivacyOptionsRequirementStatus.required;
    });
  }

  Future<void> _loadAdIfAllowed(int width) async {
    if (!await ConsentInformation.instance.canRequestAds()) return;
    await MobileAds.instance.initialize();
    final size = await AdSize.getLargeAnchoredAdaptiveBannerAdSize(width);
    if (!mounted || size == null) return;

    final ad = BannerAd(
      adUnitId: kReleaseMode
          ? _productionAndroidBannerId
          : _testAndroidBannerId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (loadedAd) {
          if (!mounted) {
            loadedAd.dispose();
            return;
          }
          setState(() => _bannerAd = loadedAd as BannerAd);
        },
        onAdFailedToLoad: (failedAd, _) => failedAd.dispose(),
      ),
    );
    await ad.load();
  }

  Future<void> _showPrivacyOptions() async {
    await ConsentForm.showPrivacyOptionsForm((_) {});
    if (!mounted) return;
    final currentAd = _bannerAd;
    if (currentAd != null) unawaited(currentAd.dispose());
    setState(() => _bannerAd = null);
    await _loadAdIfAllowed(MediaQuery.sizeOf(context).width.truncate());
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Platform.isAndroid) return const SizedBox.shrink();
    final ad = _bannerAd;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_privacyOptionsRequired)
          TextButton(
            onPressed: _showPrivacyOptions,
            child: Text(AppLocalizations.of(context).adPrivacyOptions),
          ),
        if (ad != null)
          SizedBox(
            width: ad.size.width.toDouble(),
            height: ad.size.height.toDouble(),
            child: AdWidget(ad: ad),
          ),
      ],
    );
  }
}
