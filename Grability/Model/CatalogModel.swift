//
//  CatalogModel.swift
//  Grability
//
//  Created by Vicente de Miguel on 18/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]
typealias JSONArray = [JSONDictionary]

class CatalogModel {
    //creo el modelo de datos que se persistiran en CoreData
    
    //stack de coredata, utilizo codigo de terceros
    var stack = AGTCoreDataStack(modelName: "Catalog")
    
    //cargo el userdefaults
    let def = NSUserDefaults.standardUserDefaults()
    
    

    
    func openWithCompletionHandler(completion:() -> Void) {
        //funcion de bajarse el json con los datos. Si ya estan cargados sale sin hacer nada, si no se los baja, lo desmenuza y lo pone en coredata

        
        //compruebo si tengo los datos cargados
        if  !def.boolForKey(IS_JSON_IN_CORE_DATA) {
            //No esta cargado, me lo bajo y lo cargo

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in

                //me bajo el json
                if let json = self.downloadJSON() {
                    //se ha bajado algo, si hay error en la conexion o no se baja nada devuelve nil
                    //aqui tengo un array y en cada elemento tengo un diccionario con la informacion, me lo recorro y lo inserto en coredata
                    _ = json.map({self.checkJSONValuesAndInsert(application: $0)})
                    
                    //termina de insertar, lo grabo
                    _ = try! self.stack.context.save()
                    
                    //guardo en userdfaults que ya esta en coredata, para no volver a leer
                    self.def.setBool(true, forKey: IS_JSON_IN_CORE_DATA)

                    
                } else {
                    //error al bajarse el json
                }
                //en primerplano
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion()
                })

            
            })

    
        } else {
            //ejecuto el completion
            completion()
        }

    }
    
    //MARK: - JSON
    func downloadJSON() -> JSONArray? {
        let url = NSURL(string: JSONUrl)!
        
        do {
            //Aqui me bajo el json y lo desmenuzo. Si se baja lo transformo, saco la unica entrada que tiene que es feed y dentro de feed me quedo con entry, que es un array con los 20 elementos que hemos pedido y de aqui dentro sacamos loque nos falta de cada aplicacion
            
            if let data = NSData(contentsOfURL: url),
                jsondata = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String:AnyObject],
                feed = jsondata["feed"] as? JSONDictionary,
                entry = feed["entry"] as? JSONArray {
                    //en entry tengo un array y cada elemento es un diccionario con los datos de cada app, lo retorno
                    return entry
                    
            }
        } catch {
            //error con el json por el motivo que sea, devuelvo nil
            return nil
        }
        //si se lo baja bien pero hay error al sacar los datos, sale por aqui
        return nil
    }
    
    func checkJSONValuesAndInsert(application a: JSONDictionary) {
        //recibo una llamadapor cada elemento del JSON, extraigolos datos y si son validos los inserto en coredata
        guard let n = a["im:name"] as? JSONDictionary,
            let name = n["label"] as? String
            else {
                return
            }
//        guard let s = a["sumary"] as? JSONDictionary,
//            let sumary = s["label"] as? String
//            else {
//                return
//        }
        
        guard let c = a["category"] as? JSONDictionary,
            let cat = c["attributes"] as? JSONDictionary,
            let category = cat["label"] as? String
            else {
                return
        }
        
        guard let p = a["im:price"] as? JSONDictionary,
            let pri = p["attributes"] as? JSONDictionary,
            let pri1 = pri["amount"] as? String ,
            let pri2 = pri["currency"] as? String,
            let price = pri1 + pri2 as? String
            else {
                return
        }
        
        
        guard let f = a["im:releaseDate"] as? JSONDictionary,
            let fe = f["attributes"] as? JSONDictionary,
            let date = fe["label"] as? String
            else {
                return
        }
        
        guard let r = a["rights"] as? JSONDictionary,
            let rights = r["label"] as? String
            else {
                return
        }
        
        guard let ph = a["im:image"]?.lastObject as? JSONDictionary,
            let photo = ph["label"] as? String
            else {
                return
        }
        
        //tengo los datos, los guardo en coredata
        ApplicationModel(name: name, category: category, price: price, date: date, rights: rights, photo: photo, context: self.context())
        
    }
    
    
    //MARK: - CoreData
    func context() -> NSManagedObjectContext{
        return stack.context
    }
    
    func setUpCoreDataStack() {
        self.stack = AGTCoreDataStack(modelName: "Catalog")
    }
    
    func applicationsFetchedController() -> NSFetchedResultsController {
        return NSFetchedResultsController(fetchRequest: self.applicationsFetchRequest(),
            managedObjectContext: self.stack.context,
            sectionNameKeyPath: nil,
            cacheName: nil)
    }
    func applicationsFetchRequest() -> NSFetchRequest {
        //fetch para buscar las aplicaciones
        let r = NSFetchRequest(entityName: ApplicationModel.entityName())
        //solo hay 20, pero bueno, se lo pongo
        r.fetchBatchSize = 20
        r.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return r
        
    }
    
    func categoriesFetchedController() -> NSFetchedResultsController {
//        return NSFetchedResultsController(fetchRequest: self.categoriesFetchRequest(),
//            managedObjectContext: self.stack.context,
//            sectionNameKeyPath: "category",
//            cacheName: nil)
        return NSFetchedResultsController(fetchRequest: self.categoriesFetchRequest(),
            managedObjectContext: self.stack.context,
            sectionNameKeyPath: "category.category",
            cacheName: nil)
    }
    func categoriesFetchRequest() -> NSFetchRequest {
        //fetch para buscar las aplicaciones
        //let r = NSFetchRequest(entityName: CategoryModel.entityName())
        let r = NSFetchRequest(entityName: ApplicationModel.entityName())
        //solo hay 20, pero bueno, se lo pongo
        r.fetchBatchSize = 20
        r.sortDescriptors = [ NSSortDescriptor(key: "category.category", ascending: true),
            NSSortDescriptor(key: "name", ascending: true) ]
        
        return r
        
    }
}