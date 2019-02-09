//
//  NavigationBar.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationBarDelegate: class {
	func toggleMenu()
}

class NavigationBar: UIView {

	weak var delegate: NavigationBarDelegate?

	private let title: UILabel = {
		let label = UILabel()
		label.text = "Home"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 32, weight: .medium)
		return label
	}()

	private let rightButton: TrackableButton = {
		let button = TrackableButton()
		button.setImage(#imageLiteral(resourceName: "Plus"), for: .normal)
		button.tintColor = .black
		button.imageEdgeInsets = .init(top: 0, left: 30, bottom: 0, right: 0)
		return button
	}()
	private let leftButton: TrackableButton = {
		let button = TrackableButton()
		button.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
		button.tintColor = .black
		button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 30)
		button.addTarget(self, action: #selector(NavigationBar.doMenu), for: .touchUpInside)
		return button
	}()

	init() {
		super.init(frame: .zero)
		backgroundColor = Constants.Colors.tabbarBackground
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

	@objc func doMenu(sender: UIButton!) {
		delegate?.toggleMenu()
	}
}
