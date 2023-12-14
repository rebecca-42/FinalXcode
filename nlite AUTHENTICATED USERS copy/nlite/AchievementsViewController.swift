//
//  AchievementsViewController.swift
//  nlite
//
//  Created by Rebecca Sweigart on 12/8/23.
//

import Foundation
import GameKit
import UIKit

class AchievementsViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
    }
    
    private func authenticateUser(){
        let player = GKLocalPlayer.local
        player.authenticateHandler = { AchievementsViewController, error in
            guard error == nil else{
                print(error?.localizedDescription ?? ""); return
            }
           // self.presentViewController(vc!, animated: true, completion: nil)
        }
        
    }
    
    
    
//    func authenticateUser() { GKLocalPlayer.local.authenticateHandler = { viewController, error in
//        if let AchievementsViewController = viewController {
//            // Present the view controller so the player can sign in.
//            return
//        }
//        if error != nil {
//            // Player could not be authenticated.
//            // Disable Game Center in the game.
//            return
//        }
//        
//        // Player was successfully authenticated.
//        // Check if there are any player restrictions before starting the game.
//        
//        if GKLocalPlayer.local.isUnderage {
//            // Hide explicit game content.
//        }
//        
//        
//        if GKLocalPlayer.local.isMultiplayerGamingRestricted {
//            // Disable multiplayer game features.
//        }
//        
//        
//        if GKLocalPlayer.local.isPersonalizedCommunicationRestricted {
//            // Disable in game communication UI.
//        }
//        
//        // Perform any other configurations as needed (for example, access point).
//    }
//    }
    
    @IBAction func showAchievements(_ sender: Any) {
    }
    
    @IBAction func showLeaderboards(_ sender: Any) {
    }
    
    @IBAction func unlockAchievements(_ sender: Any) {
    }
    
    
    @IBAction func submit(_ sender: Any) {
    }
    
}
