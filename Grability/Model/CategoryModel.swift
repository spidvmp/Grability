@objc(CategoryModel)
public class CategoryModel: _CategoryModel {

	// Custom logic goes here.
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(category: String, context c: NSManagedObjectContext) {
        super.init(entity: _CategoryModel.entity(c), insertIntoManagedObjectContext: c)
        
        self.category = category
    }
    
    class func addCategory(category: String, context c: NSManagedObjectContext) -> CategoryModel {
        
        //busco si existe la categoria
        var cat = CategoryModel.findCategory(category, context: c)
        if cat == nil {
            cat = CategoryModel(category: category, context: c)
        }
        return cat!
    }
    
    class func findCategory(category: String, context c: NSManagedObjectContext) -> CategoryModel? {
        //busco a ver si ya tengo metida la categoria
        let query = NSFetchRequest(entityName: self.entityName())
        query.predicate = NSPredicate(format: "category == '\(category)'")
        do{
            let result = try c.executeFetchRequest(query)
            switch (result.count){
            case 0:
                return nil
            case 1:
                return result[0] as? CategoryModel
            default:
                //esto no deberia pasar nunca
                return result[0] as? CategoryModel
            }
            
        } catch {
            return nil
        }
    
    }
}
