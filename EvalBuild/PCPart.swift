//
//  PCPart.swift
//  EvalBuild
//
//  Created by Eric Stauss on 11/30/23.
//

import Foundation

enum DealRating {
    case veryBad
    case bad
    case okay
    case good
    case veryGood
}

class PCPart{
    var averagePrice : Float;
    var name : String;
    
    init(averagePrice: Float, name: String) {
        self.averagePrice = averagePrice
        self.name = name
    }
    
    //returns a DealRating based on the amount paid over/under average price
    func EvaluatePayingPrice(payingPrice: Float) -> DealRating {
        let percentage: Float = (payingPrice / averagePrice - 1) * 100;
        
        var dealRating: DealRating;
        if(percentage < -25){
            dealRating = DealRating.veryBad
        }else if(percentage >= -25 && percentage < -5){
            dealRating = DealRating.bad
        }else if(percentage >= -5 && percentage <= 5){
            dealRating = DealRating.okay
        }else if(percentage > 5 && percentage <= 25){
            dealRating = DealRating.good
        }else{
            dealRating = DealRating.veryGood
        }
        
        return dealRating;
    }
    
}


