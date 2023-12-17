//
//  CompatabilityViewController.swift
//  EvalBuild
//
//  Created by Eric Stauss on 12/16/23.
//

import UIKit

class CompatabilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifiers = ["PSUCompat", "GPUCaseCompat", "MoboCPUCompat", "CaseMoboCompat", "CaseCoolerCompat", "CoolerCPUCompat", "RAMMoboCompat"]
    
    var parts: [PCPart?] = [nil, nil, nil, nil, nil, nil, nil, nil]
    var compats: [Compatibility] = [.Caution, .Caution, .Caution, .Caution, .Caution, .Caution, .Caution]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var noneAreNil = true
        
        for part in parts{
            if (part == nil){
                noneAreNil = false
            }
        }
        
        if(noneAreNil){
            if let part = parts[7]{
                let psu = part as! PSU
                compats[0] = psu.IsCompatible(with: parts)
            }
            if let part0 = parts[0], let part6 = parts[6]{
                let gpu = part0 as! GPU
                let aCase = part6 as! Case
                compats[1] = gpu.IsCompatible(with: aCase)
            }
            if let part3 = parts[3], let part1 = parts[1]{
                let motherboard = part3 as! Motherboard
                let cpu = part1 as! CPU
                compats[2] = motherboard.IsCompatible(with: cpu)
            }
            if let part6 = parts[6], let part3 = parts[3]{
                let aCase = part6 as! Case
                let motherboard = part3 as! Motherboard
                compats[3] = aCase.IsCompatible(with: motherboard)
            }
            if let part6 = parts[6], let part5 = parts[5]{
                let aCase = part6 as! Case
                let cooler = part5 as! Cooler
                compats[4] = aCase.IsCompatible(with: cooler)
            }
            if let part5 = parts[5], let part1 = parts[1]{
                let cooler = part5 as! Cooler
                let cpu = part1 as! CPU
                compats[5] = cooler.IsCompatible(with: cpu)
            }
            if let part2 = parts[2], let part3 = parts[3]{
                let ram = part2 as! RAM
                let motherboard = part3 as! Motherboard
                compats[6] = ram.IsCompatible(with: motherboard)
            }
        }
        else{
            print("there was a nil part inside compatvc")
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return compats.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height / CGFloat(parts.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
        
        // Remove existing labels before adding a new one
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center // Set the text alignment to center


        switch indexPath.row{
        case 0:
            if(compats[0] == .Compatible){
                label.text = "PSU is sufficient"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[0] == .Incompatible){
                label.text = "PSU is insufficient"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 1:
            if(compats[1] == .Compatible){
                label.text = "The GPU fits in the case"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[1] == .Caution){
                label.text = "The GPU may not fit in the case"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The GPU will not fit in the case"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 2:
            if(compats[2] == .Compatible){
                label.text = "The Motherboard and CPU are compatible"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[2] == .Caution){
                label.text = "The Motherboard and CPU may not be compatible"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The Motherboard and CPU are not compatible"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 3:
            if(compats[3] == .Compatible){
                label.text = "The Motherboard and Case are compatible"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[3] == .Caution){
                label.text = "The Motherboard and Case may not be compatible"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The Motherboard and Case are not compatible"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 4:
            if(compats[4] == .Compatible){
                label.text = "The Cooler and Case are compatible"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[4] == .Caution){
                label.text = "The Cooler and Case may not be compatible"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The Cooler and Case are not compatible"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 5:
            if(compats[5] == .Compatible){
                label.text = "The Cooler is sufficient to cool the CPU"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[5] == .Caution){
                label.text = "The Cooler may not cool the CPU well"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The Cooler is insufficient to cool the CPU"
                cell.contentView.backgroundColor = UIColor.red
            }
        case 6:
            if(compats[6] == .Compatible){
                label.text = "The selected RAM is supported by the Motherboard"
                cell.contentView.backgroundColor = UIColor.green
            }else if(compats[6] == .Caution){
                label.text = "The Motherboard may not support the selected RAM"
                cell.contentView.backgroundColor = UIColor.yellow
            }else{ //incompatible
                label.text = "The Motherboard does not support the selected RAM"
                cell.contentView.backgroundColor = UIColor.red
            }
        default:
            print("returned more cells than existed inside compatvc")
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
