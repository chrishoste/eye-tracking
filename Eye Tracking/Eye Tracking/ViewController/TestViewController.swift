//
//  TestViewController.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 18.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class TestViewController: UIViewController {

	let button1 = CustomSizeButton(size: .init(width: 100, height: 50))
	let button2 = CustomSizeButton(size: .init(width: 100, height: 50))

	var buttons: [CustomSizeButton] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		buttons = [button1, button2]
		let stackView =  UIStackView(arrangedSubviews: [button1, UIView(), button2])

		stackView.spacing = 8
		view.addSubview(stackView)

		stackView.contraintToCenter()
		stackView.constraintToConstants(leading: 8, trailing: 8)

		view.backgroundColor = .white
		button1.setTitle("Button 1", for: .normal)
		button2.setTitle("Button 2", for: .normal)

		NotificationCenter.default.addObserver(self, selector: #selector(didUpdatePointer(notification:)),
											   name: Constants.NotificationNames.didUpdatePoint, object: nil)
	}

	@objc func didUpdatePointer(notification: Notification) {
		if let point = notification.object as? CGPoint {

			let hittestResult = view.hitTest(point, with: nil)

			for button in buttons {
				if button == hittestResult {
					button.setBorder()
				} else {
					button.removeBorder()
				}
			}
		}
	}
}
