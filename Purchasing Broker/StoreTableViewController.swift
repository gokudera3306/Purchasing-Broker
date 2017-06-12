//
//  StoreTableViewController.swift
//  Purchasing Broker
//
//  Created by 連翊涵 on 2017/5/19.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class StoreTableViewController: UITableViewController {
    
    let defaultProduct1 = dataBaseData(initStore: "裕珍馨", initName: "鳳梨酥禮盒(10入)", initPrice: 210, initPurchacePlace: "台灣", initPicture: "鳳梨酥")
    let defaultProduct2 = dataBaseData(initStore: "裕珍馨",initName: "奶油酥餅(3入)", initPrice: 120, initPurchacePlace: "台灣", initPicture: "奶油酥餅")
    let defaultProduct3 = dataBaseData(initStore: "依蕾特",initName: "鮮奶布丁禮盒(12入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "布丁奶酪")
    let defaultProduct4 = dataBaseData(initStore: "依蕾特",initName: "可可奶酪禮盒(12入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "可可奶酪")
    let defaultProduct5 = dataBaseData(initStore: "依蕾特",initName: "芒果奶酪禮盒(12入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "芒果奶酪")
    let defaultProduct6 = dataBaseData(initStore: "依蕾特",initName: "芝麻奶酪禮盒(12入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "芝麻奶酪")
    let defaultProduct7 = dataBaseData(initStore: "依蕾特",initName: "雪藏原味乳酪塔(6入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "雪藏原味乳酪塔")
    let defaultProduct8 = dataBaseData(initStore: "依蕾特",initName: "可可經典乳酪塔(6入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "可可乳酪塔")
    let defaultProduct9 = dataBaseData(initStore: "依蕾特",initName: "檸檬乳酪塔(6入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "檸檬乳酪塔")
    let defaultProduct10 = dataBaseData(initStore: "依蕾特",initName: "抹茶紅豆乳酪塔(6入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "抹茶紅豆乳酪塔")
    let defaultProduct11 = dataBaseData(initStore: "依蕾特",initName: "草莓乳酪塔(6入)", initPrice: 390, initPurchacePlace: "台灣", initPicture: "草莓乳酪塔")
 
    
    let defaultProduct12 = dataBaseData(initStore: "鼎丰真",initName: "椰条300g", initPrice: 14, initPurchacePlace: "中國大陸", initPicture: "椰條")
    let defaultProduct13 = dataBaseData(initStore: "鼎丰真",initName: "格子曲奇饼干200g", initPrice: 14, initPurchacePlace: "中國大陸", initPicture: "格子曲奇")
    let defaultProduct14 = dataBaseData(initStore: "鼎丰真",initName: "椰丝曲奇饼干200g", initPrice: 14, initPurchacePlace: "中國大陸", initPicture: "椰絲曲奇")
    
    var dataBase = [dataBaseData]()
    var dataPass = [dataBaseData]()
    var storeNameT = ["裕珍馨", "依蕾特"]
    var storeNameC = ["鼎丰真"]
    var storeName = ["裕珍馨", "依蕾特"]

    var state = "Taiwan"
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let saveProduct = UserDefaults.standard
        
        //saveProduct.removeObject(forKey: "dataBaseData")
        if state == "Taiwan"
        {
            if let temp = saveProduct.object(forKey: "dataBaseData")
            {
                dataBase = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [dataBaseData]
            }
            
//            dataBase.append(defaultProduct1)
//            dataBase.append(defaultProduct2)
//            dataBase.append(defaultProduct3)
//            dataBase.append(defaultProduct4)
//            dataBase.append(defaultProduct5)
//            dataBase.append(defaultProduct6)
//            dataBase.append(defaultProduct7)
//            dataBase.append(defaultProduct8)
//            dataBase.append(defaultProduct9)
//            dataBase.append(defaultProduct10)
//            dataBase.append(defaultProduct11)
            
            let encodeDate = NSKeyedArchiver.archivedData(withRootObject: dataBase)
            saveProduct.set(encodeDate, forKey: "dataBaseData")
            
            storeName = storeNameT
        }
        else
        {
            if let temp = saveProduct.object(forKey: "dataBaseDataC")
            {
                dataBase = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [dataBaseData]
            }
            
//            dataBase.append(defaultProduct12)
//            dataBase.append(defaultProduct13)
//            dataBase.append(defaultProduct14)
            
            let encodeDate = NSKeyedArchiver.archivedData(withRootObject: dataBase)
            saveProduct.set(encodeDate, forKey: "dataBaseDataC")
            
            storeName = storeNameC
        }
        
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
        return storeName.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! storeDataCell
        cell.storeName.text = storeName[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "showItem" {
            let controller = segue.destination as! ProductTableViewController
            controller.dataShow = dataPass
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataPass.removeAll()
        for var i in 0...dataBase.count-1
        {
            if dataBase[i].store == storeName[indexPath.row]
            {
                dataPass.append(dataBase[i])
            }
        }
        performSegue(withIdentifier: "showItem", sender: indexPath.row)
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
