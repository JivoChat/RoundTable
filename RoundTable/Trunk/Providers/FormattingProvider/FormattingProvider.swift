//
//  FormattingProvider.swift
//  RoundTable
//
//  Created by Stan Potemkin on 10.04.2022.
//

import Foundation

protocol IFormattingProvider: AnyObject {
    func format(date: Date, kind: FormattingProviderDateKind) -> String
}

enum FormattingProviderDateKind {
    case short
    case full
}

final class FormattingProvider: IFormattingProvider {
    private let dateFormatter = DateFormatter()
    
    init(locale: Locale) {
        dateFormatter.locale = locale
    }
    
    func format(date: Date, kind: FormattingProviderDateKind) -> String {
        switch kind {
        case .short:
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
        case .full:
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
        }
        
        return dateFormatter.string(from: date)
    }
}
