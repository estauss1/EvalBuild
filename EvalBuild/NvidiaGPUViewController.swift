//
//  NvidiaGPUViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class NvidiaGPUViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var buildVCRef: BuildViewController?
    
    @IBOutlet weak var NvidiaGPUColl: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    let RTX4090 = GPU(manufacturuer: .Nvidia, averagePrice: 2000, name: "RTX 4090", maxWattsDrawn: 450)
    let RTX4080 = GPU(manufacturuer: .Nvidia, averagePrice: 1200, name: "RTX 4080", maxWattsDrawn: 320)
    let RTX4070 = GPU(manufacturuer: .Nvidia, averagePrice: 570, name: "RTX 4070", maxWattsDrawn: 200)
    let RTX4060 = GPU(manufacturuer: .Nvidia, averagePrice: 330, name: "RTX 4060", maxWattsDrawn: 115)
    
    let identifiers = ["RTX4090", "RTX4080", "RTX4070", "RTX4060"]
    
    var gpus: [GPU] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gpus = [RTX4090, RTX4080, RTX4070, RTX4060]
        
        NvidiaGPUColl.delegate = self
        NvidiaGPUColl.dataSource = self
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
