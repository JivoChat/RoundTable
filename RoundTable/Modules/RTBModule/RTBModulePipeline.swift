//  
//  RTBModulePipeline.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation

protocol AnyRTBModulePipeline: AnyObject {
}

class RTBModulePipeline<CoreEvent, ViewBinding: ObservableObject, ViewIntent, JointInput>
: RTBModulePipelineViewNotifier<ViewIntent>
, AnyRTBModulePipeline
, IRTBModulePipelineCoreNotifier
, IRTBModulePipelinePresenterNotifier
, IRTBModulePipelineJointNotifier {
    let trunk: RTBConfigTrunk?
    private let binding: ViewBinding

    var linkedCore: RTBModulePipelineCoreHandler<ViewIntent, JointInput>?
    var linkedPresenter: RTBModulePipelinePresenterHandler<ViewIntent, CoreEvent, JointInput>?
    var linkedJoint: RTBModulePipelineJointHandler<CoreEvent, ViewIntent>?

    init(trunk: RTBConfigTrunk?, binding: ViewBinding) {
        self.trunk = trunk
        self.binding = binding
    }

    var joint: RTBModulePipelineJointHandler<CoreEvent, ViewIntent> {
        return linkedJoint!
    }
    
    func linkCore(_ ref: RTBModulePipelineCoreHandler<ViewIntent, JointInput>) {
        linkedCore = ref
    }

    func linkPresenter(_ ref: RTBModulePipelinePresenterHandler<ViewIntent, CoreEvent, JointInput>) {
        linkedPresenter = ref
    }

    func linkJoint(_ ref: RTBModulePipelineJointHandler<CoreEvent, ViewIntent>) {
        linkedJoint = ref
    }
    
    func notify(event: CoreEvent) {
        linkedPresenter?.handleCore(event: event)
        linkedJoint?.handleCore(event: event)
    }
    
    func notifyPresenterJoint(event: CoreEvent) {
        notify(event: event)
    }
    
    func notify(input: JointInput) {
        linkedCore?.handleJoint(input: input)
        linkedPresenter?.handleJoint(input: input)
    }

    func notifyCorePresenter(input: JointInput) {
        notify(input: input)
    }

    override func notify(intent: ViewIntent) {
        linkedCore?.handleView(intent: intent)
        linkedPresenter?.handleView(intent: intent)
        linkedJoint?.handleView(intent: intent)
    }
}
