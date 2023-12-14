//
//  GameCenterView.swift
//  nlite
//
//  Created by Rebecca Sweigart on 12/9/23.
//

import Foundation
import SwiftUI
import GameKit

struct GameCenterView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        authenticateLocalPlayer(viewController)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    private func authenticateLocalPlayer(_ presentingViewController: UIViewController) {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let viewController = viewController {
                        presentingViewController.present(viewController, animated: true, completion: nil)
                    } else if let error = error {
                        print("Game Center authentication error: \(error.localizedDescription)")
                    } else {
                        print("Game Center authenticated successfully")
                    }
        }
    }
}

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Your SwiftUI Content Goes Here")
//
//            // Authenticate the local player (you might want to do this at the app's launch)
//            Button("Authenticate Game Center") {
//                GameCenterManager.shared.authenticateLocalPlayer()
//            }
//Button("Show Friends") {
//                showFriendList()
//            }
//        }
//    }
//
//    private func showFriendList() {
//        guard GKLocalPlayer.local.isAuthenticated else {
//            print("Player is not authenticated.")
//            // You may want to prompt the player to authenticate here
//            return
//        }
//
//        let viewController = GKFriendRequestComposeViewController()
//        viewController.composeViewDelegate = self
//        UIApplication.shared.windows.first?.rootViewController?.present(viewController, animated: true, completion: nil)
//    }
//}
//
//extension ContentView: GKFriendRequestComposeViewControllerDelegate {
//    func friendRequestComposeViewControllerDidFinish(_ viewController: GKFriendRequestComposeViewController) {
//        viewController.dismiss(animated: true, completion: nil)
//    }
//}
