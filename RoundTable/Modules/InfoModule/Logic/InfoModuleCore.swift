//  
//  InfoModuleCore.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation

enum InfoModuleCoreEvent {
}

final class InfoModuleCore
: RTBModuleCore<
    InfoModulePipeline,
    InfoModuleCoreEvent,
    InfoModuleViewIntent,
    InfoModuleJointInput,
    InfoModuleState
> {
    override init(pipeline: InfoModulePipeline, state: InfoModuleState) {
        super.init(pipeline: pipeline, state: state)
    }

    override func run() {
    }
    
    override func handleView(intent: InfoModuleViewIntent) {
    }
    
    override func handleJoint(input: InfoModuleJointInput) {
    }
}
