//
//  RAMAmountViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class RAMAmountViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    //passed data from prev VC
    var buildVCRef: BuildViewController?
    var speed: RAMSpeed?
    
    var amounts: [RAMAmount] = [.gb16, .gb32, .gb64]
    
    let identifiers = ["16GB", "32GB", "64GB"]
    
    var ramCreated: RAM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers[indexPath.row], for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 125)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Adjust the spacing as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Iterate through all visible cells and reset their appearance
        collectionView.visibleCells.forEach { cell in
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
        }
        
        // Update appearance of the selected cell (e.g., highlighting or adding a border)
        if let selectedCell = collectionView.cellForItem(at: indexPath) {
            selectedCell.contentView.layer.borderWidth = 2.0
            selectedCell.contentView.layer.borderColor = UIColor.blue.cgColor
        }
        
        let ramAmountSelected = amounts[indexPath.row]
        let price: Float
        
        if let speed {
            if(speed == .mhz3200){
                switch ramAmountSelected{
                case .gb16:
                    price = 30
                case .gb32:
                    price = 70
                case .gb64:
                    price = 130
                }
            }
            else if(speed == .mhz3600){
                 switch ramAmountSelected{
                case .gb16:
                    price = 40
                 case .gb32:
                    price = 65
                 case .gb64:
                    price = 130
                }
            }
            else if(speed == .mhz4400){ 
                switch ramAmountSelected{
                case .gb16:
                    price = 60
                case .gb32:
                    price = 100
                case .gb64:
                    price = 210
                }
                
            }
            else if(speed == .mhz5600){
                 switch ramAmountSelected{
                case .gb16:
                    price = 50
                 case .gb32:
                    price = 90
                 case .gb64:
                    price = 200
                }
            }
            else if(speed == .mhz6000){
                 switch ramAmountSelected{
                case .gb16:
                    price = 65
                 case .gb32:
                    price = 100
                 case .gb64:
                    price = 200
                }
            }
            else if(speed == .mhz6400){
                  switch ramAmountSelected{
                case .gb16:
                    price = 85
                  case .gb32:
                    price = 100
                  case .gb64:
                    price = 215
                }
            }
            else{
                fatalError("speed was a weird value in ramamountvc")
            }
            
            // Assign the appropriate ram to buildVCRef.parts[2]
            buildVCRef?.parts[2] = RAM(averagePrice: price, speed: speed, amount: ramAmountSelected)
            
            buildVCRef?.partsTable.reloadData()
            
        } else{
            fatalError("Speed was nil inside ramamountvc")
        }


        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected RAM: " + (buildVCRef?.parts[2]?.name ?? "Unknown RAM")
    }

}
