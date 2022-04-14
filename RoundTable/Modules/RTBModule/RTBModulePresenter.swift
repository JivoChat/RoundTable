//  
//  RTBModulePresenter.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation

protocol IRTBModulePipelinePresenterNotifier: AnyObject {
}

class RTBModulePipelinePresenterNotifier<PresenterUpdate>: IRTBModulePipelinePresenterNotifier {
}

class RTBModulePipelinePresenterHandler<ViewIntent, CoreEvent, JointInput> {
    func handleView(intent: ViewIntent) {}
    func handleCore(event: CoreEvent) {}
    func handleJoint(input: JointInput) {}
}

class RTBModulePresenter<Pipeline: IRTBModulePipelinePresenterNotifier, ViewBinding: ObservableObject, ViewIntent, CoreEvent, JointInput, State: AnyObject>
: RTBModulePipelinePresenterHandler<ViewIntent, CoreEvent, JointInput> {
    private weak var pipeline: Pipeline?
    internal let state: State
    internal let binding: ViewBinding
    
    init(pipeline: Pipeline, state: State, binding: ViewBinding) {
        self.pipeline = pipeline
        self.state = state
        self.binding = binding
    }
    
    func update(firstAppear: Bool) {
    }
    
    override func handleView(intent: ViewIntent) {
    }
    
    override func handleCore(event: CoreEvent) {
    }
    
    override func handleJoint(input: JointInput) {
    }
}
