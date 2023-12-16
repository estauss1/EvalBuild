//
//  CaseViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class CaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?

    let identifiers = ["FullTower", "MidTower", "MiniTower"]
    
    let FullTower = Case(averagePrice: 130, name: "Full Tower Case", size: .FullTower)
    let MidTower = Case(averagePrice: 100, name: "Mid Tower Case", size: .MidTower)
    let MiniTower = Case(averagePrice: 150, name: "Mini Tower Case", size: .MiniTower)
    
    var cases: [Case] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cases = [FullTower, MidTower, MiniTower]
        
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

        // Assign the appropriate GPU to buildVCRef.parts[0]
        buildVCRef?.parts[6] = cases[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected Cooler: " + (buildVCRef?.parts[6]?.name ?? "Unknown")
    }

}
