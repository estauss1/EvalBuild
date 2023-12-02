//
//  PCPart.swift
//  EvalBuild
//
//  Created by Eric Stauss on 11/30/23.
//

import Foundation

enum DealRating: String {
    case veryBad = "Very Bad"
    case bad = "Bad"
    case okay = "Okay"
    case good = "Good"
    case veryGood = "Very Good"
}

enum Compatibility: String{
    case Incompatible = "Incompatible"
    case Caution = "Caution"
    case Compatible = "Compatible"
}

class PCPart{
    public var averagePrice : Float
    public var name : String
    public var maxWattsDrawn: Int
    
    init(averagePrice: Float, name: String, maxWattsDrawn: Int) {
        self.averagePrice = averagePrice
        self.name = name
        self.maxWattsDrawn = maxWattsDrawn
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

enum Manufacturer: String{
    case Intel = "Intel"
    case AMD = "AMD"
    case Nvidia = "Nvidia"
}

class GPU: PCPart {
    var manufacturuer: Manufacturer;
    
    init(manufacturuer: Manufacturer, averagePrice: Float, name: String,
         maxWattsDrawn: Int){
        self.manufacturuer = manufacturuer
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: maxWattsDrawn)
    }
}

enum Chipset: String{
    case B650 = "B650"
    case X670 = "X670"
    case B550 = "B550"
    case X570 = "X570"
    case Z690 = "Z690"
    case Z790 = "Z790"
}

//higher raw value means larger in size
enum MoboSize: Int{
    case ATX = 3
    case microATX = 2
    case MiniITX = 1
}

class Motherboard: PCPart{
    private let chipset: Chipset
    public let size: MoboSize
    public let compatibleManufacturer: Manufacturer
    
    init(averagePrice: Float, name: String, chipset: Chipset, size: MoboSize){
        self.chipset = chipset
        self.size = size
        
        //initialize compatible manufacturer based on chipset
        if(self.chipset == Chipset.Z690 || self.chipset == Chipset.Z790){
            compatibleManufacturer = Manufacturer.Intel
        }else{
            compatibleManufacturer = Manufacturer.AMD
        }
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 50)
    }
}

enum Generation {
    case Zen3
    case Zen4
    case Twelfth
    case Thirteenth
    case Fourteenth
}

class CPU: PCPart {
    public let generation: Generation
    public let compatibleChipsets: [Chipset]
    
    init(averagePrice: Float, name: String, maxWattageDraw: Int,
         generation: Generation) {
        self.generation = generation
        
        var chipsetList: [Chipset] = []
        switch generation {
        case .Zen3:
            chipsetList.append(.B550)
            chipsetList.append(.X570)
        case .Zen4:
            chipsetList.append(.B650)
            chipsetList.append(.X670)
        case .Twelfth, .Thirteenth, .Fourteenth:
            chipsetList.append(.Z690)
            chipsetList.append(.Z790)
        }
        
        compatibleChipsets = chipsetList
        
        super.init(averagePrice: averagePrice, name: name,
                   maxWattsDrawn: maxWattageDraw)       
    }
}

//raw values are # of GB
enum StorageCapacity: Int{
    case HalfTB = 500
    case OneTB = 1000
    case TwoTB = 2000
    case FourTB = 4000
    case EightTB = 8000
}

enum StorageType{
    case HDD
    case SATA
    case NVME
}

class Storage: PCPart{
    private let capacity: StorageCapacity
    private let type: StorageType
    
    init(averagePrice: Float, name: String, capacity: StorageCapacity,
         type: StorageType){
        self.capacity = capacity
        self.type = type
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 10)
    }
}


enum PSUWattage: Int{
    case w650 = 650
    case w750 = 750
    case w850 = 850
    case w1000 = 1000
    case w1200 = 1200
    case w1300 = 1300
    case w1600 = 1600
}

enum PSUSize: Int {
    case ATX = 2
    case SFX = 1
}

class PSU: PCPart{
    private let wattage: PSUWattage
    private let size: PSUSize
    
    init(averagePrice: Float, wattage: PSUWattage, size: PSUSize){
        self.wattage = wattage
        self.size = size
        
        var name = String(self.wattage.rawValue) + " watts"
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 0)
    }
}

enum CaseSize: Int{
    case FullTower = 3
    case MidTower = 2
    case MiniTower = 1
}

class Case: PCPart{
    public let size: CaseSize
    private let supportedMoboSizes: [MoboSize]
    
    init(averagePrice: Float, name: String, size: CaseSize){
        self.size = size
        
        var supported: [MoboSize] = []
        switch self.size {
        case .FullTower, .MidTower:
            supported.append(MoboSize.ATX)
            supported.append(MoboSize.microATX)
            fallthrough
        case .MiniTower:
            supported.append(MoboSize.MiniITX)
        }
        supportedMoboSizes = supported
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 0)
    }
    
    func IsCompatible(with motherboard: Motherboard) -> Compatibility {
        if(supportedMoboSizes.contains(motherboard.size)){
            return Compatibility.Compatible
        }else {
            return Compatibility.Incompatible
        }
    }
    
    //func IsCompatible(with )
}

enum CoolerType{
    case Water360
    case Water240
    case Water120
    case DualTowerAir
    case SingleTowerAir
    case LowProfileAir
}









