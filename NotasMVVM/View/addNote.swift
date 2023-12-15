//
//  addNote.swift
//  NotasMVVM
//
//  Created by Daniel Moya on 14/12/23.
//

import SwiftUI

struct addNote: View {
    
    @ObservedObject var model: ViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack{
            Text(model.updateItem != nil ? "Edit note" : "Add note")
                                .font(.largeTitle)
                                .bold()
            Spacer()
            TextEditor(text: $model.nota)
            Divider()
            DatePicker("Seleccionar fecha", selection: $model.fecha)
            Spacer()
            Button(action:{
                if model.updateItem != nil {
                    //Editar item
                    model.editData(context: context)
                } else {
                    //Guardar nuevo item
                    model.saveData(context: context)
                }
            }){
                Label(
                    title: { Text("Add").foregroundColor(.white).bold()},
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }.padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(model.nota == "" ? Color.gray : Color.blue)
                .cornerRadius(8)
                .disabled(model.nota == "" ? true : false)
            
        }.padding()
    }
}

