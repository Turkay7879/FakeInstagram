//
//  HomePageViewController.swift
//  FakeInstagram
//
//  Created by Türkay on 19.02.2022.
//

import UIKit
import Firebase
import SDWebImage

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTable: UITableView!
    var posts = [PostData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
        getHomeFeedData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTable.dequeueReusableCell(withIdentifier: "HomeVCCell", for: indexPath) as! HomeFeedTableViewCell
        cell.mailLabel.text = posts[indexPath.item].getEmail()
        cell.captionLabel.text = posts[indexPath.item].getCaption()
        cell.postImageView.sd_setImage(with: URL(string: posts[indexPath.item].getImgURL()), placeholderImage: UIImage(systemName: "photo"))
        return cell
    }
    
    func getHomeFeedData() {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").addSnapshotListener { (snapshot, err) in
            if err != nil {
                self.createAlert(alertTitle: "Failed Loading Home", alertMessage: "An error occured while loading your home feed. Please try again later.")
            }
            else {
                if snapshot != nil && !snapshot!.isEmpty {
                    self.posts.removeAll(keepingCapacity: false)
                    
                    for post in snapshot!.documents {
                        if let pEmail = post.get("mail") as? String {
                            if let pCaption = post.get("caption") as? String {
                                if let pImgUrl = post.get("image") as? String {
                                    self.posts.append(PostData(id: post.documentID, email: pEmail, caption: pCaption, imgURL: pImgUrl))
                                }
                            }
                        }
                    }
                    
                    self.postTable.reloadData()
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
