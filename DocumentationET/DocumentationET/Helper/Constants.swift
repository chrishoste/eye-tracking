//
//  Constants.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

	struct Device {
		static let screenSize = CGSize(width: 0.062, height: 0.130)
		static let frameSize = CGSize(width: 375, height: 812)
	}

	struct Ranges {
		static let widthRange: ClosedRange<CGFloat> = (0...Device.frameSize.width)
		static let heightRange: ClosedRange<CGFloat> = (0...Device.frameSize.height)
	}

	struct Colors {
		static let crosshairColor: UIColor = .white
		static let tabbarBackground: UIColor = .init(hexString: "ecf0f1")
	}

	struct NotificationNames {
		static let didUpdatePoint = Notification.Name(rawValue: "didUpdatePoint")
		static let trackableButton = Notification.Name(rawValue: "trackableButton")
		static let selectTrackableButton = Notification.Name(rawValue: "selectTrackableButton")
	}

	struct SlideMenu {
		static let menuWidth: CGFloat = 270
	}
}
