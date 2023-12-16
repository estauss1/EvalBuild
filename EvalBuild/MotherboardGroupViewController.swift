//
//  MotherboardGroupViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class MotherboardGroupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            identifier = "miniITX"
        case 1:
            identifier = "microATX"
        case 2:
            identifier = "ATX"
        default:
            print("went past 3 cell rows inside motherboardgroup")
            identifier = "Unknown"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let MoboVCRef = segue.destination as? MotherboardViewController
        
        if let MoboVCRef{
            MoboVCRef.buildVCRef = buildVCRef
            
            switch segue.identifier{
            case "SegueFromMiniITX":
                MoboVCRef.moboSize = .MiniITX
            case "SegueFromMicroATX":
                MoboVCRef.moboSize = .microATX
            case "SegueFromATX":
                MoboVCRef.moboSize = .ATX
            default:
                print("motherboard segue identifier didnt match")
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
