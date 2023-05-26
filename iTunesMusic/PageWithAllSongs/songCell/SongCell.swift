//
//  SongCell.swift
//  iTunesMusic
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import UIKit

class SongCell: UITableViewCell {


    @IBOutlet var imageOnCell: UIImageView!
    
    @IBOutlet var songName: UILabel!
    
    @IBOutlet var authorName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
  
        //imageOnCell.layer.cornerRadius = 37.5
    }

//
    
}
