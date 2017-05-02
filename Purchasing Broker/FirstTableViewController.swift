//
//  FirstTableViewController.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/24.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    let defaultUser = UserData(initName: "TEST1", initAccount: "aaa", initPassword: "0000", initHometown: "台灣", initCredit: 2)
    let defaultUser2 = UserData(initName: "TEST2", initAccount: "bbb", initPassword: "0000", initHometown: "台灣", initCredit: 5)

    var products = [ProductData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaultProduct = ProductData(initName: "裕珍馨鳳梨酥禮盒(10入)", initNumber: 2, initPrice: 210, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: defaultUser, initPicture: "鳳梨酥", initDeadLine: "2017/07/20")
        let defaultProduct2 = ProductData(initName: "裕珍馨奶油酥餅(3入)", initNumber: 5, initPrice: 120, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: defaultUser, initPicture: "奶油酥餅", initDeadLine: "2017/06/30")
        let defaultProduct3 = ProductData(initName: "伊蕾特布丁奶酪(鮮奶布丁)", initNumber: 10, initPrice: 38, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: defaultUser, initPicture: "布丁奶酪", initDeadLine: "2017/07/04")
        let defaultProduct4 = ProductData(initName: "伊蕾特乳酪塔(6入)", initNumber: 2, initPrice: 390, initDestination: "中國", initPurchacePlace: "台灣", initBuyer: defaultUser2, initPicture: "雪藏乳酪塔", initDeadLine: "2017/07/12")
        
        let saveProduct = UserDefaults.standard

        if let temp = saveProduct.object(forKey: "productList"){
            products = temp as! [ProductData]
        }
        
        products.append(defaultProduct)
        products.append(defaultProduct2)
        products.append(defaultProduct3)
        products.append(defaultProduct4)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

            cell.startPlace.tag = 0
            
            cell.startPlace.addTarget(self, action: #selector(changeStartPlace), for: .touchUpInside)
            cell.direction.addTarget(self, action: #selector(changeDirection), for: .touchUpInside)
            cell.destination.addTarget(self, action: #selector(changeDestination), for: .touchUpInside)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! FirstDataCell
            
            cell.productImage.image = UIImage( named: products[indexPath.row - 1].picture )
            cell.productName.text = products[indexPath.row - 1].name
            cell.productDueDate.text = products[indexPath.row - 1].deadLine
            cell.productPrice.text = "$\(products[indexPath.row - 1].total)"
            
            if (products[indexPath.row - 1].buyer).credit >= 1 {
                cell.star1.image = #imageLiteral(resourceName: "star")
            }
            if (products[indexPath.row - 1].buyer).credit >= 2 {
                cell.star2.image = #imageLiteral(resourceName: "star")
            }
            if (products[indexPath.row - 1].buyer).credit >= 3 {
                cell.star3.image = #imageLiteral(resourceName: "star")
            }
            if (products[indexPath.row - 1].buyer).credit >= 4 {
                cell.star4.image = #imageLiteral(resourceName: "star")
            }
            if (products[indexPath.row - 1].buyer).credit >= 5 {
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
        if indexPath.row != 0 {
            performSegue(withIdentifier: "showDetail", sender: indexPath.row)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! DetailViewController
            controller.productData = products[sender as! Int - 1]
        }
        
    }

    @IBAction func changeStartPlace(sender: UIButton){
        sender.setTitle("hi", for: .normal)
    }
    
    @IBAction func changeDirection(sender: UIButton){
        sender.setTitle("<-", for: .normal)
    }
    
    @IBAction func changeDestination(sender: UIButton){
        sender.setTitle("hi", for: .normal)
    }

}
