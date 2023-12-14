//
//  AMDCPUViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class AMDCPUViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var selectedLabel: UILabel!
    
    @IBOutlet weak var AMDCPUCollRef: UICollectionView!
    
    var buildVCRef: BuildViewController?
    
    let R97900X = CPU(averagePrice: 370, name: "Ryzen 9 7900X", maxWattageDraw: 230, generation: .Zen4, model: .Ryzen9)
    let R77800X3D = CPU(averagePrice: 340, name: "Ryzen 7 7800X3D", maxWattageDraw: 162, generation: .Zen4, model: .Ryzen7)
    let R77700X = CPU(averagePrice: 300, name: "Ryzen 7 7700X", maxWattageDraw: 142, generation: .Zen4, model: .Ryzen7)
    let R95900X = CPU(averagePrice: 270, name: "Ryzen 9 5900X", maxWattageDraw: 142, generation: .Zen3, model: .Ryzen9)
    let R75800X3D = CPU(averagePrice: 310, name: "Ryzen 7 5800X3D", maxWattageDraw: 142, generation: .Zen3, model: .Ryzen7)
    let R55600X = CPU(averagePrice: 140, name: "Ryzen 5 5600X", maxWattageDraw: 88, generation: .Zen3, model: .Ryzen5)
    
    let identifiers = ["7900X", "7800X3D", "7700X", "5900X", "5800X3D", "5600X"]
    
    var cpus: [CPU] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cpus = [R97900X, R77800X3D, R77700X, R95900X, R75800X3D, R55600X]
        
        AMDCPUCollRef.delegate = self
        AMDCPUCollRef.dataSource = self
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
        buildVCRef?.parts[1] = cpus[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected CPU: \(cpus[indexPath.row].name)"
    }

}
