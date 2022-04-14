//  
//  InfoModulePresenter.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation

enum InfoModulePresenterUpdate {
}

final class InfoModulePresenter
: RTBModulePresenter<
    InfoModulePipeline,
    InfoModuleViewBinding,
    InfoModuleViewIntent,
    InfoModuleCoreEvent,
    InfoModuleJointInput,
    InfoModuleState
> {
    override func update(firstAppear: Bool) {
    }
    
    override func handleCore(event: InfoModuleCoreEvent) {
        switch event {
        case .counterChange:
            self.binding.counter = self.state.counter
        }
    }
    
    override func handleView(intent: InfoModuleViewIntent) {
    }
    
    override func handleJoint(input: InfoModuleJointInput) {
    }
}
