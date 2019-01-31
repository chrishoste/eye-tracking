//
//  CustomTabbar.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 16.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct Item {
	let id: Int
	let icon: UIImage
	let title: String
}

class TabbarItem: UIView {

	private let label: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		return label
	}()

	private let icon: UIImageView = {
		let image = UIImageView()
		image.contentMode = .center
		image.tintColor = .black
		return image
	}()

	let button: UIButton = {
		let button = UIButton()
		return button
	}()

	init(item: Item) {
		super.init(frame: .zero)

		Buttons.shared.append(button: button)
		setupStackView(item)
	}

	private func setupStackView(_ item: Item) {
		label.text = item.title
		icon.image = item.icon
		let stackView = UIStackView(arrangedSubviews: [icon, label])
		stackView.axis = .vertical
		addSubview(stackView)
		addSubview(button)
		stackView.constraintToConstants(top: 4, leading: 0, trailing: 0, bottom: 4)
		button.constraintToConstants(top: 0, leading: 0, trailing: 0, bottom: 0)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

protocol CustomTabbarDelegate: class {
	func sendTabbarAction(key: Int)
}

class CustomTabbar: UIView {

	weak var delegate: CustomTabbarDelegate?

	private var items: [Item] = []

	init(items: [Item]) {
		super.init(frame: .zero)
		self.items = items
		backgroundColor = Constants.Colors.tabbarBackground

		setupTabbarItems(items)
	}

	private func setupTabbarItems(_ items: [Item]) {

		let stackView = UIStackView()

		for item in items {
			let tabBarItem = TabbarItem(item: item)
			tabBarItem.button.tag = item.id
			tabBarItem.button.addTarget(self, action: #selector(doAction), for: .touchUpInside)
			stackView.addArrangedSubview(tabBarItem)
		}

		stackView.distribution = .fillEqually
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.layoutMargins = .init(top: 4, left: 0, bottom: 4, right: 0)
		addSubview(stackView)
		stackView.constraintToConstants(top: 0, leading: 0, trailing: 0, bottom: 0)
	}

	@objc func doAction(sender: UIButton!) {
		delegate?.sendTabbarAction(key: sender!.tag)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
