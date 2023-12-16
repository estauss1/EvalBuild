//
//  CoolerViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class CoolerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?

    let LPAir = Cooler(averagePrice: 50, type: .LowProfileAir)
    let SingleAir = Cooler(averagePrice: 40, type: .SingleTowerAir)
    let DualAir = Cooler(averagePrice: 70, type: .DualTowerAir)
    let Water120 = Cooler(averagePrice: 80, type: .Water120)
    let Water240 = Cooler(averagePrice: 100, type: .Water240)
    let Water360 = Cooler(averagePrice: 130, type: .Water360)
    
    let identifiers = ["LPAir", "SingleAir", "DualAir", "Water120", "Water240", "Water360"]
    
    var coolers: [Cooler] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coolers = [LPAir, SingleAir, DualAir, Water120, Water240, Water360]
        
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

        // Assign the appropriate GPU to buildVCRef.parts[0]
        buildVCRef?.parts[5] = coolers[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected Cooler: " + (buildVCRef?.parts[5]?.name ?? "Unknown")
    }

}
