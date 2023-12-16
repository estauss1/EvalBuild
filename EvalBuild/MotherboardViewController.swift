//
//  MotherboardViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class MotherboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?
    var moboSize: MoboSize?
    
    let identifiers = ["B650", "X670", "B550", "X570", "Z690", "Z790"]
    
    var chipsets: [Chipset] = [.B650, .X670, .B550, .X570, .Z690, .Z790]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 6 }
    
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
        
        let selectedChipset = chipsets[indexPath.row]
        let price: Float
        if let moboSize{
            if(moboSize == .ATX){
                switch selectedChipset{
                case .B650:
                    price = 200
                case .X670:
                    price = 250
                case .B550:
                    price = 130
                case .X570:
                    price = 140
                case .Z690:
                    price = 150
                case .Z790:
                    price = 200
                }
                
            }
            else if(moboSize == .microATX){
                switch selectedChipset{
                case .B650:
                    price = 150
                case .X670:
                    price = 500
                case .B550:
                    price = 120
                case .X570:
                    price = 200
                case .Z690:
                    price = 200
                case .Z790:
                    price = 200
                }
            }
            else{ //miniITX
                switch selectedChipset{
                case .B650:
                    price = 240
                case .X670:
                    price = 420
                case .B550:
                    price = 160
                case .X570:
                    price = 260
                case .Z690:
                    price = 200
                case .Z790:
                    price = 300
                }
            }
            
            buildVCRef?.parts[3] = Motherboard(averagePrice: price, chipset: selectedChipset, size: moboSize)
        }
        else{
            print("moboSize was nil inside motherboardviewcontroller")
        }
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected Motherboard: "  + (buildVCRef?.parts[3]?.name ?? "Unknown")
    }

}
