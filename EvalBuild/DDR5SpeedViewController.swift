//
//  DDR5SpeedViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class DDR5SpeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var buildVCRef: BuildViewController?
    
    let identifiers = ["5600", "6000", "6400"]
    
    var speeds: [RAMSpeed] = [.mhz5600, .mhz6000, .mhz6400]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let RAMAmountVCRef = segue.destination as? RAMAmountViewController
        
        if let RAMAmountVCRef{
            RAMAmountVCRef.buildVCRef = buildVCRef
            
            switch segue.identifier{
            case "SegueFrom5600":
                RAMAmountVCRef.speed = .mhz5600
            case "SegueFrom6000":
                RAMAmountVCRef.speed = .mhz6000
            case "SegueFrom6400":
                RAMAmountVCRef.speed = .mhz6400
            default:
                fatalError("problem with segue identifier in ddr4vc")
            }
        }
    }
    
}
