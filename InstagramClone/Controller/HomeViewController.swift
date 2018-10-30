//
//  HomeViewController.swift
//  Instagram
//
//  Created by Vichet Meng on 10/28/18.
//  Copyright © 2018 Vichet Meng. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let refreshControl = UIRefreshControl()
    var posts: [PFObject]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    var selectedPost: PFObject?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    @objc func refreshControlAction(_ refreshControl:UIRefreshControl) {
        fetchPosts()
    }
    
    func fetchPosts() {
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.limit = 20
        query?.includeKey("author")
        
        query?.findObjectsInBackground(block: { (posts:[PFObject]?, error:Error?) in
            if let posts = posts {
                self.posts = posts
            } else {
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            self.refreshControl.endRefreshing()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifer = segue.identifier {
            switch identifer {
            case "ShowPhotoDetail":
                if let dvc = segue.destination as? PhotoDetailViewController {
                    dvc.post = selectedPost
                }
            default:
                break
            }
        }
    }

    // MARK: - UITableView delegate and datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoTableViewCell
        if let posts = posts {
            cell.instagramPost = posts[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPost = posts?[indexPath.row]
        if selectedPost != nil {
            performSegue(withIdentifier: "ShowPhotoDetail", sender: self)
        } else {
            print("selectedPost is nil")
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
