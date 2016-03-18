@objc(ApplicationModel)
public class ApplicationModel: _ApplicationModel {

	// Custom logic goes here.
    
    
    //MARK: - inicializador
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(name: String, category: String, price: String, date: String, rights: String, photo: String, context c: NSManagedObjectContext) {

        
        

        
        super.init(entity: _ApplicationModel.entity(c), insertIntoManagedObjectContext: c)
        
        
    }

}
