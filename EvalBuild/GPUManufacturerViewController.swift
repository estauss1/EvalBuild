//
//  GPUManufacturerViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/13/23.
//

import UIKit

class GPUManufacturerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var buildVCRef: BuildViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = (indexPath.row == 0) ? "AMD" : "Nvidia"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SegueToAMDGPUs"){
            let AMDGPUVCRef = segue.destination as! AMDGPUViewController
            AMDGPUVCRef.buildVCRef = buildVCRef
        }
        else if(segue.identifier == "SegueToNvidiaGPUs"){
            let NvidiaGPUVCRef = segue.destination as! NvidiaGPUViewController
            NvidiaGPUVCRef.buildVCRef = buildVCRef
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10  // Adjust the spacing as needed
    }

}
