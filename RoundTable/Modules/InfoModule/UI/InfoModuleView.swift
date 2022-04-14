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
    case decrement
    case increment
}

struct InfoModuleView: View {
    let trunk: RTBConfigTrunk?
    
    @ObservedObject private var binding: InfoModuleViewBinding
    private let pipeline: InfoModulePipeline?
    
    init(trunk: RTBConfigTrunk?, callback: ((InfoModuleJointOutput) -> Void)?) {
        self.trunk = trunk
        
        let binding = InfoModuleViewBinding()
        self.binding = binding
        self.pipeline = trunk.flatMap { InfoModuleAssembly(trunk: $0, binding: binding, callback: callback) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Counter: \(self.binding.counter)")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Button("Decrement") {
                        self.pipeline?.notify(intent: .decrement)
                    }
                    
                    Button("Increment") {
                        self.pipeline?.notify(intent: .increment)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("SwiftUI Example")
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
