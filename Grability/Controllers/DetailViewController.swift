//
//  DetailViewController.swift
//  Grability
//
//  Created by Vicente de Miguel on 21/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var model : ApplicationModel!

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        syncModel()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func syncModel() {
        if model.photo!.image != nil {
            self.photo.image = model.photo?.image
        }
        self.name.text = model.name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
