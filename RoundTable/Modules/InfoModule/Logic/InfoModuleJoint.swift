//  
//  InfoModuleJoint.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation

enum InfoModuleJointInput {
}

enum InfoModuleJointOutput {
    case dismiss
}

final class InfoModuleJoint
: RTBModuleJoint<
    InfoModulePipeline,
    InfoModuleJointOutput,
    InfoModuleJointInput,
    InfoModuleCoreEvent,
    InfoModuleViewIntent,
    InfoModuleState
> {
    override func handleCore(event: InfoModuleCoreEvent) {
    }
    
    override func handleView(intent: InfoModuleViewIntent) {
        switch intent {
        case .close:
            notifyOut(output: .dismiss)
        default:
            break
        }
    }
}
