//
//  ToDoListViewModel.swift
//  Assignment-26
//
//  Created by Eka Kelenjeridze on 08.12.23.
//

import Foundation

struct ToDo: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    var isDone: Bool
    
//    mutating func markAsDone(_ state: Bool) {
//        isDone = state
//    }
}


struct ToDoList {
    static let dummyData = [
        ToDo(
            title: "Mobile App Research",
            date: "4 Oct",
            isDone: true
        ),
        ToDo(
            title: "Prepare Wireframe for Main Flow",
            date: "4 Oct",
            isDone: true
        ),
        ToDo(
            title: "Prepare Screens",
            date: "4 Oct",
            isDone: true
        ),
        ToDo(
            title: "Website Research",
            date: "5 Oct",
            isDone: false
        ),
        ToDo(
            title: "Prepare Wireframe for Main Flow",
            date: "5 Oct",
            isDone: false
        ),
        ToDo(
            title: "Prepare Screens",
            date: "5 Oct",
            isDone: false
        )
    ]
    
    //show show completed first
    static var sortedDummyData: [ToDo] {
           dummyData.sorted { $0.isDone && !$1.isDone }
       }
}

