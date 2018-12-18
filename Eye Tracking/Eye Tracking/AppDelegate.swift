//
//  AppDelegate.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 29.11.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
		window?.makeKeyAndVisible()

		window?.rootViewController = ARSCNViewController()

		return true
	}
}
