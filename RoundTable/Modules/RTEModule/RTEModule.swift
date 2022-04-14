//  
//  RTEModule.swift
//  RoundTable
//
//  Created by Stan Potemkin on 14.04.2022.
//

import Foundation
import UIKit

struct RTEModule<
    PresenterUpdate,
    ViewIntent,
    Joint,
    View: IRTEModulePipelineViewHandler
> where View.PresenterUpdate == PresenterUpdate {
    let view: View
    let joint: Joint
}
