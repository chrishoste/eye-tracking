//
//  UIButtonExtension.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

	func setBorder(borderWidth: CGFloat, borderColor: CGColor) {
		self.layer.borderWidth = borderWidth
		self.layer.borderColor = borderColor
		self.layer.cornerRadius = 5
	}
}
