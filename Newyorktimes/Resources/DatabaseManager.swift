//
//  DatabaseManager.swift
//  Newyorktimes
//
//  Created by omair khan on 22/11/2021.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager {
    static var shared = DatabaseManager()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    //MARK: Save the coredata object
    func saveToCoreData(object: [String:String])  {
        let bookMarks = NSEntityDescription.insertNewObject(forEntityName: "Bookmarks", into: context!) as! Bookmarks
        
        // assign values to bookmarks attributes
        bookMarks.title =  object["title"]
        bookMarks.imageURL = object["imageURL"]
        bookMarks.link = object["url"]
        
        do{
            try context?.save()
        }catch{
            print("Data is not saved")
        }
        
    }
    
    //MARK: Fetch Data from CoreData
    func getBookMarks() -> [Bookmarks]{
        var bookMarks = [Bookmarks]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Bookmarks")
        
        do{
            bookMarks = try context?.fetch(fetchRequest) as! [Bookmarks]
            
        }catch{
            print("Cannot fetch data from coredata")
        }
        return bookMarks
    }
    
    //MARK: Delete Data from CoreData
    func deleteData(indexPath : Int) -> [Bookmarks] {
        var bookMarks = getBookMarks()
        context?.delete(bookMarks[indexPath])
        bookMarks.remove(at: indexPath)
        do{
            try context?.save()
        }catch{
            print("Cannot Delete")
        }
        
        return bookMarks
    }
    
}
