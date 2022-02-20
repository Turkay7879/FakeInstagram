//
//  PostData.swift
//  FakeInstagram
//
//  Created by Türkay on 20.02.2022.
//

import Foundation

class PostData {
    
    private var id : String
    private var email : String
    private var caption : String
    private var imgURL : String
    
    init(id: String, email: String, caption: String, imgURL: String) {
        self.id = id
        self.email = email
        self.caption = caption
        self.imgURL = imgURL
    }
    
    func getId() -> String { return id }
    func getEmail() -> String { return email }
    func getCaption() -> String { return caption }
    func getImgURL() -> String { return imgURL }
}
