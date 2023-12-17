//
//  ConfigViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class ConfigViewController: UIViewController {

    var buildVCRef: BuildViewController?
    
    @IBOutlet weak var titleCW: UIColorWell!
    
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var partCW: UIColorWell!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //buildVCRef?.backgroundColor = backgroundCW.selectedColor ?? UIColor.yellow
        buildVCRef?.partNameColor = partCW.selectedColor ?? UIColor.white
        buildVCRef?.titleColor = titleCW.selectedColor ?? UIColor.white
    }
    
    @IBAction func sliderValChanged(_ sender: UISlider) {
        buildVCRef?.backgroundOpacity = CGFloat(sender.value)
    }
    
    
    
}
