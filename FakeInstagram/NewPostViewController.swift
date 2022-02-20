//
//  NewPostViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        captionTextField.textColor = .lightGray
        
        let closeKeyboardGestureRec = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeKeyboardGestureRec)
        
        let imagePickerTapGestureRec = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imagePickerTapGestureRec)
        imageView.isUserInteractionEnabled = true
        
        uploadButton.isEnabled = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if captionTextField.textColor == UIColor.lightGray && captionTextField.text! == "Write caption here..." {
            captionTextField.text = ""
            captionTextField.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captionTextField.textColor == UIColor.black {
            if let currentCaption = captionTextField.text {
                if currentCaption.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty || currentCaption == "" {
                    captionTextField.text = "Write caption here..."
                    captionTextField.textColor = .lightGray
                }
            }
        }
    }
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    @objc func chooseImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        uploadButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadNewPost(_ sender: Any) {
        let storage = Storage.storage()
        let mainStorageRef = storage.reference()
        let mediaRef = mainStorageRef.child("Media")
        let imagesRef = mediaRef.child("Image")
        
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.5) {
            let imgToUploadRef = imagesRef.child("\(UUID().uuidString).jpg")
            imgToUploadRef.putData(imageData, metadata: nil) { (storageMetadata, err) in
                if err != nil {
                    self.createAlert(alertTitle: "Posting Failed", alertMessage: err?.localizedDescription ?? "Something went wrong while posting your photo. Please try again later.")
                }
                else {
                    imgToUploadRef.downloadURL { (url, err) in
                        if err == nil {
                            if let newImgURL = url?.absoluteString {
                                if let caption = self.captionTextField.text {
                                    if caption != "Write caption here..." {
                                        let firestoreDB = Firestore.firestore()
                                        let newPost = ["mail": Auth.auth().currentUser!.email!, "image": newImgURL, "caption": caption, "postTime": FieldValue.serverTimestamp()] as [String: Any]
                                        
                                        firestoreDB.collection("Posts").addDocument(data: newPost) { (err) in
                                            if err != nil {
                                                self.createAlert(alertTitle: "Posting Failed", alertMessage: err?.localizedDescription ?? "Something went wrong while saving your post to database. Please try again later.")
                                            }
                                            else {
                                                self.captionTextField.text = "Write caption here..."
                                                self.captionTextField.textColor = .lightGray
                                                self.imageView.image = UIImage(systemName: "photo")
                                                self.uploadButton.isEnabled = false
                                                self.tabBarController?.selectedIndex = 0
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func createAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
    }
}
