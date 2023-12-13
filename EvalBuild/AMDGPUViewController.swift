//
//  AMDGPUViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class AMDGPUViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var AMDGPUCollRef: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?
    
    let RX7900XT = GPU(manufacturuer: .AMD, averagePrice: 780, name: "RX 7900 XT", maxWattsDrawn: 315)
    let RX7800XT = GPU(manufacturuer: .AMD, averagePrice: 525, name: "RX 7800 XT", maxWattsDrawn: 263)
    let RX7700XT = GPU(manufacturuer: .AMD, averagePrice: 450, name: "RX 7700 XT", maxWattsDrawn: 245)
    let RX7600 = GPU(manufacturuer: .AMD, averagePrice: 270, name: "RX 7600", maxWattsDrawn: 165)
    
    let identifiers = ["RX7900", "RX7800", "RX7700", "RX7600"]
    
    var gpus: [GPU] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpus = [RX7900XT, RX7800XT, RX7700XT, RX7600]
        
        AMDGPUCollRef.delegate = self
        AMDGPUCollRef.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 4 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers[indexPath.row], for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
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
        buildVCRef?.parts[0] = gpus[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected GPU: \(gpus[indexPath.row].name)"
    }
}
