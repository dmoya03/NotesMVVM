//
//  Home.swift
//  NotasMVVM
//
//  Created by Daniel Moya on 14/12/23.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: false)], animation: .spring()) var results: FetchedResults<Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results){item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Without note")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action: {
                            model.sendData(item: item)
                        }){
                            Label(
                                title: { Text("Edit") },
                                icon: { Image(systemName: "pencil") }
                            )
                        }
                        Button(action: {
                            model.deleteData(item: item, context: context)
                        }){
                            Label(
                                title: { Text("Delete") },
                                icon: { Image(systemName: "trash") }
                            )
                        }
                    }))
                }
            }.navigationBarTitle("Notes")
                .navigationBarItems(trailing: Button(action:{
                    model.enableNewNote()
                    model.show.toggle()
                }){
                    Image(systemName: "plus")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }.sheet(isPresented: $model.show, content: {
                    addNote(model: model)
                }))
        }
    }
}

#Preview {
    Home()
}
