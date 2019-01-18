//
//  CustomTabbarController.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 16.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTabbarControllerDelegate: class {
	func toggleMenu()
}

class CustomTabbarController: UIViewController {

	weak var delegate: CustomTabbarControllerDelegate?

	let tabbarItems = [Item(id: 1, icon: #imageLiteral(resourceName: "Home"), title: "Home"),
					   Item(id: 2, icon: #imageLiteral(resourceName: "Home"), title: "Neues"),
					   Item(id: 3, icon: #imageLiteral(resourceName: "Home"), title: "Einstellungen")]

	let navBar = NavigationBar()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		setupNavigationBar()
		setupTabbar()

	}

	func setupNavigationBar() {
		let topView = UIView()
		topView.backgroundColor = Constants.Colors.tabbarBackground

		navBar.delegate = self
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
		tabbar.delegate = self
		view.addSubview(tabbar)
		view.addSubview(bottomView)

		tabbar.contraintSize(height: 85)
		tabbar.constraintToConstants(leading: 0, trailing: 0)
		tabbar.constraintToConstantsAndSafeArea(bottom: 0)

		bottomView.constraintToConstants(leading: 0, trailing: 0, bottom: 0)
		bottomView.translatesAutoresizingMaskIntoConstraints = false
		bottomView.topAnchor.constraint(equalTo: tabbar.bottomAnchor, constant: 0).isActive = true
	}
}

extension CustomTabbarController: CustomTabbarDelegate, NavigationBarDelegate {
	func toggleMenu() {
		delegate?.toggleMenu()
	}

	func sendTabbarAction(key: Int) {
		switch key {
		case 1:
			navBar.setTitle(title: "Home")
		case 2:
			navBar.setTitle(title: "Neues")
		case 3:
			navBar.setTitle(title: "Settings")
		default:
			break
		}
	}
}
