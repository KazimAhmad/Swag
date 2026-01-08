//
//  RegisterViewModel.swift
//  Swag
//
//  Created by Kazim Ahmad on 08/01/2026.
//

import SwiftUI

protocol RegisterViewModelProtocol: ObservableObject {
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
}

class RegisterViewModel: RegisterViewModelProtocol {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

}
