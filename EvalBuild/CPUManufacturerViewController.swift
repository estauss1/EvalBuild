//
//  CPUManufacturerViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class CPUManufacturerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var buildVCRef: BuildViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = (indexPath.row == 0) ? "AMD" : "Intel"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SegueToAMDCPU"){
            let AMDCPUVCRef = segue.destination as! AMDCPUViewController
            AMDCPUVCRef.buildVCRef = buildVCRef
        }
        else if(segue.identifier == "SegueToIntelCPU"){
            let IntelCPUVCRef = segue.destination as! IntelCPUViewController
            IntelCPUVCRef.buildVCRef = buildVCRef
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Adjust the spacing as needed
    }

}
