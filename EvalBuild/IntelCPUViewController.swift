//
//  IntelCPUViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class IntelCPUViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var IntelCPUCollRef: UICollectionView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    var buildVCRef: BuildViewController?
    
    let i914900K = CPU(averagePrice: 550, name: "i9 14900K", maxWattageDraw: 253, generation: .Fourteenth, model: .i9)
    let i714700K = CPU(averagePrice: 380, name: "i7 14700K", maxWattageDraw: 253, generation: .Fourteenth, model: .i7)
    let i514600K = CPU(averagePrice: 300, name: "i5 14600K", maxWattageDraw: 181, generation: .Fourteenth, model: .i5)
    let i913900K = CPU(averagePrice: 520, name: "i9 13900K", maxWattageDraw: 253, generation: .Thirteenth, model: .i9)
    let i713700K = CPU(averagePrice: 350, name: "i7 13700K", maxWattageDraw: 253, generation: .Thirteenth, model: .i7)
    let i912900K = CPU(averagePrice: 320, name: "i9 12900K", maxWattageDraw: 241, generation: .Twelfth, model: .i9)
    let i712700K = CPU(averagePrice: 230, name: "i7 12700K", maxWattageDraw: 190, generation: .Twelfth, model: .i7)
    
    let identifiers = ["14900K", "14700K", "14600K", "13900K", "13700K", "12900K", "12700K"]
    
    var cpus: [CPU] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cpus = [i914900K, i714700K, i514600K, i913900K, i713700K, i912900K, i712700K]
        
        IntelCPUCollRef.delegate = self
        IntelCPUCollRef.dataSource = self
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
        buildVCRef?.parts[1] = cpus[indexPath.row]
        
        buildVCRef?.partsTable.reloadData()

        // Update the selectedLabel to display information about the selected GPU
        selectedLabel.text = "Selected CPU: \(cpus[indexPath.row].name)"
    }
}
