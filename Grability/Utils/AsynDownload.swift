//
//  AsynDownload.swift
//  Grability
//
//  Created by Vicente de Miguel on 20/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit


func AsyncDownLoadImageFrom(coredataObject o : PhotoModel) {
    //me pasan el objecot de Coredaa. Ahi la la url, me lo bajo y lo grabo
    //genero la url con el dato de coredata
    if let url = NSURL(string: o.url!) {
        if #available(iOS 8.0, *) {
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE,0)) { () -> Void in
                //genero la url con el dato de coredata
                
                //me bajo la foto
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        o.image = UIImage(data: data)
                        //grabo, utilizo el contexto asociado al objeto
                        _ = try! o.managedObjectContext?.save()
                    })
                }
            }
        } else {
            // Fallback on earlier versions
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), { () -> Void in
                //me bajo la foto
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        o.image = UIImage(data: data)
                        //grabo, utilizo el contexto asociado al objeto
                        _ = try! o.managedObjectContext?.save()
                    })
                }
   
            })
        }
        
        
        
    }
    



}