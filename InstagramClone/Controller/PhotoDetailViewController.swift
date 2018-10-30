//
//  PhotoDetailViewController.swift
//  InstagramClone
//
//  Created by Vichet Meng on 10/29/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoDetailViewController: UIViewController {
    @IBOutlet weak var photoImageView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post:PFObject! {
        didSet{
            setupViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        photoImageView?.file = post["media"] as? PFFile
        photoImageView?.loadInBackground()
        //let createdAt = post["_created_at"] as! [String:Any]
        //timestampLabel?.text = createdAt["$date"] as? String
        captionLabel?.text = (post as! Post).caption
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
