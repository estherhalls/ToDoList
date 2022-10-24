//
//  ToDoController.swift
//  ToDoList
//
//  Created by Esther on 10/16/22.
//

import Foundation
class ToDoController {
    // MARK: - Singleton
    static let sharedInstance = ToDoController()
    
    // MARK: - SOT
    private(set) var toDoList: [ToDo] = []
    
    // load user's stored data upon launch of ToDoController
    init() {
        load()
    }
    
    // MARK: - CRUD
    func createToDo(name: String) {
        let toDo = ToDo(toDoName: name)
        toDoList.append(toDo)
        save()
    }
    
    func delete(toDoToDelete: ToDo) {
        guard let index = toDoList.firstIndex(of: toDoToDelete) else {return}
        toDoList.remove(at: index)
        save()
    }
    
    // MARK: - Persistance
    /// Need the URL - which is a property. Source of truth - also a property
    /// make it private because the other files ONLY NEED TO SEE the source of truth.. not the user's phone
    /// if you open a scope after the type declaration, it is no longer a PROPERTY - it is now a COMPUTED PROPERTY: scope creates VALUE for the Computed Property
    private var fileURL: URL? {
        /// Retrieve the first available  URL that is on the correct level to save user data -> within the users documents folder on their phone (standard location)
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalURL = documentsDirectoryURL.appendingPathComponent("toDoList.json")
        return finalURL
    }
    
    // Need to save the URL
    /// This code will always be the same except the name of the SOT
    func save() {
        /// do we have a valid save location?
        guard let saveLocation = fileURL else {return}
        /// convert the logs (SOT) into raw data (JSON)
        /// if a call can THROW - you need to write a DO, TRY, CATCH (does by trying and will catch the error)
        do {
            // do this by TRY
            let data = try JSONEncoder().encode(toDoList)
            // write the data to the url
            /// write(to:) is a throwing function
            try data.write(to: saveLocation)
        } catch let error {
            print(error)
        }
    }
    
    // Need to load from the URL
    func load() {
        guard let loadLocation = fileURL else {return}
        do {
            // initializing data from contents of given URL
            let data = try Data(contentsOf: loadLocation)
            let decodedList = try JSONDecoder().decode([ToDo].self, from: data)
            // use newly loaded data as your SOT, .self is how we defined the type
            self.toDoList = decodedList
        } catch let error {
            print(error)
        }
    }
    
} // End of Class
