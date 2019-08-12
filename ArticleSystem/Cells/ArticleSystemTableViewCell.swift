//
//  ArticleSystemTableViewCell.swift
//  ArticleSystem
//
//  Created by 陳博竣 on 2019/8/12.
//  Copyright © 2019 Luke. All rights reserved.
//

import UIKit

class ArticleSystemTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleContent: UILabel!
    
    @IBOutlet weak var isLikeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
