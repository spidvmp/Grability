@objc(ApplicationModel)
public class ApplicationModel: _ApplicationModel {

	// Custom logic goes here.
    
    
    //MARK: - inicializador
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(name: String, category: String, price: String, date: String, rights: String, photo: String, context c: NSManagedObjectContext) {
        super.init(entity: _ApplicationModel.entity(c), insertIntoManagedObjectContext: c)
        
        self.name = name
        self.price = price
        self.date = date
        self.rights = rights
        
        //ahora inserto la foto, que tendra la url u la imagen a nil
        let photoCD = PhotoModel(url: photo, context: c)
        self.photo = photoCD
        
        //ahora inserto la categoria, el motodo la busca, si existe la devuelve, ino la crea
        self.category = CategoryModel.addCategory(category, context: c)
        
    }
    
    

}
