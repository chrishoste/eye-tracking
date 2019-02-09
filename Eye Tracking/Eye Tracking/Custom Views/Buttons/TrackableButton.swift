//
//  TrackableButton.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 31.01.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class TrackableButton: UIButton {

	init() {
		super.init(frame: .zero)
		isSelected = false
		NotificationCenter.default.addObserver(self, selector: #selector(foundTrackableButton(notification:)),
											   name: Constants.NotificationNames.trackableButton, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(selectTrackableButton(notification:)),
											   name: Constants.NotificationNames.selectTrackableButton, object: nil)
	}

	@objc func foundTrackableButton(notification: Notification) {
		if let button = notification.object as? TrackableButton, button == self {
			button.setBorder(borderWidth: 5, borderColor: UIColor.black.cgColor)
			isSelected = true
		} else {
			setBorder(borderWidth: 0, borderColor: UIColor.black.cgColor)
			isSelected = false
		}
	}

	@objc func selectTrackableButton(notification: Notification) {
		if isSelected {
			sendActions(for: .touchUpInside)
		}
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
