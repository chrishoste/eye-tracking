//
//  AppDelegate.swift
//  DocumentationET
//
//  Created by Christophe Hoste on 03.02.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		window?.makeKeyAndVisible()

		//window?.rootViewController = ARKitFile()
		window?.rootViewController = AddingSCNodes()

		return true
	}


}

