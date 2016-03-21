//
//  IphoneTableViewController.swift
//  Grability
//
//  Created by Vicente de Miguel on 18/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit


class IphoneTableViewController: UITableViewController {
    
    //el modelo:
    var model : CatalogModel!
    //activityindicator
    var loadingView : UIActivityIndicatorView? = nil
    //bool para saber si tengo que mostrar por categorias o por nombres
    var showByCategory : Bool = false
    //tengo un fetchresultscontroller
    var fc : NSFetchedResultsController!
    
    
    //MARK: - Inicializadores
    convenience init(model: CatalogModel){
        self.init()
        self.model = model
        self.fc = NSFetchedResultsController()
        
    }
    
    init() {
        super.init(style: .Plain)
        self.title = "Catalogo"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //registro la celda
        registerNib()

        //creo el boton para cambiar la vista de la tabla de tags a alfabetico, no le doy valor xq se actualizara en el willappear
        let menu_button = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain , target: self, action: "cambiaVista")
        self.navigationItem.rightBarButtonItem = menu_button
        
        self.loadingView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.loadingView!.center = self.view.center
        self.tableView.addSubview(self.loadingView!)
        self.loadingView?.startAnimating()
        
        // para que los resultados se muestren sobre mi vista, sino lo harian sobre el rootVC
        self.definesPresentationContext = true
        
        //configuro el alto de las celdas
        self.tableView.rowHeight = TableViewCell.height()
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
            self.tableView.reloadData()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //obtengo el objeto pulsado
        let app = self.fc.objectAtIndexPath(indexPath) as! ApplicationModel
        
        //creo el controlador de detalle
        let det = DetailViewController(nibName: "iPhoneDetailViewController", bundle: nil)
        det.model = app
        navigationController?.pushViewController(det, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let a = self.fc.sections {
            return a.count
        } else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.fc.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if showByCategory {
            return self.fc.sections![section].name
        } else {
            return "Aplicaciones"
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //obtengo el objeto a mostrar
        let app = self.fc.objectAtIndexPath(indexPath) as! ApplicationModel
        
        //creo la celda
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.cellID(), forIndexPath: indexPath) as! TableViewCell
        
        //le paso el objeto coredata para que se muestre
        cell.observeApp(app)
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


    //MARK: - Utils
    func registerNib() {
        let nib = UINib(nibName: "TableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(nib, forCellReuseIdentifier: TableViewCell.cellID())
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
        tableView.reloadData()
        
    }


}
