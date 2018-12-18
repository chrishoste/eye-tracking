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
		static let screenSize = CGSize(width: 0.0623908297, height: 0.135096943231532)
		static let frameSize = CGSize(width: 375, height: 812)
	}

	struct Ranges {
		static let widthRange: ClosedRange<CGFloat> = (0...Device.frameSize.width)
		static let heightRange: ClosedRange<CGFloat> = (0...Device.frameSize.height)
	}

	struct Colors {
		static let crosshairColor: UIColor = .white
	}
}
