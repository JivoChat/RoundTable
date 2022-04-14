//  
//  RTBModuleCore.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation

protocol IRTBModulePipelineCoreNotifier: AnyObject {
    associatedtype CoreEvent
    func notify(event: CoreEvent)
    func notifyPresenterJoint(event: CoreEvent)
}

class RTBModulePipelineCoreHandler<ViewIntent, JointInput> {
    func handleView(intent: ViewIntent) {}
    func handleJoint(input: JointInput) {}
}

class RTBModuleCore<Pipeline: IRTBModulePipelineCoreNotifier, CoreEvent, ViewIntent, JointInput, State: AnyObject>
: RTBModulePipelineCoreHandler<ViewIntent, JointInput>
where Pipeline.CoreEvent == CoreEvent {
    private(set) weak var pipeline: Pipeline?
    internal let state: State
    
    init(pipeline: Pipeline, state: State) {
        self.pipeline = pipeline
        self.state = state
    }
    
    func run() {
    }
    
    override func handleView(intent: ViewIntent) {
    }
    
    override func handleJoint(input: JointInput) {
    }
}
