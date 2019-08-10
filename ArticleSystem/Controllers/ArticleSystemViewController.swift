//
//  ArticleSystemViewController.swift
//  ArticleSystem
//
//  Created by 陳博竣 on 2019/8/8.
//  Copyright © 2019 Luke. All rights reserved.
//

import UIKit
import Firebase

class ArticleSystemViewController: UIViewController {
    
    let ref = Database.database().reference(withPath: "article-items")
    
    let usersRef = Database.database().reference(withPath: "online")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func addArticleButtonTouch(_ sender: Any) {
        
        performSegue(withIdentifier: "ListToAdd", sender: nil)
        
        //        let uiTitleLabel = UILabel()
        //        uiTitleLabel.text = "標題"
        //
        //        let uiNameLabel = UILabel()
        //        uiNameLabel.text = "姓名"
        //
        //        let uiContentLabel = UILabel()
        //        uiContentLabel.text = "內容"
        //
        //        let textView = UITextView()
        //
        //        let alert = UIAlertController(title: "新文章",
        //                                      message: "請輸入標題/內容/姓名",
        //                                      preferredStyle: .alert)
        //
        //        let cancelAction = UIAlertAction(title: "Cancel",
        //                                         style: .cancel)
        //
        //        alert.view.addSubview(uiTitleLabel)
        //        alert.addTextField { textTitle in
        //            textTitle.placeholder = "Enter your Title"
        //        }
        //
        //        alert.view.addSubview(uiNameLabel)
        //        alert.addTextField { textName in
        //            textName.placeholder = "Enter your Name"
        //        }
        //
        //        alert.view.addSubview(uiContentLabel)
        //        alert.view.addSubview(textView)
        //
        //        alert.addAction(cancelAction)
        //
        //        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func signoutButtonPressed(_ sender: Any) {
        // 1
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        
        // 2
        onlineRef.removeValue { (error, _) in
            
            // 3
            if let error = error {
                print("Removing online failed: \(error)")
                return
            }
            
            // 4
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
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
