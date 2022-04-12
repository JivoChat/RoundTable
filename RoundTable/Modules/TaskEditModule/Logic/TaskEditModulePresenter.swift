//  
//  TaskEditModulePresenter.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

enum TaskEditModulePresenterUpdate {
    case setup(title: String, brief: String)
    case updateCanSave(Bool)
}

final class TaskEditModulePresenter
: RTEModulePresenter<
TaskEditModulePipeline,
TaskEditModulePresenterUpdate,
TaskEditModuleViewIntent,
TaskEditModuleCoreEvent,
TaskEditModuleJointInput,
TaskEditModuleState
> {
    override func update(firstAppear: Bool) {
        switch (firstAppear, state.purpose) {
        case (true, .add):
            pipeline?.notify(update: .setup(title: "Create", brief: String()))
            pipeline?.notify(update: .updateCanSave(false))
        case (true, .edit):
            pipeline?.notify(update: .setup(title: "Edit", brief: state.brief))
            pipeline?.notify(update: .updateCanSave(true))
        default:
            break
        }
    }
    
    override func handleCore(event: TaskEditModuleCoreEvent) {
    }
    
    override func handleView(intent: TaskEditModuleViewIntent) {
        switch intent {
        case .briefChange(let brief):
            pipeline?.notify(update: .updateCanSave(!brief.isEmpty))
        default:
            break
        }
    }
    
    override func handleJoint(input: TaskEditModuleJointInput) {
    }
}
