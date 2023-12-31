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
    let manufacturuer: Manufacturer;
    
    init(manufacturuer: Manufacturer, averagePrice: Float, name: String,
         maxWattsDrawn: Int){
        self.manufacturuer = manufacturuer
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: maxWattsDrawn)
    }
    
    func IsCompatible(with aCase: Case) -> Compatibility {
        let compat: Compatibility
        if(aCase.size == .MiniTower){
            compat = .Caution
        }else{
            compat = .Compatible
        }
        return compat
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
enum MoboSize: String{
    case ATX = "ATX"
    case microATX = "MicroATX"
    case MiniITX = "MiniITX"
}

class Motherboard: PCPart{
    public let chipset: Chipset
    public let size: MoboSize
    public let compatibleManufacturer: Manufacturer
    
    init(averagePrice: Float, chipset: Chipset, size: MoboSize){
        self.chipset = chipset
        self.size = size
        
        //initialize compatible manufacturer based on chipset
        if(self.chipset == Chipset.Z690 || self.chipset == Chipset.Z790){
            compatibleManufacturer = Manufacturer.Intel
        }else{
            compatibleManufacturer = Manufacturer.AMD
        }
        
        let name = self.size.rawValue + " " + self.chipset.rawValue
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 50)
    }
    
    func IsCompatible(with cpu: CPU) -> Compatibility {
        return (cpu.compatibleChipsets.contains(chipset)) ? .Compatible : .Incompatible
    }
}

enum Generation {
    case Zen3
    case Zen4
    case Twelfth
    case Thirteenth
    case Fourteenth
}

enum CPUModel{
    case Ryzen5
    case Ryzen7
    case Ryzen9
    case i5
    case i7
    case i9
}

class CPU: PCPart {
    public let generation: Generation
    private let manufacturer: Manufacturer
    public let model: CPUModel
    public let compatibleChipsets: [Chipset]
    
    init(averagePrice: Float, name: String, maxWattageDraw: Int,
         generation: Generation, model: CPUModel) {
        self.generation = generation
        self.model = model
        
        var chipsetList: [Chipset] = []
        switch generation {
        case .Zen3:
            chipsetList.append(.B550)
            chipsetList.append(.X570)
            manufacturer = Manufacturer.AMD
        case .Zen4:
            chipsetList.append(.B650)
            chipsetList.append(.X670)
            manufacturer = Manufacturer.AMD
        case .Twelfth, .Thirteenth, .Fourteenth:
            chipsetList.append(.Z690)
            chipsetList.append(.Z790)
            manufacturer = Manufacturer.Intel
        }
        
        compatibleChipsets = chipsetList
        
        super.init(averagePrice: averagePrice, name: name,
                   maxWattsDrawn: maxWattageDraw)       
    }
}

//raw values are # of GB
enum StorageCapacity: String{
    case HalfTB = "500GB"
    case OneTB = "1TB"
    case TwoTB = "2TB"
    case FourTB = "4TB"
    case EightTB = "8TB"
}

enum StorageType: String{
    case HDD = "HDD"
    case SATA = "SATA SSD"
    case NVME = "NVME SSD"
}

class Storage: PCPart{
    private let capacity: StorageCapacity
    private let type: StorageType
    
    init(averagePrice: Float, capacity: StorageCapacity,
         type: StorageType){
        self.capacity = capacity
        self.type = type
        
        let name = self.capacity.rawValue + " " + self.type.rawValue
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 10)
    }
}


enum PSUWattage: Float{
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
        
        let name = String(self.wattage.rawValue) + " watts"
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 0)
    }
    
    func IsCompatible(with parts: [PCPart?]) -> Compatibility{
        var maxSystemLoad: Float = 0.0
        for part in parts{
            if let part{
                maxSystemLoad += Float(part.maxWattsDrawn)
            }
            else{
                print("nil passed to psu iscompat")
            }
        }
        
        let overhead = maxSystemLoad * 0.2
        maxSystemLoad += overhead
        
        let compat: Compatibility
        if(wattage.rawValue < maxSystemLoad){
            compat = .Incompatible
        }else{
            compat = .Compatible
        }
        
        return compat
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
    
    func IsCompatible(with cooler: Cooler) -> Compatibility{
        let compat: Compatibility
        
        if(size == CaseSize.FullTower){ //compatible with all coolers
            compat = Compatibility.Compatible
        } else if(size == CaseSize.MidTower){
            
            switch cooler.type{
            case .Water360:
                compat = Compatibility.Incompatible
            case .SingleTowerAir, .DualTowerAir:
                compat = Compatibility.Caution
            default:
                compat = Compatibility.Compatible
            }
            
        }else{ //minitower
            
            switch cooler.type{
            case .Water360, .DualTowerAir, .SingleTowerAir:
                compat = Compatibility.Incompatible
            case .Water240:
                compat = Compatibility.Caution
            default:
                compat = Compatibility.Compatible
            }
        }
        
        return compat
    }
    
}

enum CoolerType{
    case Water360
    case Water240
    case Water120
    case DualTowerAir
    case SingleTowerAir
    case LowProfileAir
}

class Cooler: PCPart {
    public let type: CoolerType
    
    init(averagePrice: Float, type: CoolerType){
        self.type = type
        
        var maxWatts: Int
        let caseFanWatts = 3
        let pumpWatts = 30
        let name: String
        
        switch self.type{
        case .LowProfileAir:
            maxWatts = caseFanWatts
            name = "Low Profile Air Cooler"
        case .SingleTowerAir:
            maxWatts = caseFanWatts
            name = "Single Tower Air Cooler"
        case .DualTowerAir:
            maxWatts = caseFanWatts * 2
            name = "Dual Tower Air Cooler"
        case .Water120:
            maxWatts = pumpWatts + caseFanWatts
            name = "120mm Water Cooler"
        case .Water240:
            maxWatts = pumpWatts + caseFanWatts * 2
            name = "240mm Water Cooler"
        case .Water360:
            maxWatts = pumpWatts + caseFanWatts * 3
            name = "360mm Water Cooler"
        }
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: maxWatts)
    }
    
    func IsCompatible(with cpu: CPU) -> Compatibility {
        let compat: Compatibility
        if(cpu.model == .Ryzen9 || cpu.model == .i9 || cpu.model == .i7){
            switch type{
            case .LowProfileAir, .SingleTowerAir, .Water120:
                compat = .Caution
            default:
                compat = .Compatible
            }
        }
        else{
            compat = .Compatible
        }
        
        return compat
    }
    
}

enum DDRGeneration: String{
    case DDR4 = "DDR4"
    case DDR5 = "DDR5"
}

enum RAMSpeed: Int{
    case mhz3200 = 3200
    case mhz3600 = 3600
    case mhz4400 = 4400
    case mhz5600 = 5600
    case mhz6000 = 6000
    case mhz6400 = 6400
}

enum RAMAmount: Int{
    case gb16 = 16
    case gb32 = 32
    case gb64 = 64
}

class RAM: PCPart{
    let gen: DDRGeneration
    let speed: RAMSpeed
    let amount: RAMAmount
    
    init(averagePrice: Float, speed: RAMSpeed, amount: RAMAmount){
        self.speed = speed
        self.amount = amount
        
        if(self.speed == .mhz3200 || self.speed == .mhz3600
           || self.speed == .mhz4400){
            gen = DDRGeneration.DDR4
        }
        else{
            gen = DDRGeneration.DDR5
        }
        
        let name = "\(self.amount.rawValue)GB " + gen.rawValue + " \(self.speed.rawValue)"
        
        super.init(averagePrice: averagePrice, name: name, maxWattsDrawn: 5)
    }
    
    func IsCompatible(with motherboard: Motherboard) -> Compatibility {
        let compat: Compatibility
        
        if(motherboard.chipset == .B550 || motherboard.chipset == .X570){
            switch gen{
            case .DDR4:
                compat = .Compatible
            case .DDR5:
                compat = .Incompatible
            }
        } 
        else if(motherboard.chipset == .X670 || motherboard.chipset == .B650){
            switch gen{
            case .DDR4:
                compat = .Incompatible
            case .DDR5:
                compat = .Compatible
            }
        }
        else{ //z690 and z790
            compat = .Caution //some models accept ddr4, others accept ddr5
        }
    
        return compat
    }
    
}





