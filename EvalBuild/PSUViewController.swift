//
//  PSUViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class PSUViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?

    let identifiers = ["650w", "750w", "850w", "1000w", "1200w", "1300w", "1600w"]
    
    let w650 = PSU(averagePrice: 90, wattage: .w650, size: .ATX)
    let w750 = PSU(averagePrice: 100, wattage: .w750, size: .ATX)
    let w850 = PSU(averagePrice: 120, wattage: .w850, size: .ATX)
    let w1000 = PSU(averagePrice: 160, wattage: .w1000, size: .ATX)
    let w1200 = PSU(averagePrice: 200, wattage: .w1200, size: .ATX)
    let w1300 = PSU(averagePrice: 210, wattage: .w1300, size: .ATX)
    let w1600 = PSU(averagePrice: 270, wattage: .w1600, size: .ATX)
    
    var psus: [PSU] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        psus = [w650, w750, w850, w1000, w1200, w1300, w1600]
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 7 }
    
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
        buildVCRef?.parts[7] = psus[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected PSU: " + (buildVCRef?.parts[7]?.name ?? "Unknown")
    }

}
