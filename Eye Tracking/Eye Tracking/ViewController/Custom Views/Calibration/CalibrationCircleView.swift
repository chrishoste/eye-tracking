//
//  CalibrationCircleView.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 19.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class CalibrationCircleView: UIView {

	let notification = UINotificationFeedbackGenerator()

	let innerMaskCircle: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()

	let innerSmallCircle: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		return view
	}()

	init() {
		super.init(frame: .zero)
		setupView()
		setupSubviews()
	}

	private func setupView() {
		backgroundColor = .red
	}

	override func didMoveToSuperview() {
		setupCornerRadius()
	}

	private func setupSubviews() {
		addSubview(innerMaskCircle)
		innerMaskCircle.addSubview(innerSmallCircle)

		innerMaskCircle.contraintToSuperView(withConstant: 15)
		innerSmallCircle.contraintToSuperView(withConstant: 15)
	}

	private func setupCornerRadius() {
		layoutIfNeeded()
		clipsToBounds = true
		layer.masksToBounds = true
		layer.cornerRadius = frame.width / 2
		innerMaskCircle.layer.cornerRadius = innerMaskCircle.frame.width / 2
		innerSmallCircle.layer.cornerRadius = innerSmallCircle.frame.width / 2
	}

	func setCircleGreen() {
		notification.prepare()
		backgroundColor = .green
		innerSmallCircle.backgroundColor = .green

		notification.notificationOccurred(.success)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
