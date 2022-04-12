//  
//  TaskEditModuleJoint.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

enum TaskEditModuleJointInput {
}

enum TaskEditModuleJointOutput {
    case dismiss
}

final class TaskEditModuleJoint
: RTEModuleJoint<
TaskEditModulePipeline,
TaskEditModuleJointOutput,
TaskEditModuleJointInput,
TaskEditModuleCoreEvent,
TaskEditModuleViewIntent,
TaskEditModuleState
> {
    override func handleCore(event: TaskEditModuleCoreEvent) {
        switch event {
        case .taskCreated:
            notifyOut(output: .dismiss)
        case .taskModified:
            notifyOut(output: .dismiss)
        }
    }
    
    override func handleView(intent: TaskEditModuleViewIntent) {
        switch intent {
        case .cancel:
            notifyOut(output: .dismiss)
        default:
            break
        }
    }
}
