//
//  ThirdTableTableViewController.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/8.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class ThirdTableTableViewController: UITableViewController {
    
    let defaultUser = UserData(initName: "TEST1", initAccount: "aaa", initPassword: "0000", initHometown: "台灣", initCredit: 2)
    let defaultUser2 = UserData(initName: "TEST2", initAccount: "bbb", initPassword: "0000", initHometown: "台灣", initCredit: 5)
    
    var products = [ProductData]()
    var catchItem = [ProductData]()
    var postItem = [ProductData]()
    var itemShow = [ProductData]()
    var itemCount = 0
    var situation = "catched"
    
    
    
    
    @IBAction func clickCatched(_ sender: UIButton) {
        itemCount = catchItem.count
        itemShow = catchItem
        situation = "catched"
        
        tableView.reloadData()//更新頁面
    }
    
    @IBAction func clickPosted(_ sender: UIButton) {
        itemCount = postItem.count
        itemShow = postItem
        situation = "posted"
        
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let saveProduct = UserDefaults.standard
        
        //saveProduct.removeObject(forKey: "productList")
        
        if let temp = saveProduct.object(forKey: "productList2"){
            products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
        }
         for var i in 0...products.count-1{
            if products[i].buyer?.account == defaultUser.account{
                postItem.append(products[i])
            }
         }
         
         for var i in 0...products.count-1{
            if products[i].broker?.account == defaultUser.account{
                catchItem.append(products[i])
            }
         }
        //default 已承接
        itemCount = catchItem.count
        itemShow = catchItem
        
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

    //set product count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemCount + 1
    }
    
    //segue/go to detail
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            performSegue(withIdentifier: "showDetail2", sender: indexPath.row)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail2" {
            let controller = segue.destination as! DetailViewController
            controller.productData = itemShow[sender as! Int - 1]
            controller.whichController = 3
        }
        
    }

    //set items
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as! ThirdTopCell
            
            if situation == "catched"{
                cell.catched.setTitleColor(UIColor.red, for: .normal)
                cell.posted.setTitleColor(UIColor.gray, for: .normal)
            }
            else{
                cell.catched.setTitleColor(UIColor.gray, for: .normal)
                cell.posted.setTitleColor(UIColor.red, for: .normal)
            }
            cell.selectionStyle = .none
            return cell
        }

        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! ThirdDataCell
            if itemCount == 0{
                return cell
            }
            else{
                cell.productImage.image = UIImage( named: itemShow[indexPath.row - 1].picture )
                cell.productName.text = itemShow[indexPath.row - 1].store + itemShow[indexPath.row - 1].name
                if situation == "catched"{
                    cell.productInfo1.text = "購買地點："+itemShow[indexPath.row - 1].purchacePlace
                    cell.productInfo2.text = "商品原價：$\(itemShow[indexPath.row - 1].price)"
                    cell.productInfo3.text = "交貨期限："+itemShow[indexPath.row - 1].deadLine
                }
                if situation == "posted"
                {
                    cell.productInfo1.text = "出價：\(itemShow[indexPath.row - 1].offerPrice)"
                    cell.productInfo2.text = "交貨期限：$\(itemShow[indexPath.row - 1].deadLine)"
                    if itemShow[indexPath.row - 1].broker == nil{
                        cell.productInfo3.text = "狀態：尚未有人接單"
                    }
                    else{
                        cell.productInfo3.text = "狀態：\((itemShow[indexPath.row - 1].broker?.account)!)已接單"
                    }
                    
                }
                return cell
            }
        }
    }
    
    //set module lenth
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        
        return 125
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
     */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
