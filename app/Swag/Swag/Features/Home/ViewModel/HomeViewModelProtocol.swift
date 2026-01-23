//
//  HomeViewModelProtocol.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var info: String { get }
    func showAbout()
    func thoughtList()
    func seeMore(of thought: Thought)
}
