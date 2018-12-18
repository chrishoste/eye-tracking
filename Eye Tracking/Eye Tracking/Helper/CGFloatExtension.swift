//
//  CGFloatExtension.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {

	func clamped(to: ClosedRange<CGFloat>) -> CGFloat {
		return to.lowerBound > self ? to.lowerBound
			: to.upperBound < self ? to.upperBound
			: self
	}
}
