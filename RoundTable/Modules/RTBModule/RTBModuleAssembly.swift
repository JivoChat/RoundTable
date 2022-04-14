//  
//  RTBModuleAssembly.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation
import SwiftUI

typealias RTBConfigTrunk = ITrunk

func RTBModuleAssembly<
    CoreEvent,
    ViewBinding: ObservableObject,
    ViewIntent,
    JointInput,
    JointOutput,
    Pipeline: RTBModulePipeline<CoreEvent, ViewBinding, ViewIntent, JointInput>,
    State: AnyObject,
    Core: RTBModuleCore<Pipeline, CoreEvent, ViewIntent, JointInput, State>,
    Presenter: RTBModulePresenter<Pipeline, ViewBinding, ViewIntent, CoreEvent, JointInput, State>,
    Joint: RTBModuleJoint<Pipeline, JointOutput, JointInput, CoreEvent, ViewIntent, State>
>(pipeline: Pipeline,
 state: State,
 coreBuilder: (Pipeline, State) -> Core,
 presenterBuilder: (Pipeline, State) -> Presenter,
 jointBuilder: (Pipeline, State) -> Joint) -> Pipeline {
    let core = coreBuilder(pipeline, state)
    let presenter = presenterBuilder(pipeline, state)
    let joint = jointBuilder(pipeline, state)

    pipeline.linkCore(core)
    pipeline.linkPresenter(presenter)
    pipeline.linkJoint(joint)

    core.run()
    presenter.update(firstAppear: true)

    return pipeline
}
