//
//  ViewController.swift
//  CoreDataSample
//
//  Created by Sharvan Kumawat on 24/02/18.
//  Copyright © 2018 Sharvan Kumawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var users = [UserModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.estimatedRowHeight = 44
        table.separatorStyle = .singleLine

        table.rowHeight = UITableViewAutomaticDimension
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewUser))
        self.navigationItem.rightBarButtonItem = btnAdd
        
        let btnDelete = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(deleteAll))
        self.navigationItem.leftBarButtonItem = btnDelete
    }
    @objc func addNewUser(){
        let vc = UserDetails.storyboardInstance()
        vc.index = users.count + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func deleteAll(){
       CoreDataManager.deleteAllUserData(entityName: "User")
        users.removeAll()
        users = CoreDataManager.getUsers()
         table.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        users.removeAll()
        users = CoreDataManager.getUsers()
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.table.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        
        let user = self.users[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        cell.lblUser.text = "\(user.name) \n \(user.email) \n \(user.phone)"
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserDetails.storyboardInstance()
        vc.user = self.users[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

