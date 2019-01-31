//
//  BaseSlideController.swift
//  SlideInMenu
//
//  Created by Christophe Hoste on 10.10.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit

class BaseSlideController: UIViewController {

	fileprivate var isOpenMenu = true
	fileprivate var trailingAnchor: NSLayoutConstraint!

	fileprivate let menuView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	fileprivate let contentView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	fileprivate let darkOverlay: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor(white: 0, alpha: 0.4)
		view.alpha = 0

		let button = UIButton()
		button.addTarget(self, action: #selector(BaseSlideController.doClose), for: .touchUpInside)
		view.addSubview(button)
		button.constraintToConstants(top: 0, leading: 0, trailing: 0, bottom: 0)

		Buttons.shared.append(button: button)
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupViews()
		setupViewController()

		NotificationCenter.default.addObserver(self, selector: #selector(didUpdatePointer(notification:)),
															  name: Constants.NotificationNames.didUpdatePoint, object: nil)
	}

	fileprivate func setupViews() {
		view.addSubview(contentView)
		view.addSubview(menuView)

		NSLayoutConstraint.activate([
			contentView.topAnchor.constraint(equalTo: view.topAnchor),
			contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			contentView.widthAnchor.constraint(equalTo: view.widthAnchor),

			menuView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			menuView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor),
			menuView.widthAnchor.constraint(equalToConstant: Constants.SlideMenu.menuWidth)
			])

		trailingAnchor = contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		trailingAnchor.isActive = true
	}

	fileprivate func setupViewController() {
		let tabBarController = CustomTabbarController()
		tabBarController.delegate = self
		contentView.addSubview(tabBarController.view)
		tabBarController.view.frame = contentView.frame

		let menuController = TestViewController()
		menuView.addSubview(menuController.view)
		menuController.view.frame = menuView.frame

		addChild(tabBarController)
		addChild(menuController)
	}

	fileprivate func handleHide() {
		isOpenMenu = false
		removeOverlay()
		performAnimation(0)
	}

	fileprivate func handleOpen() {
		isOpenMenu = true
		addOverlay()
		performAnimation(Constants.SlideMenu.menuWidth)
	}

	fileprivate func performAnimation(_ value: CGFloat) {
		trailingAnchor.constant = value

		UIView.animate(withDuration: 0.5,
					   delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
						self.view.layoutIfNeeded()
		}) { (_) in
			return
		}
	}

	fileprivate func addOverlay() {
		contentView.addSubview(darkOverlay)
		NSLayoutConstraint.activate([
			darkOverlay.topAnchor.constraint(equalTo: contentView.topAnchor),
			darkOverlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			darkOverlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			darkOverlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
			])

		UIView.animate(withDuration: 0.25, animations: {
			self.darkOverlay.alpha = 1
		})
	}

	fileprivate func removeOverlay() {
		UIView.animate(withDuration: 0.25, animations: {
			self.darkOverlay.alpha = 0
		}) { (_) in
			self.darkOverlay.removeFromSuperview()
		}
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	@objc func doClose(sender: UIButton) {
		handleHide()
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

extension BaseSlideController: CustomTabbarControllerDelegate {
	func toggleMenu() {
		if isOpenMenu {
			handleHide()
		} else {
			handleOpen()
		}
	}
}
