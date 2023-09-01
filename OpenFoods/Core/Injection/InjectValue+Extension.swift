//
//  InjectValue+Extension.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
import Poppify

private struct ClientProviderKey: InjectionKey {
    static var currentValue: Client = FoodClient()
}

private struct SessionProviderKey: InjectionKey {
    static var currentValue: URLSessionType = URLSession.shared
}

private struct EnvironmentProviderKey: InjectionKey {
    static var currentValue: EnvironmentType = Environment(scheme: .secure,
                                                           endpoint: "opentable-dex-ios-test-d645a49e3287.herokuapp.com",
                                                           additionalHeaders: [:],
                                                           port: nil,
                                                           secret: nil)
}

extension InjectedValues {
    
    var clientProvider: Client {
        get { Self[ClientProviderKey.self] }
        set { Self[ClientProviderKey.self] = newValue }
    }
    
    var sessionProvider: URLSessionType {
        get { Self[SessionProviderKey.self] }
        set { Self[SessionProviderKey.self] = newValue }
    }
    
    var environmentProvider: EnvironmentType {
        get { Self[EnvironmentProviderKey.self] }
        set { Self[EnvironmentProviderKey.self] = newValue }
    }
}
