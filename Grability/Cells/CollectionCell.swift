//
//  CollectionCell.swift
//  Grability
//
//  Created by Vicente de Miguel on 20/3/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var appLbl: UITextView!
    
    //me creo un modelo que sera la app en coredata que he de observar por si hay cambio de imagen
    var appModel: ApplicationModel! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        //limpiamos los valores
        self.appModel.removeObserver(self, forKeyPath: "photo.data")
        self.appModel = nil
        self.appLbl.text = nil
        
    }
    
    
    //MARK: - KVO para cuando se actualice la imagen
    func observeApp(app: ApplicationModel) {
        
        //me han pasado el objeto de coredata, asigno los valores a lo que tengo que mostrar
        self.appModel = app
        self.appLbl.text = self.appModel.name
        self.appLbl.textAlignment = .Center
        //conprobamos si tenemos imagen,
        if self.appModel.photo!.image != nil {
            //tenemos foto, la ponemos
            self.photoView.image = self.appModel.photo!.image
        }
        
        //observamos el valor de la imagen
        self.appModel.addObserver(self,
            forKeyPath: "photo.data",
            options: .New ,
            context: nil)
        
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        //ha cambiado la imagen, la cambio
        UIView.transitionWithView(self.photoView!, duration: 0.5, options: .TransitionCrossDissolve , animations: { () -> Void in
            self.photoView?.image = self.appModel.photo?.image
            }) { (Bool) -> Void in
                
        }
    }
    
    //MARK: - funciones de clase para obtener la altura y el nombre de la celda
    class func height() -> CGFloat {
        return 143
    }
    
    class func width() -> CGFloat {
        return 120
    }
    
    class func cellID() -> String {
        return String(self)
    }
}
