//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Vichet Meng on 10/29/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    var instagramPost: PFObject! {
        didSet {
            photoImageView.file = instagramPost["media"] as? PFFile
            photoImageView.loadInBackground()
            captionLabel.text = (instagramPost as! Post).caption
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
