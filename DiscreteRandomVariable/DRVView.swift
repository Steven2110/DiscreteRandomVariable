//
//  DRVView.swift
//  DiscreteRandomVariable
//
//  Created by Steven Wijaya on 09.05.2023.
//

import SwiftUI
import Charts

struct DRVView: View {
    
    @State private var experiments: String = ""
    private var n: Int {
        Int(experiments)!
    }
    
    @State private var prob1: String = "0.0"
    @State private var prob2: String = "0.0"
    @State private var prob3: String = "0.0"
    @State private var prob4: String = "0.0"
    private var prob5: String {
        let result: Double = 1.0 - Double(prob1)! - Double(prob2)! - Double(prob3)! - Double(prob4)!
        return String(format: "%.2f", result)
    }
    
    @ObservedObject private var vm: DRVEventViewModel = DRVEventViewModel()
    
    var body: some View {
        HSplitView {
            VStack(alignment: .leading) {
                DRVTextField(text: "Number of experiments", data: $experiments)
                DRVTextField(text: "Prob 1", data: $prob1).onChange(of: prob1) { _ in
                    vm.updateEventProb(forEvent: 0, withProb: Double(prob1)!)
                    vm.updateEventProb(forEvent: 4, withProb: Double(prob5)!)
                }
                DRVTextField(text: "Prob 2", data: $prob2).onChange(of: prob2) { _ in
                    vm.updateEventProb(forEvent: 1, withProb: Double(prob2)!)
                    vm.updateEventProb(forEvent: 4, withProb: Double(prob5)!)
                }
                DRVTextField(text: "Prob 3", data: $prob3).onChange(of: prob3) { _ in
                    vm.updateEventProb(forEvent: 2, withProb: Double(prob3)!)
                    vm.updateEventProb(forEvent: 4, withProb: Double(prob5)!)
                }
                DRVTextField(text: "Prob 4", data: $prob4).onChange(of: prob4) { _ in
                    vm.updateEventProb(forEvent: 3, withProb: Double(prob4)!)
                    vm.updateEventProb(forEvent: 4, withProb: Double(prob5)!)
                }
                HStack {
                    Text("Prob 5:  \(prob5)")
                }
                Button {
                    vm.generateAllEvents(n: n)
                } label: {
                    Text("Go")
                        .frame(width: 50, height: 20)
                        .padding()
                }
            }
            .padding()
            .frame(minWidth: 300, maxWidth: 300, maxHeight: .infinity)
            VStack {
                Chart(vm.events) {
                    BarMark(x: .value("Event name", $0.name), y: .value("Frequency", $0.frequency))
                }.padding()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Average: \(vm.mean, specifier: "%.3f")")
                        Text("Error: \(vm.meanError, specifier: "%.3f") %")
                    }
                    VStack(alignment: .leading) {
                        Text("Variance: \(vm.variance, specifier: "%.3f")")
                        Text("Error: \(vm.varianceError, specifier: "%.3f") %")
                    }
                    Text("Chi square: \(vm.chiSquare, specifier: "%.3f") \(vm.chiSquare > 9.488 ? ">" : "<") 9.488")
                }.padding()
            }
        }
        .onAppear {
            vm.insertAllEvents([prob1, prob2, prob3, prob4, prob5])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DRVView()
    }
}
