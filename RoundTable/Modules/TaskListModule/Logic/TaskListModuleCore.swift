//  
//  TaskListModuleCore.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

enum TaskListModuleCoreEvent {
    case hasTaskUpdates
}

final class TaskListModuleCore
: RTEModuleCore<
TaskListModulePipeline,
TaskListModuleCoreEvent,
TaskListModuleViewIntent,
TaskListModuleJointInput,
TaskListModuleState
> {
    private let taskManager: ITaskManager
    
    private var tasksListener: UUID?
    
    init(pipeline: TaskListModulePipeline, state: TaskListModuleState, taskManager: ITaskManager) {
        self.taskManager = taskManager
        
        super.init(pipeline: pipeline, state: state)
    }

    deinit {
        if let uid = tasksListener {
            taskManager.removeListener(uid: uid)
        }
    }
    
    override func run() {
        tasksListener = taskManager.attachListener { [weak self] tasks in
            self?.state.tasks = tasks
            self?.pipeline?.notify(event: .hasTaskUpdates)
        }
    }
    
    override func handleView(intent: TaskListModuleViewIntent) {
        switch intent {
        case .delete(let index):
            let task = taskManager.tasks[index]
            taskManager.removeTask(uid: task.uid)
        default:
            break
        }
    }
    
    override func handleJoint(input: TaskListModuleJointInput) {
        
    }
}
