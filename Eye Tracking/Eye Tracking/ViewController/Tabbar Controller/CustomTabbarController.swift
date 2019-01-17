//
//  CustomTabbarController.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 16.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class CustomTabbarController: UIViewController {

	let tabbarItems = [Item(icon: #imageLiteral(resourceName: "Home"), title: "Home"),
					   Item(icon: #imageLiteral(resourceName: "Home"), title: "Neues"),
					   Item(icon: #imageLiteral(resourceName: "Home"), title: "Einstellungen")]

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		setupNavigationBar()
		setupTabbar()

		NotificationCenter.default.addObserver(self, selector: #selector(didUpdatePointer(notification:)),
											   name: Constants.NotificationNames.didUpdatePoint, object: nil)
	}

	func setupNavigationBar() {
		let topView = UIView()
		topView.backgroundColor = Constants.Colors.tabbarBackground
		let navBar = NavigationBar()

		view.addSubview(navBar)
		view.addSubview(topView)

		navBar.contraintSize(height: 85)
		navBar.constraintToConstants(leading: 0, trailing: 0)
		navBar.constraintToConstantsAndSafeArea(top: 0)

		topView.constraintToConstants(top: 0, leading: 0, trailing: 0)
		topView.translatesAutoresizingMaskIntoConstraints = false
		topView.bottomAnchor.constraint(equalTo: navBar.topAnchor, constant: 0).isActive = true
	}

	private func setupTabbar() {
		let bottomView = UIView()
		bottomView.backgroundColor = Constants.Colors.tabbarBackground

		let tabbar = CustomTabbar(items: tabbarItems)
		view.addSubview(tabbar)
		view.addSubview(bottomView)

		tabbar.contraintSize(height: 85)
		tabbar.constraintToConstants(leading: 0, trailing: 0)
		tabbar.constraintToConstantsAndSafeArea(bottom: 0)

		bottomView.constraintToConstants(leading: 0, trailing: 0, bottom: 0)
		bottomView.translatesAutoresizingMaskIntoConstraints = false
		bottomView.topAnchor.constraint(equalTo: tabbar.bottomAnchor, constant: 0).isActive = true
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	@objc func didUpdatePointer(notification: Notification) {
		if let point = notification.object as? CGPoint {

			let hittestResult = view.hitTest(point, with: nil)

			for (index, button) in Buttons.shared.getButtons().enumerated() {
				if button.button == hittestResult {
					button.button.setBorder(borderWidth: 4, borderColor: UIColor.black.cgColor)
					Buttons.shared.setSelection(index: index, selected: true)
				} else {
					button.button.setBorder(borderWidth: 0, borderColor: UIColor.black.cgColor)
					Buttons.shared.setSelection(index: index, selected: false)
				}
			}
		}
	}
}
