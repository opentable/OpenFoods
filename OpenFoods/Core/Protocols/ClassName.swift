//
//  ClassName.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {

    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }

}

extension NSObject: ClassNameProtocol {}
