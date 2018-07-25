//
//  TrendsViewController.swift
//  XapoTest
//
//  Created by Arthur Henrique Vieira de Oliveira on 24/07/18.
//  Copyright © 2018 Arthur Henrique Vieira de Oliveira. All rights reserved.
//

import UIKit

class TrendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let rest = GitHubApi()
    var refreshControl: UIRefreshControl!
    var projects = [Project]()
    var project: Project!
    var searchedProjects: [Project] {
        
        let search = searchBar.text!.lowercased()
        if search.isEmpty {
            return projects
        } else {
            return projects.filter( { $0.fullName.lowercased().contains(search) } )
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRefreshControl()
        
        update()
        
        tableView.register(UINib.init(nibName: "ProjectTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "projectCell")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProjectViewController {
            vc.project = project
        }
    }
    
    func update() {
        refreshControl.beginRefreshing()
        rest.getAll(success: { projects in
            self.projects = projects
            
            self.tableView.reloadData()
            
            self.refreshControl.endRefreshing()
        }) { error in
            self.refreshControl.endRefreshing()
        }
    }
    
    func setRefreshControl() -> Void {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.38, green:0.49, blue:0.54, alpha:1.0)
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refreshControl)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedProjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectTableViewCell
        
        let project = searchedProjects[indexPath.row]
        
        cell.nameLabel.text = project.fullName
        cell.descriptionLabel.text = project.description
        cell.starsLabel.text = String(project.watchers)
        cell.forksLabel.text = String(project.forks)
        
        cell.startImageView.image = UIImage(named: "star")!.withRenderingMode(.alwaysTemplate)
        cell.startImageView.tintColor = UIColor.lightGray
        
        cell.forkImageView.image = UIImage(named: "fork")!.withRenderingMode(.alwaysTemplate)
        cell.forkImageView.tintColor = UIColor.lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        project = searchedProjects[indexPath.row]
        performSegue(withIdentifier: "projectSegue", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        update()
    }
}
