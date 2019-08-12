//
//  AddArticleViewController.swift
//  ArticleSystem
//
//  Created by 陳博竣 on 2019/8/8.
//  Copyright © 2019 Luke. All rights reserved.
//

import UIKit
import Firebase

class AddArticleViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "article-items")
    
    let usersRef = Database.database().reference(withPath: "online")
    
    var user: User!
    
    @IBOutlet weak var artTitle: UITextField!
    
    @IBOutlet weak var artLastName: UITextField!
    
    @IBOutlet weak var artFirstName: UITextField!
    
    @IBOutlet weak var artContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            
            let currentUserRef = self.usersRef.child(self.user.uid)
            
            currentUserRef.setValue(self.user.email)
            
            currentUserRef.onDisconnectRemoveValue()
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveArticleAction(_ sender: Any) {
        
        print("saveArticle==========>Start!!!!!")
        
        guard let title = artTitle.text,
            let lastName = artLastName.text,
            let firstName = artFirstName.text,
            let content = artContent.text  else { return }
        
        // 取得文章儲存時間
        let now: Date = Date()
        
        let dateFormat: DateFormatter = DateFormatter()
        
        dateFormat.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        
        let dateString: String = dateFormat.string(from: now)
        
        let articleItem = ArticleItem(FirstName: firstName, LastName: lastName, AddByUser: self.user.email, Title: title, Content: content, ArtDate: dateString, IsLike: false)
        
        print("========>ArticleItem:\(articleItem)")
        
        let articleItemRef = self.ref.child(title.lowercased())
        
        print("========>ArticleItemRef:\(articleItemRef)")
        
        articleItemRef.setValue(articleItem.toAnyObject())
        
        artTitle.text?.removeAll()
        artLastName.text?.removeAll()
        artFirstName.text?.removeAll()
        artContent.text?.removeAll()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
