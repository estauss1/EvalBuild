//
//  RAMGenViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/15/23.
//

import UIKit

class RAMGenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
        var buildVCRef: BuildViewController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 2 }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let identifier = (indexPath.row == 0) ? "DDR4" : "DDR5"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
            return cell
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "SegueToDDR4"){
                let DDR4VCRef = segue.destination as! DDR4SpeedViewController
                DDR4VCRef.buildVCRef = buildVCRef
            }
            else if(segue.identifier == "SegueToDDR5"){
                let DDR5VCRef = segue.destination as! DDR5SpeedViewController
                DDR5VCRef.buildVCRef = buildVCRef
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 150, height: 150)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10  // Adjust the spacing as needed
        }
}
