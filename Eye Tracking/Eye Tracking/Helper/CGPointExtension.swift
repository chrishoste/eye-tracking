//
//  CGPointExtension.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
	func add(point: CGPoint) -> CGPoint {
		return CGPoint(x: self.x + point.x, y: self.y + point.y)
	}

	func divide(by: Int) -> CGPoint {
		let denominator = CGFloat(by)
		return CGPoint(x: self.x / denominator, y: self.y / denominator)
	}

	private func CGPointDistanceSquared(to: CGPoint) -> CGFloat {
		return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
	}

	func distance(to: CGPoint) -> CGFloat {
		return sqrt(self.CGPointDistanceSquared(to: to))
	}
}

extension Collection where Element == CGPoint {
	func average() -> CGPoint {
		let point = self.reduce(CGPoint(x: 0, y: 0)) { (result, point) -> CGPoint in
			result.add(point: point)
		}
		return point.divide(by: self.count)
	}
}
