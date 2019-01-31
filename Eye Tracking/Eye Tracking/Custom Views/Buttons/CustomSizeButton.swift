//
//  CustomSizeButton.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 18.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class CustomSizeButton: UIButton {

	private var size: CGSize = .init(width: 0, height: 0)

	override var intrinsicContentSize: CGSize {
		return size
	}

	init(size: CGSize) {
		super.init(frame: .zero)
		self.size = size
		backgroundColor = .green
		setTitleColor(.black, for: .normal)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setBorder() {
		layer.borderWidth = 4
		layer.borderColor = UIColor.black.cgColor
	}

	func removeBorder() {
		layer.borderWidth = 0
	}
}
