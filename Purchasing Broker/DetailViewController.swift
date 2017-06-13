//
//  DetailViewController.swift
//  Purchasing Broker
//
//  Created by Adam Hung on 2017/4/30.
//  Copyright © 2017年 Adam Hung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var productData: ProductData? = nil
    var whichController: Int? = nil
    
    @IBOutlet weak var productPicture: UIImageView!
    @IBOutlet weak var productNumber: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var productOrigin: UILabel!
    @IBOutlet weak var productDeadLine: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var getOrderBtn: UIButton!
    
    var currentUser: UserData? = nil
    var products = [ProductData]()
    var state = "Taiwan"
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(colorLiteralRed: 211/255, green: 221/255, blue: 235/255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
        
        self.title = (productData?.store)! + (productData?.name)!
        productPicture.image = UIImage(named: (productData?.picture)!)
        productNumber.text = "\((productData?.number)!)"
        productPrice.text = "$\((productData?.price)!)"
        totalPrice.text = "$\((productData?.total)!)"
        offerPrice.text = "$\((productData?.offerPrice)!)"
        productOrigin.text = "\((productData?.buyer?.account)!)"
        productDeadLine.text = (productData?.deadLine)!
        
        if (productData?.buyer)!.credit >= 1 {
            star1.image = #imageLiteral(resourceName: "star")
        }
        if (productData?.buyer)!.credit >= 2 {
            star2.image = #imageLiteral(resourceName: "star")
        }
        if (productData?.buyer)!.credit >= 3 {
            star3.image = #imageLiteral(resourceName: "star")
        }
        if (productData?.buyer)!.credit >= 4 {
            star4.image = #imageLiteral(resourceName: "star")
        }
        if (productData?.buyer)!.credit >= 5 {
            star5.image = #imageLiteral(resourceName: "star")
        }
        
        if whichController! == 3 {
            getOrderBtn.isHidden = true
            getOrderBtn.isEnabled = false
        }
        
        if productData?.broker == nil
        {
            if currentUser == nil
            {
                getOrderBtn.isEnabled = false
            }
            else
            {
                getOrderBtn.isEnabled = true
            }
        }
        else
        {
            getOrderBtn.isEnabled = false
            getOrderBtn.setTitle("已被承接", for: .normal)
            getOrderBtn.setTitleColor(UIColor.red, for: .normal)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getOrder(_ sender: Any) {
        let saveProduct = UserDefaults.standard
        products.removeAll()
        if let temp = saveProduct.object(forKey: key){
            products = NSKeyedUnarchiver.unarchiveObject(with: temp as! Data) as! [ProductData]
        }
        var j = 0
        for var i in 0...products.count-1
        {
            if products[i].buyer?.account == productData?.buyer?.account && products[i].name == productData?.name
            {
                j = i
                products[i].setBroker(brokerCatch: currentUser!)
                //productData?.broker = currentUser
            }
        }
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: products)
        print(products[j].broker!)
        saveProduct.set(encodedData, forKey: key)
        
        getOrderBtn.isEnabled = false
        getOrderBtn.setTitle("已被承接", for: .normal)
        getOrderBtn.setTitleColor(UIColor.red, for: .normal)
        
        NotificationCenter.default.post(name: Notification.Name("catch"), object: nil)
        
        viewDidLoad()

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
