//  
//  TaskEditModuleAssembly.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation
import UIKit

typealias TaskEditModulePipeline = RTEModulePipeline<
    TaskEditModuleCoreEvent,
    TaskEditModulePresenterUpdate,
    TaskEditModuleViewIntent,
    TaskEditModuleJointInput,
    TaskEditModuleView
>

typealias TaskEditModule = RTEModule<
    TaskEditModulePresenterUpdate,
    TaskEditModuleViewIntent,
    TaskEditModuleJoint,
    TaskEditModuleView
>

func TaskEditModuleAssembly(trunk: RTEConfigTrunk, task: Task?) -> TaskEditModule {
    return RTEModuleAssembly(
        pipeline: TaskEditModulePipeline(),
        state: TaskEditModuleState(task: task),
        coreBuilder: { pipeline, state in
            TaskEditModuleCore(
                pipeline: pipeline,
                state: state,
                taskManager: trunk.taskManager
            )
        },
        presenterBuilder: { pipeline, state in
            TaskEditModulePresenter(
                pipeline: pipeline,
                state: state
            )
        },
        viewBuilder: { pipeline in
            TaskEditModuleView(
                pipeline: pipeline
            )
        },
        jointBuilder: { pipeline, state, view in
            TaskEditModuleJoint(
                pipeline: pipeline,
                state: state,
                view: view,
                trunk: trunk
            )
        })
}
