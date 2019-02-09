//
//  Pointer.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 18.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class Pointer {

	private var point: CGPoint!
	private var points: [CGPoint] = []

	init() {
		self.point = .init(x: 0, y: 0)
	}

	func setNewPoint(_ point: CGPoint) {
		points.append(point)
		points = points.suffix(50).map {$0}
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.1, animations: {
				if self.points.count > 0 {
					self.setPoint(to: self.points.average())
				}
			})
		}
	}

	private func setPoint(to: CGPoint) {
		self.point = to
		NotificationCenter.default.post(name: Constants.NotificationNames.didUpdatePoint, object: to)
	}

	func getPointer() -> CGPoint {
		return self.point
	}

	func resetPoints() {
		points = []
	}
}
