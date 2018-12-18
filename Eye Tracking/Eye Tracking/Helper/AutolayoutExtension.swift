//
//  AutolayoutExtension.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 04.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit
import ARKit

extension UIView {

	func contraintToSuperView() {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let superView = self.superview {
			self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
			self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
		}
	}

	func contraintToCenter() {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let superView = self.superview {
			self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
			self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
		}
	}

	func constraintHeightToSuperView() {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let superView = self.superview {
			self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
		}
	}

	func constraintToConstants(top: CGFloat? = nil, leading: CGFloat? = nil,
							   trailing: CGFloat? = nil, bottom: CGFloat? = nil) {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let superView = self.superview {
			if let topConstant = top {
				self.topAnchor.constraint(equalTo: superView.topAnchor, constant: topConstant).isActive = true
			}

			if let leadingConstant = leading {
				self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: leadingConstant).isActive = true
			}

			if let trailingConstant = trailing {
				self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -trailingConstant).isActive = true
			}

			if let bottomConstant = bottom {
				self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottomConstant).isActive = true
			}
		}
	}

	func contraintSize(width: CGFloat? = nil, height: CGFloat? = nil) {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let widthConstant = width {
			self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
		}

		if let heightConstant = height {
			self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
		}
	}
}

extension ARSCNView {

	func contraintARSCNToSuperView() {
		self.translatesAutoresizingMaskIntoConstraints = false

		if let superView = self.superview {
			self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
			self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
		}
	}
}
