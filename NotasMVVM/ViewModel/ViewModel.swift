//
//  ViewModel.swift
//  NotasMVVM
//
//  Created by Daniel Moya on 14/12/23.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem: Notas!
    
    //CoreData
    
    func enableNewNote() -> Void {
        //Se pone variable updateItem como nulo para indicar que se va a guardar una nota nueva
        //Tambien para que cambie el titulo por "Add note"
        updateItem = nil
        //Se limpian los campos del formulario para que al agregar despues de darle a editar a un
        //elemento no ponga los datos anteriores en el formulario como si fuese a editar
        nota = ""
        fecha = Date()
    }
    
    func saveData(context: NSManagedObjectContext) -> Void {
        let newNote = Notas(context: context)
        newNote.nota = nota
        newNote.fecha = fecha
        
        do{
            try context.save()
            print("guardo")
            show.toggle()
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext) -> Void {
        context.delete(item)
        
        do{
            try context.save()
            print("Elimino")
        } catch let error as NSError {
            print("No elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas) -> Void {
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext) -> Void {
        updateItem.nota = nota
        updateItem.fecha = fecha
        
        do{
            try context.save()
            print("Edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
    
}
