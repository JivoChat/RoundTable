//  
//  InfoModuleAssembly.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation

typealias InfoModulePipeline = RTBModulePipeline<
    InfoModuleCoreEvent,
    InfoModuleViewBinding,
    InfoModuleViewIntent,
    InfoModuleJointInput
>

func InfoModuleAssembly(trunk: RTBConfigTrunk, binding: InfoModuleViewBinding, callback: ((InfoModuleJointOutput) -> Void)?) -> InfoModulePipeline {
    return RTBModuleAssembly(
        pipeline: InfoModulePipeline(trunk: trunk, binding: binding),
        state: InfoModuleState(),
        coreBuilder: { pipeline, state in
            InfoModuleCore(
                pipeline: pipeline,
                state: state
            )
        },
        presenterBuilder: { pipeline, state in
            InfoModulePresenter(
                pipeline: pipeline,
                state: state,
                binding: binding
            )
        },
        jointBuilder: { pipeline, state in
            InfoModuleJoint(
                pipeline: pipeline,
                state: state,
                trunk: trunk,
                callback: callback
            )
        })
}
