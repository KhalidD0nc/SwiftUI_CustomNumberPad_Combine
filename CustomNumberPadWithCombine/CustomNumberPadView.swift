//
//  CustomNumberPadView.swift
//  SwiftCustomNumPadCombine
//
//  Created by khalid doncic on 20/12/2023.
//

import SwiftUI

struct CustomNumberPadView: View {
    @StateObject  var input = viewModel(size: 10)
    @State private var amount: Double = 0
    let numbers = [
    [ "1","2","3"],
    [ "4","5","6"],
    ["7","8","9"],
    [".", "0", "delete.left"]
    ]
    var body: some View {
        ZStack {
            VStack(spacing: 60) {
                Spacer()
                TextField("Enter Number", text: $input.amount)
                    .frame(width: UIScreen.main.bounds.width - 140, height: 30)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    )
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                    )
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                Group {
                    NumberBadView
                }
//                .padding()
                .background(.white)
                .cornerRadius(30)
            }
            
         
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.2), .cyan.opacity(0.1) ,.black.opacity(0.1), .gray.opacity(0.1)]), startPoint: .topTrailing, endPoint: .bottomLeading))
        
        .ignoresSafeArea()
        
    }
}

struct CustomNumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNumberPadView()
    }
}
 

extension CustomNumberPadView  {


var NumberBadView: some View {
    VStack(spacing: 10) {
        ForEach(numbers, id: \.self) { row in
            HStack(spacing: 30) {
                ForEach(row, id: \.self) { number in
                    Button {
                        if number == "delete.left" {
                            input.handleBackSpace()
                        } else {
                            input.handleNumbers(number: number)
                        }
                    } label: {
                        if number == "delete.left" {
                            Image(systemName: "delete.left")
                                .frame(width: 55, height: 55)
                                .font(.system(size: 25, weight: .heavy))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(32)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
//                                    .padding()
                            
                        } else {
                            
                            
                            
                            Text(number)
                                
                                .frame(width: 65, height: 65)
                                .font(.system(size: 25, weight: .heavy))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(32)
                                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                              
                        }
                    }
                    .padding()
                }
            }
            .font(.system(size: 25, weight: .heavy))
            
            
        }
        
        
        Button {
            // Handle The Logic
        } label: {
            Text("Save")
                .foregroundColor(.black)
                .frame(width:  40, height: 60)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                )
                .padding(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .disabled(input.isValid)
    }
}



}

class PaymnetInput: ObservableObject {
@Published var amount = ""


func handleNumbers(number: String) {
    if amount.count < 6 {
        if number != "." {
            
            amount.append(number)
        } else {
            if !amount.contains(".") {
                amount.append(number)
            }
        }
    }
}
func handleBackSpace() {
    if amount.count > 0  {
        amount.removeLast()
    }
}


 func getCurrentValue(currentPrice: Double) -> Double{
    if let quantity = Double(amount) {
      
        return (quantity * currentPrice)
    }
    return 0
}

func getAmount() -> Double {
    return Double(amount) ?? 0
}





}

