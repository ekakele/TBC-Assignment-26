//
//  ContentView.swift
//  Assignment-26
//
//  Created by Eka Kelenjeridze on 08.12.23.
//

import SwiftUI

struct ContentView: View {
    @State var toDoList = ToDoList.sortedDummyData
    
    var numberOfCompletedTasks: Int {
        toDoList.filter{ $0.isDone }.count
    }
    
    var numberOfUncompletedTasks: Int {
        toDoList.filter{ !$0.isDone }.count
    }
    
//    var totalNumberOfTasks = toDoList.count
    
    func markAsDone(id: UUID) {
        if let index = toDoList.firstIndex(where: { $0.id == id }) {
            toDoList[index].isDone.toggle() //same as: = !toDoList[index].isDone
            
            //show completed first
            toDoList.sort { $0.isDone && !$1.isDone }
        }
    }
    
    
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading) {
                //header stack
                HStack {
                    Text("You have \(numberOfUncompletedTasks) tasks to complete")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer(minLength: 152)
                    
                    //userAvatar
                    Image("avatarBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 49, height: 49)
                        .overlay(
                            Image("userAvatar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 45)
                                .scaleEffect(1.8)
                                .offset(y: 13)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .overlay(
                                    Circle()
                                        .frame(width: 15, height: 15)
                                        .foregroundColor(Color(red: 1.00, green: 0.46, blue: 0.23))
                                        .offset(x: 10, y: 20)
                                )
                        )
                }
                
                //button
                Button(action: {
                    for index in toDoList.indices {
                        toDoList[index].isDone = true
                    }
                }, label: {
                    Text("Complete All")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 397, height: 50)
                    //                        .padding(.horizontal, 120)
                    //                        .padding(.vertical, 15)
                        .background(LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color(red: 0.73, green: 0.51, blue: 0.87),
                                    Color(red: 0.87, green: 0.51, blue: 0.69)
                                ]
                            ),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .cornerRadius(8)
                })
                
                //Headline
                Text("Progress")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                
                
                //progress stack
                VStack(alignment: .leading, spacing: 10) {
                    Text("Daily Task")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(numberOfCompletedTasks)/\(toDoList.count) Task Completed")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Keep  working")
                        .font(.callout)
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white.opacity(0.8))
                    
                }
                .padding(15)
                .frame(width: 397, height: 139)
                .background(Color(red: 0.09, green: 0.09, blue: 0.09))
                .cornerRadius(8)
                
                //Headline
                Text("Completed Tasks")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                
                List(toDoList) { toDo in
                    ListRowView(title: toDo.title, date: toDo.date, isDone: toDo.isDone, markAsDone: {
                        self.markAsDone(id: toDo.id)
                    })
                    .padding(.vertical, -10) //negative padding
                    .padding(.horizontal, -20) //negative padding
                }
                .listStyle(PlainListStyle())
                //                .background(Color.clear)
            }
            .padding(20)
            
        }
        
        
        
    }
}

#Preview {
    ContentView()
}

struct ListRowView: View {
    let title: String
    let date: String
    let isDone: Bool
    let markAsDone: () -> Void
    
    var body: some View {
        //row
        HStack {
            Rectangle()
                .fill(Color(red: 0.98, green: 0.85, blue: 1))
                .frame(width: 15, height: 80)
            
            
            
            //text stack
            VStack(alignment: .leading, spacing: 5) {
                
                Text(title)
                    .lineLimit(1)
                //date stack
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 15, height: 17)
                    Text(date)
                }
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            Button(action: markAsDone, label: {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .foregroundColor(.purple)
                    .frame(width: 26, height: 26)
            })
        }
        .frame(width: .infinity, height: 80)
        .background(Color.orange)
        .cornerRadius(8)
    }
}
