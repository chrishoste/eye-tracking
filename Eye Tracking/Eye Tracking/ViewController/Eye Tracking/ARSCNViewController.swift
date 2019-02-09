//
//  ARSCNViewController.swift
//  Eye Tracking
//
//  Created by Christophe Hoste on 04.12.18.
//  Copyright © 2018 hoste. All rights reserved.
//

import Foundation
import UIKit
import ARKit

class ARSCNViewController: UIViewController {

	fileprivate var sceneView: ARSCNView!

	var enterEnabled = true

	let pointer = Pointer()

	var leftEyeNode = SCNNode()
	var rightEyeNode = SCNNode()

	var endPointLeftEye: SCNNode = {
		let node = SCNNode()
		node.position.z = 2
		return node
	}()

	var endPointRightEye: SCNNode = {
		let node = SCNNode()
		node.position.z = 2
		return node
	}()

	var nodeInFrontOfScreen: SCNNode = {
		let node = SCNNode()
		node.geometry = SCNPlane()
		return node
	}()

	let crosshair = Crosshair(radius: 25)

	let appView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		guard ARFaceTrackingConfiguration.isSupported else {
			fatalError("Face-Tracking ist auf diese Gerät nicht verfügbar!")
		}

		setupARSCNView()
		setupView()
		addApp()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//sceneView.isHidden = true
		let configuration = ARFaceTrackingConfiguration()
		sceneView.session.run(configuration)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		//sceneView.session.pause()
	}

	private func setupARSCNView() {
		sceneView = ARSCNView()
		sceneView.delegate = self
		view.addSubview(sceneView)
		sceneView.contraintARSCNToSuperView()
		sceneView.pointOfView?.addChildNode(nodeInFrontOfScreen)
	}

	func hitTest() {

		var leftEyeLocation = CGPoint()
		var rightEyeLocation = CGPoint()

		let leftEyeResult = nodeInFrontOfScreen.hitTestWithSegment(from: endPointLeftEye.worldPosition,
														  to: leftEyeNode.worldPosition)

		let rightEyeResult = nodeInFrontOfScreen.hitTestWithSegment(from: endPointRightEye.worldPosition,
														  to: rightEyeNode.worldPosition)

		if leftEyeResult.count > 0 || rightEyeResult.count > 0 {

			guard let leftResult = leftEyeResult.first, let rightResult = rightEyeResult.first else {
				return
			}

			leftEyeLocation.x = CGFloat(leftResult.localCoordinates.x) / (Constants.Device.screenSize.width / 2) *
				Constants.Device.frameSize.width
			leftEyeLocation.y = CGFloat(leftResult.localCoordinates.y) / (Constants.Device.screenSize.height / 2) *
				Constants.Device.frameSize.height

			rightEyeLocation.x = CGFloat(rightResult.localCoordinates.x) / (Constants.Device.screenSize.width / 2) *
				Constants.Device.frameSize.width
			rightEyeLocation.y = CGFloat(rightResult.localCoordinates.y) / (Constants.Device.screenSize.height / 2) *
				Constants.Device.frameSize.height

			let point: CGPoint = {
				var point = CGPoint()
				let pointX = ((leftEyeLocation.x + rightEyeLocation.x) / 2) + 150
				let pointY = (-(leftEyeLocation.y + rightEyeLocation.y) / 2) * 1.2

				point.x = pointX.clamped(to: Constants.Ranges.widthRange)
				point.y = pointY.clamped(to: Constants.Ranges.heightRange)
				return point
			}()

			pointer.setNewPoint(point)
		}
	}

	func checkForEnter(faceAnchor: ARFaceAnchor) {
		guard let mouthPucker = faceAnchor.blendShapes[.mouthPucker] else {
			return
		}

		if enterEnabled {
			if mouthPucker.floatValue > 0.47 {
				DispatchQueue.main.async {
					self.enterEnabled = false
					NotificationCenter.default.post(name: Constants.NotificationNames.selectTrackableButton, object: nil)
				}
			}
		} else {
			if mouthPucker.floatValue < 0.44 {
				self.enterEnabled = true
			}
		}
	}

	private func setupView() {
		view.addSubview(appView)
		view.addSubview(crosshair)

		appView.contraintToSuperView()
	}

	fileprivate func addApp() {

		//let app = UINavigationController(rootViewController: TestViewController())
		//let app = CalibrationViewController()
		//let app = CustomTabbarController()
		let app = BaseSlideController()
		appView.addSubview(app.view)
		app.view.contraintToSuperView()
		addChild(app)
	}
}

extension ARSCNViewController: ARSCNViewDelegate {

	func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

		guard let device = sceneView.device else {
			return nil
		}

		let faceGeometry = ARSCNFaceGeometry(device: device)
		let node = SCNNode(geometry: faceGeometry)
		node.geometry?.firstMaterial?.fillMode = .lines

		node.addChildNode(leftEyeNode)
		leftEyeNode.addChildNode(endPointLeftEye)
		node.addChildNode(rightEyeNode)
		rightEyeNode.addChildNode(endPointRightEye)

		return node
	}

	func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

		guard let faceAnchor = anchor as? ARFaceAnchor,
			let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
				return
		}

		leftEyeNode.simdTransform = faceAnchor.leftEyeTransform
		rightEyeNode.simdTransform = faceAnchor.rightEyeTransform

		faceGeometry.update(from: faceAnchor.geometry)
		hitTest()
		checkForEnter(faceAnchor: faceAnchor)
	}
}
