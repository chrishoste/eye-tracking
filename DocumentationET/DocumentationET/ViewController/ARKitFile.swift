import Foundation
import UIKit
import ARKit

class ARKitFile: UIViewController {

	var sceneView: ARSCNView!
	let configuration = ARFaceTrackingConfiguration()

	override func viewDidLoad() {

		guard ARFaceTrackingConfiguration.isSupported else {
			fatalError("Face-Tracking ist auf diese Gerät nicht verfügbar!")
		}

		setupARSCNView()
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
}

extension ARKitFile: ARSCNViewDelegate {

	func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {

		guard let device = sceneView.device else {
			return nil
		}

		let faceInformations = ARSCNFaceGeometry(device: device)
		let face = SCNNode(geometry: faceInformations)
		face.geometry?.firstMaterial?.fillMode = .lines

		return face
	}

//	func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//
//		guard let faceAnchor = anchor as? ARFaceAnchor,
//			let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
//				return
//		}
//
//		faceGeometry.update(from: faceAnchor.geometry)
//	}
}
