//
//  Trunk.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

protocol ITrunk: AnyObject {
    var taskManager: ITaskManager { get }
    var formattingProvider: IFormattingProvider { get }
}

final class Trunk: ITrunk {
    let taskManager: ITaskManager
    let formattingProvider: IFormattingProvider

    init(locale: Locale) {
        taskManager = TaskManager()
        formattingProvider = FormattingProvider(locale: locale)
    }
}
