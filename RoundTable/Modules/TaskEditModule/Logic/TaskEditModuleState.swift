//  
//  TaskEditModuleState.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

final class TaskEditModuleState {
    enum Purpose {
        case add
        case edit(uid: UUID)
    }

    let purpose: Purpose
    var brief: String
    
    init(task: Task?) {
        if let task = task {
            purpose = .edit(uid: task.uid)
            brief = task.brief
        }
        else {
            purpose = .add
            brief = String()
        }
    }
}
