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
    var stack : AGTCoreDataStack!
    
    //cargo el userdefaults
    let def = NSUserDefaults.standardUserDefaults()
    
    func openWithCompletionHandler(completion:( res : String) -> Void) {
        //funcion de bajarse el json con los datos. Si ya estan cargados sale sin hacer nada, si no se los baja, lo desmenuza y lo pone en coredata
        
        print("Entro en CatalogModel completionhandler")
        
        //compruebo si tengo los datos cargados
        if  !def.boolForKey(IS_JSON_IN_CORE_DATA) {
            //No esta cargado, me lo bajo y lo cargo
            print("No esta cargado")
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                
                //me bajo el json
                if let json = self.downloadJSON() {
                    //se ha bajado algo, si hay error en la conexion o no se baja nada devuelve nil
                    
                    
                    
                } else {
                    //error al bajarse el json
                }
                //en primerplano
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(res: "Ha terminado")
                })

            
            })
            print("despues del dispatch")
    
        }
        print("Acabo el openWitj")
    }
    
    //MARK: - JSON
    func downloadJSON() -> JSONDictionary? {
        let url = NSURL(string: JSONUrl)!
        
        do {
            //Aqui me bajo el json y lo desmenuzo. Si se baja lo transformo, saco la unica entrada que tiene que es feed y dentro de feed me quedo con entry, que es un array con los 20 elementos que hemos pedido y de aqui dentro sacamos loque nos falta de cada aplicacion

            if let data = NSData(contentsOfURL: url),
                jsondata = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String:AnyObject],
                feed = jsondata["feed"] as? JSONDictionary,
                entry = feed["entry"] as? JSONArray
            {
                //en entry tengo un array y cada elemento es un diccionario con los datos de cada app
                entry.map({print($0["im:name"])})
                
                //print(entry)
                
                
            }
        } catch {
            //error con el json por el motivo que sea, devuelvo nil
            return nil
        }
        
        return nil
    }
    
    //MARK: - CoreData
    func context() -> NSManagedObjectContext{
        return stack.context
    }
    
    func setUpCoreDataStack() {
        self.stack = AGTCoreDataStack(modelName: "Catalog")
    }
}