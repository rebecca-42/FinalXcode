//
//  ResultsViewController.swift
//  nlite
//
//  Created by Rebecca Sweigart on 11/29/23.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblResults: UILabel!
    
    var noCorrect = 0
    var total = 0
    var resultsString = ""
    var qrCodeImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the results
        lblResults.text = "You got \(noCorrect) out of \(total) correct"
        
        // Calculate the percentage of questions you got right
        var percentRight = Double(noCorrect) / Double(total)
        percentRight *= 100
        
        // Based on the percentage of questions you got right present the user with different message
        var title = ""
        if(percentRight < 40) {
            title = "Keep Trying!"
        } else if(percentRight < 70) {
            title = "So Close!"
        } else {
            title = "Great Job!"
        }
        lblTitle.text = title
        lblTitle.font = UIFont.systemFont(ofSize: 25)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byWordWrapping
        lblTitle.frame = CGRect(x: 20, y: 50, width: 200, height: 50)
        
        // Display the QR code image if available
                if let qrCodeImage = qrCodeImage {
                    let imageView = UIImageView(image: qrCodeImage)
                    imageView.frame = CGRect(x: 150, y: 300, width: 100, height: 100)
                    view.addSubview(imageView)
                    
                    let label = UILabel(frame: CGRect(x: imageView.frame.origin.x, y: imageView.frame.maxY, width: imageView.frame.width, height: 20))
                        label.text = "share your score!"
                        label.textAlignment = .center
                        label.textColor = .black
                        view.addSubview(label)
                        label.numberOfLines = 2
                        label.font = UIFont.systemFont(ofSize: 12)
                }
            }

}
