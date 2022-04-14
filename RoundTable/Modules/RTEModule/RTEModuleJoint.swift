//  
//  RTEModuleJoint.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation
import UIKit

protocol IRTEModulePipelineJointNotifier: AnyObject {
    associatedtype JointInput
    func notify(input: JointInput)
    func notifyCorePresenter(input: JointInput)
}

class RTEModulePipelineJointHandler<CoreEvent, ViewIntent> {
    func handleCore(event: CoreEvent) {}
    func handleView(intent: ViewIntent) {}
}

class RTEModuleJoint<Pipeline: IRTEModulePipelineJointNotifier, JointOutput, JointInput, CoreEvent, ViewIntent, State: AnyObject>
: RTEModulePipelineJointHandler<CoreEvent, ViewIntent>
where Pipeline.JointInput == JointInput {
    private(set) weak var pipeline: Pipeline?
    internal let state: State
    internal let trunk: RTEConfigTrunk
    internal weak var view: UIViewController?
    
    private var callback: ((JointOutput) -> Void)?
    
    init(pipeline: Pipeline, state: State, view: UIViewController, trunk: RTEConfigTrunk) {
        self.pipeline = pipeline
        self.state = state
        self.view = view
        self.trunk = trunk
    }
    
    func attach(callback: @escaping (JointOutput) -> Void) {
        self.callback = callback
    }
    
    func take(input: JointInput) {
        self.pipeline?.notify(input: input)
    }
    
    override func handleCore(event: CoreEvent) {
    }
    
    override func handleView(intent: ViewIntent) {
    }
    
    final var navigationView: UINavigationController? {
        return view as? UINavigationController
    }
    
    final func notifyOut(output: JointOutput) {
        callback?(output)
    }
}
