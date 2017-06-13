//
//  FirstTableViewController.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/24.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit
class FirstTableViewController: UITableViewController {

    var products = [ProductData]()
    
    var state = "Taiwan"
    var key = "productListT2"
    var currentUser: UserData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem.image = UIImage(named: "tab1")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage(named: "tab1")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        view.backgroundColor = UIColor(colorLiteralRed: 211/255, green: 221/255, blue: 235/255, alpha: 1.0)
        let saveProduct = UserDefaults.standard
        
        //saveProduct.removeObject(forKey: "productListT2")
        //saveProduct.removeObject(forKey: "productListC2")
        
        products.removeAll()
       
        if let temp = saveProduct.object(forKey: key){
            products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
        }
        
        saveProduct.set(false, forKey: "loginState")

        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name:NSNotification.Name(rawValue: "catch"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name:NSNotification.Name(rawValue: "reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userDidExist(noti:)), name: Notification.Name("userLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userNotExist(noti:)), name: Notification.Name("userLogout"), object: nil)
 
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
 
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func reloadTableData(_ notification: Notification){
        products.removeAll()
        let saveProduct = UserDefaults.standard

        if let temp = saveProduct.object(forKey: key){
            products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
        }
        tableView.reloadData()
    }
    
    func userDidExist(noti:Notification){
        currentUser = noti.userInfo!["PASS"] as? UserData
    }
    
    func userNotExist(noti:Notification){
        currentUser = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as! FirstTopCell
            cell.selectionStyle = .none
            cell.startPlace.tag = 0
            
            cell.direction.addTarget(self, action: #selector(changeDirection), for: .touchUpInside)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! FirstDataCell
            
            cell.productImage.image = UIImage(named: products[indexPath.row - 1].picture)
            cell.productName.text = products[indexPath.row - 1].store + products[indexPath.row - 1].name
            cell.productDueDate.text! = products[indexPath.row - 1].deadLine
            cell.productPrice.text = "$\(products[indexPath.row - 1].total)"
            
            if ((products[indexPath.row - 1].buyer)?.credit)! >= 1 {
                cell.star1.image = #imageLiteral(resourceName: "star")
            }
            if ((products[indexPath.row - 1].buyer)?.credit)! >= 2 {
                cell.star2.image = #imageLiteral(resourceName: "star")
            }
            if ((products[indexPath.row - 1].buyer)?.credit)! >= 3 {
                cell.star3.image = #imageLiteral(resourceName: "star")
            }
            if ((products[indexPath.row - 1].buyer)?.credit)! >= 4 {
                cell.star4.image = #imageLiteral(resourceName: "star")
            }
            if ((products[indexPath.row - 1].buyer)?.credit)! >= 5 {
                cell.star5.image = #imageLiteral(resourceName: "star")
            }
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        
        return 125
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //(tableView.cellForRow(at: indexPath) as! FirstTopCell).isSelected = false
        }
        else{
            performSegue(withIdentifier: "showDetail", sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! DetailViewController
            controller.productData = products[sender as! Int - 1]
            controller.whichController = 1
            controller.state = state
            controller.key = key
            if currentUser != nil
            {
                controller.currentUser = currentUser
            }
        }
        
    }

    @IBAction func changeDirection(sender: UIButton){
        if state == "Taiwan"
        {
            sender.setImage(UIImage(named: "back"), for: .normal)
            state = "China"
            key = "productListC2"
        }
        else
        {
            sender.setImage(UIImage(named: "go"), for: .normal)
            state = "Taiwan"
            key = "productListT2"
        }
        viewDidLoad()
        tableView.reloadData()
    }

}
