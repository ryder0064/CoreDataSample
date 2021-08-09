//
//  ContentView.swift
//  Shared
//
//  Created by 陳耀奇 on 2021/8/6.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = PersonListViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter person name", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter person height", text: $viewModel.height)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            TextField("Enter person weight", text: $viewModel.weight)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            Button("Save") {
                viewModel.save()
                viewModel.getAllPersons()
            }
            
            List {
                ForEach(viewModel.persons, id: \.id) { person in
                    Text("name: \(person.name), h: \(person.height.clean), w: \(person.weight.clean)")
                }.onDelete(perform: deletePerson)
            }
            
            Spacer()
        }.padding()
        .onAppear(perform: {
            viewModel.getAllPersons()
        })
    }
    
    func deletePerson(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = viewModel.persons[index]
            viewModel.delete(task)
        }
        
        viewModel.getAllPersons()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
