//
//  TaskManager.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

protocol ITaskManager: AnyObject {
    func attachListener(callback: @escaping ([Task]) -> Void) -> UUID
    func removeListener(uid: UUID)
    
    var tasks: [Task] { get }
    func createTask(brief: String)
    func modifyTask(uid: UUID, block: (Task) -> Task)
    func removeTask(uid: UUID)
}

final class TaskManager: ITaskManager {
    private(set) var tasks = [Task]()
    
    private var listeners = [UUID: ([Task]) -> Void]()
    
    init() {
        tasks = [
            Task(uid: UUID(), brief: "Just a welcome task", creationDate: Date()),
            Task(uid: UUID(), brief: "And its neighbor", creationDate: Date()),
        ]
    }
    
    func attachListener(callback: @escaping ([Task]) -> Void) -> UUID {
        let uid = UUID()
        listeners[uid] = callback
        callback(tasks)
        return uid
    }
    
    func removeListener(uid: UUID) {
        listeners.removeValue(forKey: uid)
    }
    
    func createTask(brief: String) {
        let task = Task(uid: UUID(), brief: brief, creationDate: Date())
        tasks.append(task)
        notifyListeners()
    }
    
    func modifyTask(uid: UUID, block: (Task) -> Task) {
        guard let index = taskIndex(by: uid) else {
            return
        }
        
        tasks[index] = block(tasks[index])
        notifyListeners()
    }
    
    func removeTask(uid: UUID) {
        guard let index = taskIndex(by: uid) else {
            return
        }
        
        tasks.remove(at: index)
        notifyListeners()
    }
    
    private func taskIndex(by uid: UUID) -> Int? {
        return tasks.firstIndex(where: { $0.uid == uid })
    }
    
    private func notifyListeners() {
        listeners.map(\.value).forEach { block in
            block(tasks)
        }
    }
}
