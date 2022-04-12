//  
//  InfoModuleView.swift
//  RoundTable
//
//  Created by Stan Potemkin on 11.04.2022.
//

import Foundation
import SwiftUI

enum InfoModuleViewIntent {
    case close
}

struct InfoModuleView: View {
    let trunk: RTBConfigTrunk?
    
    private let binding: InfoModuleViewBinding
    private let pipeline: InfoModulePipeline?
    
    init(trunk: RTBConfigTrunk?, callback: ((InfoModuleJointOutput) -> Void)?) {
        self.trunk = trunk
        
        let binding = InfoModuleViewBinding()
        self.binding = binding
        self.pipeline = trunk.flatMap { InfoModuleAssembly(trunk: $0, binding: binding, callback: callback) }
    }
    
    var body: some View {
        NavigationView {
            Text("In opposite to others,\nthis module uses SwiftUI")
                .multilineTextAlignment(.center)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Help")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button("Close") {
                            pipeline?.notify(intent: .close)
                        }
                    }
                }
        }
    }
}
