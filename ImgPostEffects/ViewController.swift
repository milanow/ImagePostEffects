//
//  ViewController.swift
//  ImgPostEffects
//
//  Created by Tianhe Wang on 2/6/18.
//  Copyright © 2018 Tianhe Wang Coorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var originalImage: UIImage = UIImage(named: "testImg.jpeg")!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bottomBar: UIView!
    
    @IBOutlet var secondaryMenu: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        secondaryMenu.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        // turn off auto re-sizing
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNewPhoto(_ sender: Any) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        self.present(cameraPicker, animated: true, completion: nil)
        
    }
    
    func showAlbum(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .photoLibrary
        
        self.present(cameraPicker, animated: true, completion: nil)
    }
    
    // image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let newImg = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = newImg
            originalImage = newImg
        }
    }
    
    // imge picker delegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func onFilter(_ sender: UIButton) {
        if(sender.isSelected){
            hideSecondaryMenu()
            sender.isSelected = false
        }else{
            showSecondaryMenu()
            sender.isSelected = true
        }
    }
    
    func showSecondaryMenu(){
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraint(equalTo: bottomBar.topAnchor)
        let leftConstraint = secondaryMenu
            .leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstrint = secondaryMenu.rightAnchor.constraint(equalTo: view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraint(equalToConstant: 44)
        
        NSLayoutConstraint.activate([bottomConstraint, leftConstraint, rightConstrint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.secondaryMenu.alpha = 1.0})
        
    }
    
    func hideSecondaryMenu(){
        // this is an async way of animation
        //        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.secondaryMenu.alpha = 0})
        UIView.animate(withDuration: 0.5, animations: {() -> Void in self.secondaryMenu.alpha = 0}, completion: {completed -> Void in
            if completed == true{
                self.secondaryMenu.removeFromSuperview()
            } })
    }

    @IBAction func resetImage(_ sender: Any) {
        imageView.image = originalImage
    }
}

