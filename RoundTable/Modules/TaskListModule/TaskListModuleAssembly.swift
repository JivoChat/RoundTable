//  
//  TaskListModuleAssembly.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

typealias TaskListModulePipeline = RTEModulePipeline<
    TaskListModuleCoreEvent,
    TaskListModulePresenterUpdate,
    TaskListModuleViewIntent,
    TaskListModuleJointInput,
    TaskListModuleView
>

typealias TaskListModule = RTEModule<
    TaskListModulePresenterUpdate,
    TaskListModuleViewIntent,
    TaskListModuleJoint,
    TaskListModuleView
>

func TaskListModuleAssembly(trunk: RTEConfigTrunk) -> TaskListModule {
    return RTEModuleAssembly(
        pipeline: TaskListModulePipeline(),
        state: TaskListModuleState(),
        coreBuilder: { pipeline, state in
            TaskListModuleCore(
                pipeline: pipeline,
                state: state,
                taskManager: trunk.taskManager
            )
        },
        presenterBuilder: { pipeline, state in
            TaskListModulePresenter(
                pipeline: pipeline,
                state: state,
                formattingProvider: trunk.formattingProvider
            )
        },
        viewBuilder: { pipeline in
            TaskListModuleView(
                pipeline: pipeline
            )
        },
        jointBuilder: { pipeline, state, view in
            TaskListModuleJoint(
                pipeline: pipeline,
                state: state,
                view: view,
                trunk: trunk
            )
        })
}
