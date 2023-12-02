//
//  ContentView.swift
//  Reminders
//
//  Created by Theerabhop Suakaraya on 2/12/2566 BE.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("todos") var todosData: Data = Data()
    @State var todos: [Todo] = []
    @State private var newTodoTitle = ""
    @State private var newTodoDueDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 4) {
            HStack(){
                Text("Reminders")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding([.top, .leading], 25)
                    .padding(.bottom, 10)
                Spacer()
            }
            List(){
                ForEach(todos.indices, id: \.self) { index in
                    let randomColor = Color(
                        red: todos[index].rowColorRed,
                                        green: todos[index].rowColorGreen,
                                        blue: todos[index].rowColorBlue
                                    )
                    
                    Button{
                        todos[index].isCompleted.toggle()
                    } label: {
                    HStack {
                        VStack{
                            Text(todos[index].title)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .opacity(todos[index].isCompleted ? 0.7 : 1.0)
                            Text(formatDate(todos[index].date))
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                                .opacity(0.6)
                                .foregroundColor(Color.black)
                        }.strikethrough(todos[index].isCompleted, color:.red)
                            
                        Spacer()
                        
                            
                            Image(systemName: todos[index].isCompleted ? "flag.checkered.circle.fill" : "flag.checkered.circle")
                                .foregroundColor(todos[index].isCompleted ? .yellow.opacity(0.5) : .yellow)
                                .shadow(color: .yellow, radius: 10)
                                .background(
                                    Circle()
                                        .fill(randomColor)
                                        .frame(width: 25, height: 25) // Adjust the size of the circle as needed
                                ).shadow(radius: 5)
                        }
                                
                    }.listRowBackground(randomColor.opacity(0.5).shadow(color: randomColor, radius: 5))
                } .onDelete(perform: deleteTodo)
                
                HStack {
                    TextField("New Reminder here...", text: $newTodoTitle, onCommit: addTodo)
                    DatePicker("", selection: $newTodoDueDate, displayedComponents: .date).labelsHidden()
                    Spacer()
                    Button{
                        addTodo()
                    } label:{
                        Image(systemName: "plus")
                            
                    }
                    
                }
                    
            }.font(.headline)
        }
        .onAppear(perform: loadTodos)
    }
    
    func formatDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    func addTodo(){
        let trimmed = newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {return}
        
        
        let todo = Todo(title: trimmed, rowColorRed: .random(in: 0...1), rowColorBlue: .random(in: 0...1), rowColorGreen: .random(in: 0...1), date: newTodoDueDate)
        todos.append(todo)
        newTodoTitle = ""
        saveTodos()
    }
    func deleteTodo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
        saveTodos()
    }
    
    func saveTodos(){
        if let encoded = try? JSONEncoder().encode(todos){
            todosData = encoded
        }
    }
    
    func loadTodos() {
        if let decoded = try? JSONDecoder().decode([Todo].self, from: todosData){
            todos = decoded
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
