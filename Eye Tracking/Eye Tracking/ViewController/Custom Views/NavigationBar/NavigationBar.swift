//
//  NavigationBar.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class NavigationBar: UIView {

	private let title: UILabel = {
		let label = UILabel()
		label.text = "Home"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
		return label
	}()

	private let rightButton: UIButton = {
		let button = UIButton()
		button.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
		button.tintColor = .black
		button.imageEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 0)
		return button
	}()
	private let leftButton: UIButton = {
		let button = UIButton()
		button.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
		button.tintColor = .black
		button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 30)
		return button
	}()

	init() {
		super.init(frame: .zero)
		backgroundColor = Constants.Colors.tabbarBackground

		Buttons.shared.append(buttons: [rightButton, leftButton])
		setupStackView()
	}

	private func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [leftButton, title, rightButton])
		stackView.distribution = .fillEqually

		addSubview(stackView)
		stackView.constraintToConstants(top: 0, leading: 0, trailing: 0, bottom: 0)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setTitle(title: String) {
		self.title.text = title
	}
}
