//
//  ViewController.swift
//  MemeGenerator
//
//  Created by Grant Watson on 10/28/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme Generator"
        imageView.backgroundColor = .lightGray
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addImage))
    }
    
    @objc func addImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func topTextTapped(_ sender: Any) {
        if imageView.image != nil {
            let ac = UIAlertController(title: "Top Text", message: "Please type the top line of your meme below.", preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                let topText = ac.textFields?[0].text
                self?.addText(text: topText ?? "Error", y: 20)
            })

            present(ac, animated: true)
        }
    }
    
    
    @IBAction func bottomTextTapped(_ sender: Any) {
        if imageView.image != nil {
            let ac = UIAlertController(title: "Bottom Text", message: "Please type the bottom line of your meme below.", preferredStyle: .alert)
            ac.addTextField()
            ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                let bottomText = ac.textFields?[0].text
                self?.addText(text: bottomText ?? "Error", y: 650)
            })

            present(ac, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        imageView.image = image
        self.image = image
    }
    
    func addText(text: String, y: CGFloat) {
        guard let image = image else { return }
    
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let meme = renderer.image { context in
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key : Any] = [
                .font : UIFont(name: "Impact", size: 80)!,
                .paragraphStyle : paragraphStyle,
                .foregroundColor : UIColor.white,
                .strokeWidth : -3,
                .strokeColor : UIColor.black
            ]
            
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let attributedString = NSAttributedString(string: text, attributes: attrs)
            attributedString.draw(with: CGRect(x: image.accessibilityFrame.midX, y: image.frame.height , width: image.size.width, height: 90), options: .usesLineFragmentOrigin, context: nil)
        }
        
        imageView.image = meme
    }
}

