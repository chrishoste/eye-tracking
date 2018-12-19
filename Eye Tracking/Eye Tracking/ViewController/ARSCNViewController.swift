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

	var sceneView: ARSCNView!
	let configuration = ARFaceTrackingConfiguration()

	var leftEyeNode: SCNNode = {
		let geometry = SCNCone(topRadius: 0.005, bottomRadius: 0, height: 0.1)
		geometry.radialSegmentCount = 3
		geometry.firstMaterial?.diffuse.contents = UIColor.red
		let node = SCNNode()
		node.geometry = geometry
		node.eulerAngles.x = -.pi / 2
		node.position.z = 0.1
		let parentNode = SCNNode()
		parentNode.addChildNode(node)
		return parentNode
	}()

	var rightEyeNode: SCNNode = {
		let geometry = SCNCone(topRadius: 0.005, bottomRadius: 0, height: 0.1)
		geometry.radialSegmentCount = 3
		geometry.firstMaterial?.diffuse.contents = UIColor.blue
		let node = SCNNode()
		node.geometry = geometry
		node.eulerAngles.x = -.pi / 2
		node.position.z = 0.1
		let parentNode = SCNNode()
		parentNode.addChildNode(node)
		return parentNode
	}()

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

		let screenGeometry = SCNPlane(width: 1, height: 1)
		screenGeometry.firstMaterial?.isDoubleSided = true
		screenGeometry.firstMaterial?.fillMode = .fill

		let node = SCNNode()
		node.geometry = screenGeometry
		return node
	}()

	let crosshair = Crosshair(size: .init(width: 50, height: 50))

	var points: [CGPoint] = []

	override func viewDidLoad() {
		super.viewDidLoad()

		guard ARFaceTrackingConfiguration.isSupported else {
			fatalError("Face tracking is not supported on this device")
		}

		setupARSCNView()
		sceneView.pointOfView?.addChildNode(nodeInFrontOfScreen)
		addApp()
		setupView()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}

	fileprivate func addApp() {

		let app = UINavigationController(rootViewController: TestViewController())
		app.view.frame = view.frame
		view.addSubview(app.view)
		app.view.contraintToSuperView()
		addChild(app)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		//sceneView.isHidden = true
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
	}

	func hitTest() {

		var leftEyeLocation = CGPoint()
		var rightEyeLocation = CGPoint()

		let leftEyeResult = nodeInFrontOfScreen.hitTestWithSegment(from: endPointLeftEye.worldPosition,
														  to: leftEyeNode.worldPosition,
														  options: nil)

		let rightEyeResult = nodeInFrontOfScreen.hitTestWithSegment(from: endPointRightEye.worldPosition,
														  to: rightEyeNode.worldPosition,
														  options: nil)

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
				let pointX = ((leftEyeLocation.x + rightEyeLocation.x) / 2) + 250
				let pointY = -(leftEyeLocation.y + rightEyeLocation.y) / 2

				point.x = pointX.clamped(to: Constants.Ranges.widthRange)
				point.y = pointY.clamped(to: Constants.Ranges.heightRange)
				return point
			}()

			setNewPoint(point)
		}
	}

	func checkForEnter(faceAnchor: ARFaceAnchor) {
		guard let mouthPucker = faceAnchor.blendShapes[.mouthPucker] else {
			return
		}

		if mouthPucker.floatValue > 0.5 {
			debugPrint(mouthPucker)
		}
	}

	private func setupView() {
		view.addSubview(crosshair)
		crosshair.center = view.center
	}

	private func setNewPoint(_ point: CGPoint) {
		points.append(point)
		points = points.suffix(50).map {$0}
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.1, animations: {
//				self.crosshair.center = self.points.average()
				Pointer.shared.setPoint(to: self.points.average())
			})
		}
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
