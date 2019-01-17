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

	let tabbarItems = [Item(icon: #imageLiteral(resourceName: "Home"), title: "Menu1"),
					   Item(icon: #imageLiteral(resourceName: "Home"), title: "Menu2"),
					   Item(icon: #imageLiteral(resourceName: "Home"), title: "Menu3")]

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		setupTabbar()
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
}
