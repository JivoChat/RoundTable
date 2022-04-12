//  
//  TaskListModulePresenter.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

enum TaskListModulePresenterUpdate {
    case setup(title: String)
    case tasks([TaskListModulePresenterTaskModel])
}

struct TaskListModulePresenterTaskModel {
    let brief: String
    let deadline: String
}

final class TaskListModulePresenter
: RTEModulePresenter<
TaskListModulePipeline,
TaskListModulePresenterUpdate,
TaskListModuleViewIntent,
TaskListModuleCoreEvent,
TaskListModuleJointInput,
TaskListModuleState
> {
    private let formattingProvider: IFormattingProvider
    
    init(pipeline: TaskListModulePipeline, state: TaskListModuleState, formattingProvider: IFormattingProvider) {
        self.formattingProvider = formattingProvider
        
        super.init(pipeline: pipeline, state: state)
    }
    
    override func update(firstAppear: Bool) {
        if firstAppear {
            pipeline?.notify(update: .setup(title: "Tasks"))
        }
        
        let models = state.tasks.map(generateModel(task:))
        pipeline?.notify(update: .tasks(models))
    }
    
    override func handleCore(event: TaskListModuleCoreEvent) {
        switch event {
        case .hasTaskUpdates:
            update(firstAppear: false)
        }
    }
    
    private func generateModel(task: Task) -> TaskListModulePresenterTaskModel {
        let deadline = formattingProvider.format(date: task.creationDate, kind: .short)
        return TaskListModulePresenterTaskModel(brief: task.brief, deadline: deadline)
    }
}
