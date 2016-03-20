import UIKit

@objc(PhotoModel)
public class PhotoModel: _PhotoModel {

	// Custom logic goes here.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(url: String, context c: NSManagedObjectContext) {
        super.init(entity: _PhotoModel.entity(c), insertIntoManagedObjectContext: c)
        self.url = url
    }
    
    var image: UIImage? {
        set(img){
            //Me asignan un valor, lo guardo como NSData
            guard (img != nil) else {
                return
            }
            
            //tengo una imagen
            self.data = UIImageJPEGRepresentation(img!, 0.9)
            
            
        }
        get {
            //saco el valor que es un NSData y devuelvo
            if let a = self.data {
                //tengo algun dato, lo transformo a uiimage
                let i = UIImage(data: a)
                return i
            }
            else {
                //no tengo valor. he de bajarmelo, paso el objeto core data y una vez descargado se guarda. Si ya no existe la celda se guarda igualemnte
                AsyncDownLoadImageFrom(coredataObject: self)
                return nil
            }
        }
    }

}
