//
//  IllustrationDetailADView.swift
//  mangahack
//
//  Created by Teruki Nakano on 2018/09/06.
//  Copyright © 2018年 echoes Inc. All rights reserved.
//

import UIKit
import FBAudienceNetwork

class IllustrationDetailADView: UIView {

	private enum ADType: String {
		case five
		case facebook
		case adMob
	}

	private static let remoteConfigParamName = "IllustShow_banner_ad"
	private let adTypeStr: String? = MHRemoteConfig.config[remoteConfigParamName].stringValue

	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		configure()
	}

	private func configure() {
		guard let adType = ADType(rawValue: adTypeStr) else { return }

		switch adType {

		case .five:
			FiveAdManager.shared.showCustomLayoutAD(parent: self, slotId: 806120)
		case .facebook:
			FacebookBannerAd.setUp(parent: self, delgete: self)
		case .adMob:
			AdMob.setUp(parent: self)
		}
	}
}

extension IllustrationDetailADView {
	enum FacebookBannerAd {
		static func setUp<T: FBAdViewDelegate>(parent view: UIView, delgete: T) {

			let adWidth: CGFloat = 320

			let fbBannerAd: FBAdView = FBAdView(placementID: "122332681855794_310493016373092",
												adSize: kFBAdSizeHeight90Banner,
												rootViewController: AppDelegate.shared.window?.rootViewController)
			fbBannerAd.frame = view.bounds
			fbBannerAd.frame.size.width = adWidth
			fbBannerAd.frame.origin.x = (UIScreen.main.bounds.width - fbBannerAd.bounds.width) / 2
			view.addSubview(fbBannerAd)

			fbBannerAd.delegate = delgete
			fbBannerAd.loadAd()
		}
	}
}

import GoogleMobileAds

extension IllustrationDetailADView {
	enum AdMob {
		static func setUp(parent view: UIView) {
			let adMob: DFPBannerView = DFPBannerView(adUnitID: .illustDetail, adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 80)))
			view.addSubview(adMob)

			adMob.translatesAutoresizingMaskIntoConstraints = false
			adMob.heightAnchor.constraint(equalToConstant: 80).isActive = true
			adMob.widthAnchor.constraint(equalToConstant: 320).isActive = true
			adMob.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
			adMob.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		}
	}
}


extension IllustrationDetailADView: FBAdViewDelegate {
	func adViewDidLoad(_ adView: FBAdView) {
		debugPrint("Facebook Ad was loaded and ready to be displayed")
	}

	/*
	facebook広告の読み込みに失敗した場合はFIVE広告を表示
	*/
	func adView(_ adView: FBAdView, didFailWithError error: Error) {
		debugPrint("Facebook Ad failed to load error: \(error)")

		for view in self.subviews {
			if view is FBAdView {
				view.removeFromSuperview()
			}
		}

		FiveAdManager.shared.showCustomLayoutAD(parent: self, slotId: 806120)
	}
}
