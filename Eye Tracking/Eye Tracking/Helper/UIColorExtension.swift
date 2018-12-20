//
//  UIColorExtension.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 19.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
	convenience init(hexString: String, alpha: CGFloat = 1.0) {
		let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		let scanner = Scanner(string: hexString)
		if hexString.hasPrefix("#") {
			scanner.scanLocation = 1
		}
		var color: UInt32 = 0
		scanner.scanHexInt32(&color)
		let mask = 0x000000FF
		let redValue = Int(color >> 16) & mask
		let greenValue = Int(color >> 8) & mask
		let blueValue = Int(color) & mask
		let red   = CGFloat(redValue) / 255.0
		let green = CGFloat(greenValue) / 255.0
		let blue  = CGFloat(blueValue) / 255.0
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}
