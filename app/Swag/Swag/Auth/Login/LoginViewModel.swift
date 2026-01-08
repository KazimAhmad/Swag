//
//  LoginViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 07/01/2026.
//

import Foundation
import SwiftUI

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    @Published var email: String = ""
    @Published var password: String = ""
}
