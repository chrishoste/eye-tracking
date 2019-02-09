import Foundation
import UIKit
import ARKit

class AddingSCNodes: UIViewController {

	var sceneView: ARSCNView!
	let configuration = ARFaceTrackingConfiguration()

	let pointer = Pointer()

	let leftEyeNode: SCNNode = {
		let geometry = SCNSphere(radius: 0.003)
		geometry.firstMaterial?.diffuse.contents = UIColor.red

		let node = SCNNode()
		node.geometry = geometry
		return node
	}()

	let rightEyeNode: SCNNode = {
		let geometry = SCNSphere(radius: 0.003)
		geometry.firstMaterial?.diffuse.contents = UIColor.red

		let node = SCNNode()
		node.geometry = geometry
		return node
	}()

	let endPointLeftEye: SCNNode = {
		let geometry = SCNSphere(radius: 0.003)
		geometry.firstMaterial?.diffuse.contents = UIColor.green
		let node = SCNNode()
		node.geometry = geometry
		node.position.z = 0.2
		return node
	}()

	let endPointRightEye: SCNNode = {
		let geometry = SCNSphere(radius: 0.003)
		geometry.firstMaterial?.diffuse.contents = UIColor.green
		let node = SCNNode()
		node.geometry = geometry
		node.position.z = 0.2
		return node
	}()

	let nodeInFrontOfScreen: SCNNode = {
		let node = SCNNode()
		node.geometry = SCNPlane()
		return node
	}()

	override func viewDidLoad() {

		guard ARFaceTrackingConfiguration.isSupported else {
			fatalError("Face-Tracking ist auf diese Gerät nicht verfügbar!")
		}

		setupARSCNView()
		setupNodes()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		sceneView.session.run(configuration)
	}

	private func setupARSCNView() {
		sceneView = ARSCNView()
		sceneView.delegate = self
		view.addSubview(sceneView)
		sceneView.contraintARSCNToSuperView()
	}

	private func setupNodes() {
		sceneView.pointOfView?.addChildNode(nodeInFrontOfScreen)
	}
}

extension AddingSCNodes: ARSCNViewDelegate {

	func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

		guard let device = sceneView.device else {
			return nil
		}

		let faceInformations = ARSCNFaceGeometry(device: device)
		let face = SCNNode(geometry: faceInformations)
		face.geometry?.firstMaterial?.fillMode = .lines

		leftEyeNode.addChildNode(endPointLeftEye)
		face.addChildNode(leftEyeNode)
		rightEyeNode.addChildNode(endPointRightEye)
		face.addChildNode(rightEyeNode)

		return face
	}

	func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

		guard let faceAnchor = anchor as? ARFaceAnchor,
			let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
				return
		}

		leftEyeNode.simdTransform = faceAnchor.leftEyeTransform
		rightEyeNode.simdTransform = faceAnchor.rightEyeTransform

		faceGeometry.update(from: faceAnchor.geometry)
	}
}
