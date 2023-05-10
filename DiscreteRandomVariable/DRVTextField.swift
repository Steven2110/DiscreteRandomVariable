//
//  DRVTextField.swift
//  DiscreteRandomVariable
//
//  Created by Steven Wijaya on 10.05.2023.
//

import SwiftUI

struct DRVTextField: View {
    
    var text: String
    @Binding var data: String
    
    var body: some View {
        HStack {
            Text(text)
            TextField(text, text: $data)
        }
    }
}

struct DRVTextField_Previews: PreviewProvider {
    static var previews: some View {
        DRVTextField(text: "Prob 1", data: .constant(""))
    }
}
