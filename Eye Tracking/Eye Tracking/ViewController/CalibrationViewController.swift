//
//  CalibrationViewController.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 19.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class CalibrationViewController: UIViewController {

	var seconds = 5
	var timer: Timer?

	let calibrationPointView = CalibrationCircleView()

	let titleCalibration: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Calibration"
		label.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
		label.textAlignment = .center
		return label
	}()

	let descriptionCalibration: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Fix the red dot in the middle of the screen until he turn green."
		label.font = UIFont.systemFont(ofSize: 22, weight: .light)
		label.textAlignment = .center
		label.numberOfLines = 0
		return label
	}()

	let counterLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "5"
		label.font = UIFont.systemFont(ofSize: 100, weight: .medium)
		label.textAlignment = .center
		label.textColor = UIColor.init(white: 0, alpha: 0.2)
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		setupSubviews()

		timer = Timer.scheduledTimer(timeInterval: 1, target: self,
									 selector: #selector(setCounter), userInfo: nil, repeats: true)
	}

	@objc private func setCounter() {
		seconds -= 1
		if seconds >= 0 {
			counterLabel.text = "\(seconds)"
		} else {
			timer?.invalidate()
			timer = nil
			animateViews()
		}
	}

	private func setupView() {
		view.backgroundColor = .white
	}

	private func setupSubviews() {

		calibrationPointView.contraintSize(width: 80, height: 80)
		calibrationPointView.alpha = 0
		view.addSubview(counterLabel)
		view.addSubview(calibrationPointView)
		counterLabel.contraintToCenter()
		calibrationPointView.contraintToCenter()
		setupStackView()
	}

	func animateViews() {
		UIView.animate(withDuration: 0.25, animations: {
			self.counterLabel.alpha = 0
			self.calibrationPointView.alpha = 1

		}) { (_) in
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
				let watchPoint = Pointer.shared.getPointer()
				self.calibrate(watchPoint: watchPoint, centerPoint: self.calibrationPointView.center)
			}
			//self.calibrationPointView.setCircleGreen()

//			self.view.removeFromSuperview()
//			self.removeFromParent()
		}
	}

	fileprivate func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [titleCalibration, descriptionCalibration, UIView()])
		stackView.axis = .vertical

		stackView.spacing = 32
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = .init(top: 72, left: 32, bottom: 12, right: 32)
		view.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: view.topAnchor),
			stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			stackView.bottomAnchor.constraint(equalTo: calibrationPointView.topAnchor)
			])
	}

	func calibrate(watchPoint: CGPoint, centerPoint: CGPoint) {

		Pointer.shared.calibrate(centerPoint: centerPoint)

//		if checkPoint(watchPoint: watchPoint, centerPoint: centerPoint) {
//			calibrationPointView.setCircleGreen()
//			return
//		}
//
//		let calibartedCompenstation = CGPoint(x: centerPoint.x - watchPoint.x, y: centerPoint.y - watchPoint.y)
//		Pointer.shared.setNewPoint(calibartedCompenstation)
//		Pointer.shared.resetPoints()
//
//		//calibrate(watchPoint: Pointer.shared.getPointer(), centerPoint: centerPoint)
	}

	func checkPoint(watchPoint: CGPoint, centerPoint: CGPoint) -> Bool {

		let rangeX = (centerPoint.x - 20...centerPoint.x + 20)
		let rangeY = (centerPoint.y - 20...centerPoint.y + 20)

		if rangeX.contains(watchPoint.x) && rangeY.contains(watchPoint.y) {
			return true
		} else {
			return false
		}
	}
}
