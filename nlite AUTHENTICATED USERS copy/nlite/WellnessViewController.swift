//
//  WellnessViewController.swift
//  nlite
//
//  Created by Rebecca Sweigart on 12/8/23.
//

import Foundation
import AVFoundation
import AVKit

// play sounds for meditation
//let whiteNoise = URL(fileURLWithPath: Bundle.main.path(forResource: "3HourWhiteNoise", ofType: "mp3")!)
class UIWellnessViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()

        override func viewDidLoad() {
            super.viewDidLoad()
            // address of the music file.
            let music = Bundle.main.path(forResource: "Music", ofType: "mp3")
            // copy this syntax, it tells the compiler what to do when action is received
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: music! ))
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
                try AVAudioSession.sharedInstance().setActive(true)
            }
            catch{
                print(error)
            }

        }
    
    //this runs the do try statement
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

        @IBAction func play(_ sender: AnyObject) {
            audioPlayer.play()
        }
        @IBAction func stop(_ sender: AnyObject) {
            audioPlayer.stop()
        }
    }


//    var whiteNoise: AVAudioPlayer?
//
//    func UIPlay(_ sender: Any) {
//    }
//
//    func playWhiteNoise(){
//        let path = Bundle.main.path(forResource: "3HourWhiteNoise.mp3", ofType: nil)!
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            whiteNoise = try AVAudioPlayer(contentsOf: url)
//            whiteNoise?.play()
//        } catch {
//            print("couldn't load the file")
//        }
//    }
//
