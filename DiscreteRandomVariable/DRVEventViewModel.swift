//
//  DRVEventViewModel.swift
//  DiscreteRandomVariable
//
//  Created by Steven Wijaya on 10.05.2023.
//

import Foundation

final class DRVEventViewModel: ObservableObject {
    @Published var events: [Event] = [Event]()
    
    @Published var mean: Double = 0.0
    @Published var empiricMean: Double = 0.0
    @Published var meanError: Double = 0.0
    
    @Published var variance: Double = 0.0
    @Published var empiricVariance: Double = 0.0
    @Published var varianceError: Double = 0.0
    
    @Published var chiSquare: Double = 0.0
    
    func insertAllEvents(_ eventsProb: [String]) {
        for (i, eventProb) in eventsProb.enumerated() {
            let eventName = "Prob \(i + 1)"
            let prob = Double(eventProb)!
            events.append(Event(name: eventName, prob: prob))
        }
    }
    
    func updateEventProb(forEvent: Int, withProb: Double) {
        events[forEvent].prob = withProb
    }
    
    func generateAllEvents(n: Int) {
        for _ in 0..<n {
            let random: Double = Double.random(in: 0.0...1.0)
            print("Random \(random)")
            var curProb = events[0].prob
            var i = 0
            while(curProb < random) {
                i += 1
                print(i)
                print(curProb)
                print(events[i].prob)
                curProb += events[i].prob
            }
            events[i].occurence += 1
        }
        
        for i in 0..<events.count {
            events[i].calculateFrequency(n: n)
        }
        
        calculateMeanEmpMeanError()
        calculateVarEmpVarError()
        calculateChiSquare(n: n)
    }
    
    func calculateMeanEmpMeanError() {
        for (i, event) in events.enumerated() {
            mean += Double(i + 1) * event.prob
            empiricMean += Double(i + 1) * event.frequency
        }
        
        meanError = abs(empiricMean - mean) / abs(mean)
    }
    
    func calculateVarEmpVarError() {
        for (i, event) in events.enumerated() {
            variance += Double((i + 1) * (i + 1)) * event.prob
            empiricVariance += Double((i + 1) * (i + 1)) * event.frequency
        }
        
        variance -= pow(mean, 2)
        empiricVariance -= pow(empiricMean, 2)
        
        varianceError = abs(empiricVariance - variance) / abs(variance)
    }
    
    func calculateChiSquare(n: Int) {
        for event in events {
            chiSquare += Double(event.occurence * event.occurence) / (Double(n) * event.prob)
        }
        print(chiSquare)
        chiSquare -= Double(n)
    }
}
