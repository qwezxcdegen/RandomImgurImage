//
//  ViewController.swift
//  RandomImgurImage
//
//  Created by Степан Фоминцев on 09.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let chars = "01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func generatePressed() {
        DispatchQueue.main.async {
            self.imageView.image = nil
            self.activityIndicator.startAnimating()
        }
        var text = ""
        for _ in 1...5 {
            text += String(chars.randomElement() ?? " ")
        }
        let url = "https://i.imgur.com/" + text + ".jpg"
        print(url)
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, let image = UIImage(data: data) else { return }
            if image.size.height == 81 && image.size.width == 161 {
                self.generatePressed()
            } else {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
    
    @IBAction func downloadPressed() {
        guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        let ac = UIAlertController(title: "OK", message: "Saved", preferredStyle: .alert)
        present(ac, animated: true)
        dismiss(animated: true)
    }
    
}

