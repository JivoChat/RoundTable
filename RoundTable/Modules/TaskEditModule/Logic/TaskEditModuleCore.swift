//  
//  TaskEditModuleCore.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

enum TaskEditModuleCoreEvent {
    case taskCreated
    case taskModified
}

final class TaskEditModuleCore
: RTEModuleCore<
TaskEditModulePipeline,
TaskEditModuleCoreEvent,
TaskEditModuleViewIntent,
TaskEditModuleJointInput,
TaskEditModuleState
> {
    private let taskManager: ITaskManager
    
    init(pipeline: TaskEditModulePipeline, state: TaskEditModuleState, taskManager: ITaskManager) {
        self.taskManager = taskManager
        
        super.init(pipeline: pipeline, state: state)
    }
    
    override func run() {
    }
    
    override func handleView(intent: TaskEditModuleViewIntent) {
        switch (intent, state.purpose) {
        case (.briefChange(let brief), _):
            state.brief = brief
        case (.save, .add):
            taskManager.createTask(brief: state.brief)
            pipeline?.notify(event: .taskCreated)
        case (.save, .edit(let uid)):
            taskManager.modifyTask(uid: uid) { task in Task(uid: uid, brief: state.brief, creationDate: task.creationDate) }
            pipeline?.notify(event: .taskModified)
        default:
            break
        }
    }
    
    override func handleJoint(input: TaskEditModuleJointInput) {
    }
}
