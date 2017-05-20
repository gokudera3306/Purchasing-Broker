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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = (productData?.store)! + (productData?.name)!
        productPicture.image = UIImage(named: (productData?.picture)!)
        productNumber.text = "\((productData?.number)!)"
        productPrice.text = "$\((productData?.price)!)"
        totalPrice.text = "$\((productData?.total)!)"
        offerPrice.text = "$\((productData?.offerPrice)!)"
        productOrigin.text = (productData?.purchacePlace)!
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getOrder(_ sender: Any) {
        let saveProduct = UserDefaults.standard
        
        //存入使用者
        
        //存入記憶體
        
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
