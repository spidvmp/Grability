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
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var rights: UILabel!
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
        self.summary.text = model.summary
        self.date.text = model.date
        self.rights.text = model.rights
        self.price.text = model.price
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
