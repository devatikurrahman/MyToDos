//
//  ContentView.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ToDoListViewModel
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(viewModel.toDoList) { toDo in
                    Button {
                        
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)
                            .foregroundColor(toDo.completed ? .green : Color(.label))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My ToDos")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("My ToDos") {
                        
                    } label: {
                        <#code#>
                    }
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                
                
            }
        }
    }
}

#Preview {
    ContentView()
}
