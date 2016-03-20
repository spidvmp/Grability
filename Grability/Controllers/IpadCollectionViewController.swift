//
//  IpadCollectionViewController.swift
//  Grability
//
//  Created by Vicente de Miguel on 18/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class IpadCollectionViewController: UICollectionViewController {

    //el modelo:
    var model : CatalogModel!
    //activityindicator
    var loadingView : UIActivityIndicatorView? = nil
    //bool para saber si tengo que mostrar por categorias o por nombres
    var showByCategory : Bool = false
    //tengo un fetchresultscontroller
    var fc : NSFetchedResultsController!
    
    
    //MARK: - Inicializadores
    convenience init(collectionViewLayout layout: UICollectionViewLayout, model: CatalogModel) {
        self.init(collectionViewLayout: layout)
        self.model = model
        self.fc = NSFetchedResultsController()
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.title = "Catalogo"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        //self.collectionViewLayout = UICollectionViewLayout()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //registro la celda
        registerNib()
        
        //creo el boton para cambiar la vista de la tabla de tags a alfabetico, no le doy valor xq se actualizara en el willappear
        let menu_button = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain , target: self, action: "cambiaVista")
        self.navigationItem.rightBarButtonItem = menu_button
        
        self.loadingView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.loadingView!.center = self.view.center
        self.collectionView!.addSubview(self.loadingView!)
        self.loadingView?.startAnimating()
        
        // para que los resultados se muestren sobre mi vista, sino lo harian sobre el rootVC
        self.definesPresentationContext = true

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //cargamos el modelo
        self.model.openWithCompletionHandler { () -> Void in
            
            //eliminamos el loadingactivity
            self.loadingView?.stopAnimating()
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
            
            
            if self.showByCategory {
                self.navigationItem.rightBarButtonItem!.title = "Aplicaciones"
                //defino el fetchedresults
                self.fc = self.model.categoriesFetchedController()
                
            } else {
                self.navigationItem.rightBarButtonItem!.title = "Categorias"
                self.fc = self.model.applicationsFetchedController()
                
            }
            
            _ = try! self.fc.performFetch()
            self.collectionView!.reloadData()
            
        }
        
        // Do any additional setup after loading the view.
        self.collectionView!.backgroundColor = UIColor.whiteColor()
    }
    


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if let a = self.fc.sections {
            return a.count
        } else {
            return 0
        }
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.fc.sections![section].numberOfObjects
    }
    
    

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //obtengo el objeto a mostrar
        let app = self.fc.objectAtIndexPath(indexPath) as! ApplicationModel
        
        //creo la celda
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CollectionCell.cellID(), forIndexPath: indexPath) as! CollectionCell

        //le paso el objeto coredata para que se muestre
        cell.observeApp(app)
        
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    //MARK: - Utils
    func registerNib() {
        let nib = UINib(nibName: "CollectionCell", bundle: NSBundle.mainBundle())
        self.collectionView!.registerNib(nib, forCellWithReuseIdentifier: CollectionCell.cellID())
    }
    
    
    //MARK: - Actions
    func cambiaVista() {
        showByCategory = !showByCategory
        
        if showByCategory {
            self.navigationItem.rightBarButtonItem!.title = "Aplicaciones"
            self.fc = self.model.categoriesFetchedController()
        } else {
            self.navigationItem.rightBarButtonItem!.title = "Categorias"
            self.fc = self.model.applicationsFetchedController()
        }
        
        _ = try! self.fc.performFetch()
        collectionView!.reloadData()
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return [UIInterfaceOrientationMask.Portrait]
       
    }

}
