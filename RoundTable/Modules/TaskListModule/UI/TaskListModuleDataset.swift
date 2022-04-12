//
//  TaskListModuleDataset.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation
import UIKit

protocol ITaskListModuleDataset: UITableViewDataSource, UITableViewDelegate {
    func register(in tableView: UITableView, callback: @escaping (TaskListModuleDatasetAction) -> Void)
    func update(tasks: [TaskListModulePresenterTaskModel], in tableView: UITableView)
}

enum TaskListModuleDatasetAction {
    case pick(index: Int)
    case delete(index: Int)
}

final class TaskListModuleDataset: NSObject,  ITaskListModuleDataset {
    private var tasks = [TaskListModulePresenterTaskModel]()
    private var callback: ((TaskListModuleDatasetAction) -> Void)?
    
    func register(in tableView: UITableView, callback: @escaping (TaskListModuleDatasetAction) -> Void) {
        self.callback = callback
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    func update(tasks: [TaskListModulePresenterTaskModel], in tableView: UITableView) {
        self.tasks = tasks
        tableView.reloadData()
    }
    
    private subscript(index: Int) -> TaskListModulePresenterTaskModel {
        return tasks[index]
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = self[indexPath.row]
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = task.brief
        cell.detailTextLabel?.text = task.deadline
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        callback?(.pick(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(
            actions: [
                UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
                    self?.callback?(.delete(index: indexPath.row))
                    completion(true)
                }
            ]
        )
    }
}
