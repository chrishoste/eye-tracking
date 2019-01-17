//
//  Buttons.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 17.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct SelectedButton {
	var button: UIButton
	var selected: Bool
}

class Buttons {

	private var buttons: [SelectedButton] = []

	static let shared = Buttons()
	private init() {}

	func append(button: UIButton) {
		self.buttons.append(SelectedButton(button: button, selected: false))
	}

	func append(buttons: [UIButton]) {
		for button in buttons {
			append(button: button)
		}
	}

	func getButtons() -> [SelectedButton] {
		return self.buttons
	}

	func setSelection(index: Int, selected: Bool) {
		self.buttons[index].selected = selected
	}

	func sendAction() {
		for button in buttons where button.selected == true {
			button.button.sendActions(for: .touchUpInside)
		}
	}
}
