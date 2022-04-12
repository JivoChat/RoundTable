//  
//  TaskListModuleJoint.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation
import SwiftUI

enum TaskListModuleJointInput {
}

enum TaskListModuleJointOutput {
}

final class TaskListModuleJoint
: RTEModuleJoint<
TaskListModulePipeline,
TaskListModuleJointOutput,
TaskListModuleJointInput,
TaskListModuleCoreEvent,
TaskListModuleViewIntent,
TaskListModuleState
> {
    override func handleView(intent: TaskListModuleViewIntent) {
        switch intent {
        case .info:
            presentInfo()
        case .add:
            presentTaskEditor(task: nil)
        case .pick(let index):
            presentTaskEditor(task: state.tasks[index])
        default:
            break
        }
    }
    
    private func presentInfo() {
        let module = InfoModuleView(trunk: trunk) { [weak self] output in
            switch output {
            case .dismiss:
                self?.view?.dismiss(animated: true)
            }
        }
        
        view?.present(UIHostingController(rootView: module), animated: true)
    }
    
    private func presentTaskEditor(task: Task?) {
        let module = TaskEditModuleAssembly(trunk: trunk, task: task)
        
        module.joint.attach { [weak self] output in
            switch output {
            case .dismiss:
                self?.view?.dismiss(animated: true)
            }
        }
        
        view?.present(module.view, animated: true)
    }
}
