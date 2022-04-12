//  
//  TaskEditModuleView.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation
import UIKit

enum TaskEditModuleViewIntent {
    case cancel
    case save
    case briefChange(String)
}

typealias TaskEditModuleView = (
    // Feed free to replace it with *ViewController or *NavigationController
    TaskEditModuleNavigationController
)

final class TaskEditModuleNavigationController
: RTEModuleViewNavigatable<
TaskEditModulePresenterUpdate,
TaskEditModuleViewIntent
> {
    init(pipeline: RTEModulePipelineViewNotifier<TaskEditModuleViewIntent>) {
        super.init(
            primaryView: TaskEditModuleViewController(pipeline: pipeline)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TaskEditModuleViewController
: RTEModuleViewStandalone<
TaskEditModulePresenterUpdate,
TaskEditModuleViewIntent
>
, UITextViewDelegate {
    private let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    private let briefTextView = UITextView()
    
    override init(pipeline: RTEModulePipelineViewNotifier<TaskEditModuleViewIntent>) {
        super.init(pipeline: pipeline)
        
        briefTextView.backgroundColor = UIColor(white: 0, alpha: 0.15)
        briefTextView.layer.cornerRadius = 10
        briefTextView.layer.masksToBounds = true
        briefTextView.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(handleCancelButton)
        )
        
        saveButton.target = self
        saveButton.action = #selector(handleSaveButton)
        navigationItem.rightBarButtonItem = saveButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handlePresenter(update: TaskEditModulePresenterUpdate) {
        switch update {
        case .setup(let title, let brief):
            navigationItem.title = title
            briefTextView.text = brief
        case .updateCanSave(let canSave):
            saveButton.isEnabled = canSave
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(briefTextView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = getLayout(size: view.bounds.size)
        briefTextView.frame = layout.briefTextViewFrame
    }
    
    private func getLayout(size: CGSize) -> Layout {
        Layout(
            bounds: CGRect(origin: .zero, size: size),
            safeAreaInsets: view.safeAreaInsets
        )
    }
    
    @objc private func handleCancelButton() {
        pipeline.notify(intent: .cancel)
    }
    
    @objc private func handleSaveButton() {
        pipeline.notify(intent: .save)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let brief = textView.text ?? String()
        pipeline.notify(intent: .briefChange(brief))
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    let safeAreaInsets: UIEdgeInsets
    
    var briefTextViewFrame: CGRect {
        let topY = safeAreaInsets.top
        return CGRect(x: 0, y: topY, width: bounds.width, height: 200).insetBy(dx: 15, dy: 10)
    }
}
