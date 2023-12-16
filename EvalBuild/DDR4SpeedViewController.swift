//
//  DDR4SpeedViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class DDR4SpeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var buildVCRef: BuildViewController?
    
    let identifiers = ["3200", "3600", "4400"]
    
    var speeds: [RAMSpeed] = [.mhz3200, .mhz3600, .mhz4400]
    
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
            case "SegueFrom3200":
                RAMAmountVCRef.speed = .mhz3200
            case "SegueFrom3600":
                RAMAmountVCRef.speed = .mhz3600
            case "SegueFrom4400":
                RAMAmountVCRef.speed = .mhz4400
            default:
                fatalError("problem with segue identifier in ddr4vc")
            }
        }
    }
    
}
