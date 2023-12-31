//
//  BuildControllerViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/12/23.
//

import UIKit

class BuildViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var partsTable: UITableView!
    
    let cellIdentifiers = ["GPU", "CPU", "RAM", "Motherboard", "Storage", "Cooler", "Case", "PSU"]
    
    var parts: [PCPart?] = [nil, nil, nil, nil, nil, nil, nil, nil]
    
    @IBOutlet weak var pleaseFinishLabel: UILabel!
    
    @IBOutlet weak var titleRef: UILabel!
    var backgroundOpacity: CGFloat = CGFloat(1.0)
    var backgroundColor: UIColor = UIColor.yellow
    var titleColor: UIColor = UIColor.white
    var partNameColor: UIColor = UIColor.white
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        partsTable.dataSource = self
        partsTable.delegate = self
        
        partsTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Add the swipe gesture recognizer
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeGesture.direction = .left
        view.addGestureRecognizer(swipeGesture)

        pleaseFinishLabel.text = "Swipe Left For Evaluation"
        pleaseFinishLabel.textColor = UIColor.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.alpha = backgroundOpacity
        view.backgroundColor = backgroundColor
        titleRef.textColor = titleColor
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return parts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(parts.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = partsTable.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        
        // Remove existing labels before adding a new one
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center // Set the text alignment to center
        label.textColor = partNameColor

        if let part = parts[indexPath.row]{
            label.text = part.name
        }else{
            label.text = "Press to Select \(cellIdentifiers[indexPath.row])"
        }
        
        cell.contentView.addSubview(label)
        
        // Center the label using Auto Layout constraints
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
        ])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pleaseFinishLabel.textColor = UIColor.black
        pleaseFinishLabel.text = "Swipe Left For Evaluation"
        
        if(segue.identifier == "SequeToGPUManufacturer"){
            let GPUManufacturerVCRef = segue.destination as! GPUManufacturerViewController
            GPUManufacturerVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToCPUManufacturer"){
            let CPUManufacturerVCRef = segue.destination as! CPUManufacturerViewController
            CPUManufacturerVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToRAMGen"){
            let RAMGenVCRef = segue.destination as! RAMGenViewController
            RAMGenVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToMotherboard"){
            let MoboGroupVCRef = segue.destination as! MotherboardGroupViewController
            MoboGroupVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToStorage"){
            let StorageTypeVCRef = segue.destination as! StorageTypeViewController
            StorageTypeVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToCooler"){
            let CoolerVCRef = segue.destination as! CoolerViewController
            CoolerVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToCase"){
            let CaseVCRef = segue.destination as! CaseViewController
            CaseVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToPSU"){
            let PSUVCRef = segue.destination as! PSUViewController
            PSUVCRef.buildVCRef = self
        }
        else if(segue.identifier == "SegueToCompat"){
            let CompatVCRef = segue.destination as! CompatabilityViewController
            CompatVCRef.parts = self.parts
        }
        else if(segue.identifier == "SegueToConfig"){
            let ConfigVCRef = segue.destination as! ConfigViewController
            ConfigVCRef.buildVCRef = self
        }
    }
    
    @IBAction func configButtonPressed(_ sender: Any) {
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        // Check if all members of the array are not nil
        let allPartsSelected = parts.allSatisfy { $0 != nil }

        if allPartsSelected {
            performSegue(withIdentifier: "SegueToCompat", sender: self)
        } else {
            // Display a message to the user
            pleaseFinishLabel.text = "Please Finish Selecting Your Parts"
            pleaseFinishLabel.textColor = UIColor.red
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
