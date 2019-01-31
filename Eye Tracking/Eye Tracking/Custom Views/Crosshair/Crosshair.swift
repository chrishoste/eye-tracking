//
//  Crosshair.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class Crosshair: UIView {

	private let verticalCross: UIView = {
		let view = UIView()
		view.backgroundColor = Constants.Colors.crosshairColor
		return view
	}()

	private let horizontalCross: UIView = {
		let view = UIView()
		view.backgroundColor = Constants.Colors.crosshairColor
		return view
	}()

	init(size: CGSize) {
		super.init(frame: .zero)

		setupView(size)
		setupSubviews()
		setupNotification()
	}

	private func setupView(_ size: CGSize) {
		frame.size = size
		layer.cornerRadius = frame.width / 2
		backgroundColor = UIColor.init(white: 0, alpha: 0.2)
	}

	private func setupSubviews() {
		addSubview(verticalCross)
		addSubview(horizontalCross)

		verticalCross.contraintToCenter()
		verticalCross.constraintToConstants(top: 5, bottom: 5)
		verticalCross.contraintSize(width: frame.width/12)

		horizontalCross.contraintToCenter()
		horizontalCross.constraintToConstants(leading: 5, trailing: 5)
		horizontalCross.contraintSize(height: frame.width/12)
	}

	private func setupNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(didUpdatePointer(notification:)),
											   name: Constants.NotificationNames.didUpdatePoint, object: nil)
	}

	@objc private func didUpdatePointer(notification: Notification) {
		if let point = notification.object as? CGPoint {
			center = point
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}
}
