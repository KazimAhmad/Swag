//
//  LoginViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import Foundation
import SwiftUI

protocol LoginViewModelProtocol: ObservableObject {
    var emailOrUsername: String { get set }
    var password: String { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    @Published var emailOrUsername: String = ""
    @Published var password: String = ""
}
