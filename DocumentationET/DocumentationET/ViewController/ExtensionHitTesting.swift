//
//  ExtensionHitTesting.swift
//  DocumentationET
//
//  Created by Christophe Hoste on 07.02.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

extension AddingSCNodes {
	func hitTest() {

		let halfScreenHeight = Constants.Device.screenSize.height / 2
	 	let halfScreenWidth = Constants.Device.screenSize.width / 2

		var leftEyeLocation = CGPoint()
		var rightEyeLocation = CGPoint()

		let leftEyeResult =
				nodeInFrontOfScreen.hitTestWithSegment(from: endPointLeftEye.worldPosition,
													   to: leftEyeNode.worldPosition)

		let rightEyeResult =
				nodeInFrontOfScreen.hitTestWithSegment(from: endPointRightEye.worldPosition,
													   to: rightEyeNode.worldPosition)

		if leftEyeResult.count > 0 || rightEyeResult.count > 0 {

			guard let leftResult = leftEyeResult.first,
				  let rightResult = rightEyeResult.first else {
				return
			}

			leftEyeLocation.x = CGFloat(leftResult.localCoordinates.x) / halfScreenWidth *
				Constants.Device.frameSize.width
			leftEyeLocation.y = CGFloat(leftResult.localCoordinates.y) / halfScreenHeight *
				Constants.Device.frameSize.height

			rightEyeLocation.x = CGFloat(rightResult.localCoordinates.x) / halfScreenWidth *
				Constants.Device.frameSize.width
			rightEyeLocation.y = CGFloat(rightResult.localCoordinates.y) / halfScreenHeight *
				Constants.Device.frameSize.height

			let point: CGPoint = {
				var point = CGPoint()
				let pointX = ((leftEyeLocation.x + rightEyeLocation.x) / 2) + 150
				let pointY = (-(leftEyeLocation.y + rightEyeLocation.y) / 2)

				point.x = pointX.clamped(to: Constants.Ranges.widthRange)
				point.y = pointY.clamped(to: Constants.Ranges.heightRange)
				return point
			}()

			pointer.setNewPoint(point)
		}
	}
}
