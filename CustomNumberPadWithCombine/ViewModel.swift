//
//  ViewModel.swift
//  SwiftCustomNumPadCombine
//
//  Created by khalid doncic on 20/12/2023.
//

import Foundation
import Combine

class viewModel: ObservableObject {
    @Published var amount = ""
    @Published var isValid: Bool = false
    let size: Int // Assign the length of the string to the variable 'size'
    var cancellables = Set<AnyCancellable>()
    private let numberButton = PassthroughSubject<String, Never>()
    init(size: Int) {
        self.size = size
        addSub()
    }
    
    
    
    func handleNumbers(number: String) {
        numberButton.send(number)
    }
    
    func handleBackSpace() {
        guard amount.count != 0 else {return}
        numberButton.send("delete.left")
    }
    
    private func addSub() {
        numberButton
            .sink { [weak self] button in
                self?.handleLogic(button: button)
            }
            .store(in: &cancellables)
        
        $amount
            .map { !$0.isEmpty }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
        
        
        
    }
    
    func handleLogic(button: String)  {
        if button == "delete.left" {
            amount.removeLast()
        } else if amount.count < size {
            if button != "." {
                amount.append(button)
            } else {
                if amount.isEmpty {
                   
                    amount = "0."
                } else if amount.first == "." {
              
                    amount = "0" + amount
                } else if !amount.contains(".") {
                    amount.append(button)
                }
            }
        }
        self.isValid = amount.isEmpty 
    }
    
    
}
