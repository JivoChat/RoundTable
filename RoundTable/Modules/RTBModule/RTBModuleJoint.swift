//  
//  RTBModuleJoint.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation
import SwiftUI

protocol IRTBModulePipelineJointNotifier: AnyObject {
    associatedtype JointInput
    func notify(input: JointInput)
    func notifyCorePresenter(input: JointInput)
}

class RTBModulePipelineJointHandler<CoreEvent, ViewIntent> {
    func handleCore(event: CoreEvent) {}
    func handleView(intent: ViewIntent) {}
}

class RTBModuleJoint<Pipeline: IRTBModulePipelineJointNotifier, JointOutput, JointInput, CoreEvent, ViewIntent, State: AnyObject>
: RTBModulePipelineJointHandler<CoreEvent, ViewIntent>
where Pipeline.JointInput == JointInput {
    private weak var pipeline: Pipeline?
    internal let state: State
    internal let trunk: RTBConfigTrunk?
    internal let callback: ((JointOutput) -> Void)?
    
    init(pipeline: Pipeline, state: State, trunk: RTBConfigTrunk?, callback: ((JointOutput) -> Void)?) {
        self.pipeline = pipeline
        self.state = state
        self.trunk = trunk
        self.callback = callback
    }
    
    func take(input: JointInput) {
        self.pipeline?.notify(input: input)
    }
    
    override func handleCore(event: CoreEvent) {
    }
    
    override func handleView(intent: ViewIntent) {
    }
    
    final func notifyOut(output: JointOutput) {
        callback?(output)
    }
}
