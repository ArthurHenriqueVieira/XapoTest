//
//  ProjectViewController.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftyMarkdown

class ProjectViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var desriptionLabel: UILabel!
    @IBOutlet weak var readmeView: UITextView!
    @IBOutlet weak var readmeViewHeight: NSLayoutConstraint!
    @IBOutlet weak var startsButton: UIButton!
    @IBOutlet weak var forksButton: UIButton!
    
    var project: Project!
    let gitRest = GitHubApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = project.name
        
        let user = project.owner!
        userNameLabel.text = user.login
        desriptionLabel.text = project.description
        startsButton.setTitle(String(project.watchers) + " stars", for: .normal)
        forksButton.setTitle(String(project.forks) + " forks", for: .normal)
        let url = URL(string: user.avatarUrl)
        userImageView.af_setImage(withURL: url!, placeholderImage: UIImage(named: "user.png"))
        
        gitRest.getReadmeDownloadUrl(user.login,
                                     project.name,
                                     success: { url in
                                        self.getReadme(url)
                                        
        }) { error in
        }
        
        readmeView.addObserver(self, forKeyPath: "contentSize", options: [.new, .old, .prior], context: nil)

    }
    
    @objc override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            self.readmeViewHeight.constant = self.readmeView.contentSize.height
        }
    }
    
    func getReadme(_ url: String) {
        gitRest.getReadme(url,
                          success: { readme in
                            let md = SwiftyMarkdown(string: readme)
                            
                            self.readmeView.attributedText = md.attributedString()
        }, failure: { error in
            
        })
    }

}
