//
//  ArticleItem.swift
//  ArticleSystem
//
//  Created by 陳博竣 on 2019/8/10.
//  Copyright © 2019 Luke. All rights reserved.
//

import Foundation
import Firebase

struct ArticleItem {

    let ref: DatabaseReference?
    let key: String
    let firstName: String
    let lastName: String
    let addByUser: String
    let title: String
    let content: String
    let artDate: String

    init(FirstName firstName: String, LastName lastName: String, AddByUser addByUser: String, Title title: String, Content content: String, ArtDate artDate: String, Key key: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.addByUser = addByUser
        self.title = title
        self.content = content
        self.artDate = artDate
        self.ref = nil
        self.key = key
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let addByUser = value["addByUser"] as? String,
            let title = value["title"] as? String,
            let content = value["content"] as? String,
            let artDate = value["artDate"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.addByUser = addByUser
        self.title = title
        self.content = content
        self.artDate = artDate
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName" : firstName,
            "lastName" : lastName,
            "addByUser" : addByUser,
            "title" : title,
            "content" : content,
            "artDate" : artDate
        ]
    }
    
    
    
    
}
