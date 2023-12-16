//
//  StorageAmountViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class StorageAmountViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?
    var type: StorageType?
    
    let identifiers = ["HalfTB", "OneTB", "TwoTB", "FourTB", "EightTB"]
    
    var capacities: [StorageCapacity] = [.HalfTB, .OneTB, .TwoTB, .FourTB, .EightTB]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 5 }
    
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
        
        let selectedCapacity = capacities[indexPath.row]
        let price: Float
        if let type{
            if(type == .HDD){
                switch selectedCapacity{
                case .HalfTB:
                    price = 15
                case .OneTB:
                    price = 40
                case .TwoTB:
                    price = 60
                case .FourTB:
                    price = 90
                case .EightTB:
                    price = 130
                }
                
            }
            else if(type == .SATA){
                switch selectedCapacity{
                case .HalfTB:
                    price = 40
                case .OneTB:
                    price = 65
                case .TwoTB:
                    price = 100
                case .FourTB:
                    price = 210
                case .EightTB:
                    price = 500
                }
            }
            else{ // NVME
                switch selectedCapacity{
                case .HalfTB:
                    price = 50
                case .OneTB:
                    price = 60
                case .TwoTB:
                    price = 110
                case .FourTB:
                    price = 250
                case .EightTB:
                    price = 880
                }
            }
            
            buildVCRef?.parts[4] = Storage(averagePrice: price, capacity: selectedCapacity, type: type)
        }
        else{
            print("type was nil inside storageamountviewcontroller")
        }
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected Storage: "  + (buildVCRef?.parts[4]?.name ?? "Unknown")
    }


}
