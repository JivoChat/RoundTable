//  
//  InfoModuleCore.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation

enum InfoModuleCoreEvent {
    case counterChange
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
        switch intent {
        case .close:
            break
        case .decrement:
            self.state.counter -= 1
            self.pipeline?.notify(event: .counterChange)
        case .increment:
            self.state.counter += 1
            self.pipeline?.notify(event: .counterChange)
        }
    }
    
    override func handleJoint(input: InfoModuleJointInput) {
    }
}
