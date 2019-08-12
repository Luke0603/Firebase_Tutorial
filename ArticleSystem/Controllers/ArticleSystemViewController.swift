//
//  ArticleSystemViewController.swift
//  ArticleSystem
//
//  Created by 陳博竣 on 2019/8/8.
//  Copyright © 2019 Luke. All rights reserved.
//

import UIKit
import Firebase

class ArticleSystemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ref = Database.database().reference(withPath: "article-items")
    
    let usersRef = Database.database().reference(withPath: "online")
    
    var items: [ArticleItem] = []
    
    @IBOutlet weak var articleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.allowsMultipleSelectionDuringEditing = false
        
        ref.observe(.value, with: { snapshot in
            
            var newItems: [ArticleItem] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let groceryItem = ArticleItem(snapshot: snapshot) {
                    newItems.append(groceryItem)
                }
            }
            
            self.items = newItems
            print("============> items: \(self.items)")
            self.articleTableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    @IBAction func addArticleButtonTouch(_ sender: Any) {
        
        performSegue(withIdentifier: "ListToAdd", sender: nil)
        
    }
    
    @IBAction func signoutButtonPressed(_ sender: Any) {
        
        let user = Auth.auth().currentUser!
        let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
        
        onlineRef.removeValue { (error, _) in
            
            if let error = error {
                print("Removing online failed: \(error)")
                return
            }
            
            
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch (let error) {
                print("Auth sign out failed: \(error)")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("===========> items.count: \(self.items.count)")
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell = UITableViewCell()
        
        if let articleCell = articleTableView.dequeueReusableCell(withIdentifier: "articleTableViewCell") as? ArticleSystemTableViewCell {
            let articleItem = self.items[indexPath.item]
            
            articleCell.articleTitle.text = articleItem.title
            articleCell.articleContent.text = articleItem.content
            
            articleCell.isLikeButton.tag = indexPath.item
            
            articleCell.isLikeButton.addTarget(self,action: #selector(ArticleSystemViewController.likeButtonClicked(_:)), for: .touchUpInside)
            
            //設置圓角
            articleCell.isLikeButton.layer.masksToBounds = true
            articleCell.isLikeButton.layer.cornerRadius = 10
            //邊框粗細
            articleCell.isLikeButton.layer.borderWidth = 0.5
            //設置邊框
            articleCell.isLikeButton.layer.borderColor = UIColor.black.cgColor
            
            if articleItem.isLike {
                articleCell.isLikeButton.backgroundColor = .red
            } else {
                articleCell.isLikeButton.backgroundColor = .yellow
            }
            
            cell = articleCell
        }
        return cell
    }
    
    @objc func likeButtonClicked(_ sender:UIButton)
    {
        print("==============> sender.tag: \(sender.tag)")
        
        var articleItem = self.items[sender.tag]
        
        let articleItemRef = self.ref.child(articleItem.title.lowercased())
        
        if articleItem.isLike {
            articleItem.isLike = false
            sender.backgroundColor = .yellow
        } else {
            articleItem.isLike = true
            sender.backgroundColor = .red
        }
        
        articleItemRef.setValue(articleItem.toAnyObject())
        
        self.articleTableView.reloadData()
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
