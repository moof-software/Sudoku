//
//  AdBannerView.swift
//  Sudoku
//
//  Created by Hungu Lim on 8/30/25.
//

import GoogleMobileAds
import SwiftUI

struct AdBannerView: View {
    var body: some View {
        // Request an anchored adaptive banner with a width of 375.
        let adSize = currentOrientationAnchoredAdaptiveBanner(width: 375)
        BannerViewContainer(adSize)
            .frame(width: adSize.size.width, height: adSize.size.height)
        // [START_EXCLUDE silent]
    }
}

#Preview {
    AdBannerView()
}

// [START create_banner_view]
private struct BannerViewContainer: UIViewRepresentable {
    typealias UIViewType = BannerView
    let adSize: AdSize

    init(_ adSize: AdSize) {
        self.adSize = adSize
    }

    func makeUIView(context: Context) -> BannerView {
        let banner = BannerView(adSize: adSize)
        // [START load_ad]
        //banner.adUnitID = "ca-app-pub-6401616822181896/9180933902"
        // Test adUnitID
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.load(Request())
        // [END load_ad]
        // [START set_delegate]
        banner.delegate = context.coordinator
        // [END set_delegate]
        return banner
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}

    func makeCoordinator() -> BannerCoordinator {
        return BannerCoordinator(self)
    }
    // [END create_banner_view]

    class BannerCoordinator: NSObject, BannerViewDelegate {

        let parent: BannerViewContainer

        init(_ parent: BannerViewContainer) {
            self.parent = parent
        }

        // MARK: - GADBannerViewDelegate methods

        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("DID RECEIVE AD.")
        }

        func bannerView(
            _ bannerView: BannerView,
            didFailToReceiveAdWithError error: Error
        ) {
            print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
        }
    }
}
