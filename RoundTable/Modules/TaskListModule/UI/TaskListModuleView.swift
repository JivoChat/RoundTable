//  
//  TaskListModuleView.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation
import UIKit

enum TaskListModuleViewIntent {
    case info
    case add
    case pick(index: Int)
    case delete(index: Int)
}

typealias TaskListModuleView = (
    // Feed free to replace it with *ViewController or *NavigationController
    TaskListModuleNavigationController
)

final class TaskListModuleNavigationController
: RTEModuleViewNavigatable<
TaskListModulePresenterUpdate,
TaskListModuleViewIntent
> {
    init(pipeline: RTEModulePipelineViewNotifier<TaskListModuleViewIntent>) {
        super.init(
            primaryView: TaskListModuleViewController(pipeline: pipeline)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class TaskListModuleViewController
: RTEModuleViewStandalone<
TaskListModulePresenterUpdate,
TaskListModuleViewIntent
> {
    private let tableView = UITableView()
    private let dataset = TaskListModuleDataset()
    
    override init(pipeline: RTEModulePipelineViewNotifier<TaskListModuleViewIntent>) {
        super.init(pipeline: pipeline)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(handleInfoButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(handleAddButton)
        )
        
        dataset.register(in: tableView) { action in
            switch action {
            case .pick(let index):
                pipeline.notify(intent: .pick(index: index))
            case .delete(let index):
                pipeline.notify(intent: .delete(index: index))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func handlePresenter(update: TaskListModulePresenterUpdate) {
        switch update {
        case .setup(let title):
            navigationItem.title = title
        case .tasks(let tasks):
            dataset.update(tasks: tasks, in: tableView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout = getLayout(size: view.bounds.size)
        tableView.frame = layout.tableViewFrame
    }
    
    private func getLayout(size: CGSize) -> Layout {
        Layout(
            bounds: CGRect(origin: .zero, size: size),
            safeAreaInsets: view.safeAreaInsets
        )
    }
    
    @objc private func handleInfoButton() {
        pipeline.notify(intent: .info)
    }
    
    @objc private func handleAddButton() {
        pipeline.notify(intent: .add)
    }
}

fileprivate struct Layout {
    let bounds: CGRect
    let safeAreaInsets: UIEdgeInsets
    
    var tableViewFrame: CGRect {
        return bounds
    }
}
