//
//  ViewController.swift
//  Grability
//
//  Created by Vicente de Miguel on 18/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var iphoneController : IphoneTableViewController? = nil
    var ipadController : IpadCollectionViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        switch (UIDevice.currentDevice().userInterfaceIdiom) {
        case .Phone:
            iphoneController = IphoneTableViewController()
            self.view.addSubview((iphoneController?.tableView)!)
            break
        case .Pad:
            //genero el layout
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 90, height: 90)
            
            //layout.s
            ipadController = IpadCollectionViewController(collectionViewLayout: layout)
            
            self.view.addSubview((ipadController?.collectionView)!)
            break
        default:
            print("error")
   
        }


    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if  UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return [UIInterfaceOrientationMask.LandscapeLeft,UIInterfaceOrientationMask.LandscapeRight]
        } else {
            return [UIInterfaceOrientationMask.Portrait]
        }
    
    }
}

