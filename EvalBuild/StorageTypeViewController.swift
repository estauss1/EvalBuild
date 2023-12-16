//
//  StorageTypeViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class StorageTypeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var buildVCRef: BuildViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 3 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        
        switch indexPath.row{
        case 0:
            identifier = "HDD"
        case 1:
            identifier = "SATA"
        case 2:
            identifier = "NVME"
        default:
            print("went past 3 cell rows inside motherboardgroup")
            identifier = "Unknown"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let StorageAmountVCRef = segue.destination as? StorageAmountViewController
        
        if let StorageAmountVCRef{
            StorageAmountVCRef.buildVCRef = buildVCRef
            
            switch segue.identifier{
            case "SegueFromHDD":
                StorageAmountVCRef.type = .HDD
            case "SegueFromSATA":
                StorageAmountVCRef.type = .SATA
            case "SegueFromNVME":
                StorageAmountVCRef.type = .NVME
            default:
                print("storage segue identifier didnt match")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Adjust the spacing as needed
    }

}
