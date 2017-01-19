//
//  AdManager.swift
//  SmoothiesAndMilkshake
//
//  Created by Chris Tseng on 19/01/2017.
//  Copyright © 2017 Tseng Yu Siang. All rights reserved.
//

import GoogleMobileAds

class AdManager: NSObject, GADBannerViewDelegate, GADInterstitialDelegate {
    
    let interstitial  = GADInterstitial(adUnitID: "ca-app-pub-1738448963642929/6136039892")
    lazy var adBannerView: GADBannerView = {
        let adBannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        adBannerView.adUnitID = "ca-app-pub-1738448963642929/2587570291"
        adBannerView.delegate = self
        
        return adBannerView
    }()
    lazy var request: GADRequest = {
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID, "9afe09c4a2fff4311e9153526ea37597", "eb9e576b97d267b3e6589a0a6f507d15"]
        
        return request
    }()
    
    override init() {
        super.init()
        
        loadInterstitialAD()
    }
    
    func loadBannerAd(rootViewController: UIViewController) {
        adBannerView.rootViewController = rootViewController
        adBannerView.load(request)
    }
    
    func loadInterstitialAD() {
        interstitial.delegate = self
        interstitial.load(request)
    }
    
    
}

