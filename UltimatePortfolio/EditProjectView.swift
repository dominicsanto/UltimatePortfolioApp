//
//  EditProjectView.swift
//  UltimatePortfolio
//
//  Created by Dominic Santo on 2020/11/23.
//

import SwiftUI

struct EditProjectView: View {
    let project: Project
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String
    @State private var detail: String
    @State private var color: String
    @State private var showingDeleteConfirm = false
    
    let colorColumns = [
        GridItem(.adaptive(minimum: 44))
    ]
    
    init(project: Project) {
        self.project = project
        
        _title = State(wrappedValue: project.projectTitle)
        _detail = State(wrappedValue: project.projectDetail)
        _color = State(wrappedValue: project.projectColor)
    }

    var body: some View {
        Form {
            Section(header: Text("Basic Settings")) {
                TextField("Project name", text: $title.onChange(update))
                TextField("Detail", text: $detail.onChange(update))
            }
            
            Section(header: Text("Color selection")) {
                LazyVGrid(columns: colorColumns) {
                    ForEach(Project.colors, id: \.self) { item in
                        ZStack {
                            Color(item)
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(6)
                            
                            if item == color {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }
                        }
                        .onTapGesture {
                            color = item
                            update()
                        }
                    }
                }
                .padding(.vertical)
            }
            Section(footer: Text("Closing a project moves it from open to close; deleting it removes the project")) {
                Button(project.closed ? "Open" : "Close") {
                    project.closed.toggle()
                    update()
                }
                
                Button("Delete project") {
                    showingDeleteConfirm.toggle()
                }
                .accentColor(.red)
            }
            
        }
        .navigationTitle("Edit Project")
        .onDisappear(perform: dataController.save)
        .alert(isPresented: $showingDeleteConfirm) {
            Alert(title: Text("Delete Project"), message: Text("Are you sure you want to delete this project?"), primaryButton: .default(Text("Delete"), action: delete), secondaryButton: .cancel())
        }
    }
    
    func update() {
        project.objectWillChange.send()
        
        project.title = title
        project.detail = detail
        project.color = color
    }
    
    func delete() {
        dataController.delete(project)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(project: Project.example)
    }
}
