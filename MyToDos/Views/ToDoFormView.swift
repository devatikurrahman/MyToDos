//
//  ToDoFormView.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/29/23.
//

import SwiftUI

struct ToDoFormView: View {
    @Environment(DataStore.self) var dataStore
    @ObservedObject var formVM: ToDoFormViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    TextField("ToDo", text: $formVM.name)
                    Toggle("Completed", isOn: $formVM.completed)
                }
            }
            .navigationTitle("ToDo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: updateSaveButton)
        }
    }
}

extension ToDoFormView {
    func updateToDo() {
        let toDo = ToDo(id: formVM.id!, name: formVM.name, completed: formVM.completed)
        //dataStore.updateToDo(toDo)
        dataStore.updateToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    func addToDo() {
        let toDo = ToDo(name: formVM.name)
        dataStore.addToDo(toDo)
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button(formVM.updating ? "Update" : "Save",
               action: formVM.updating ? updateToDo : addToDo)
        .disabled(formVM.isDisabled)
    }
}

#Preview {
    ToDoFormView(formVM: ToDoFormViewModel())
        .environment(DataStore())
}
