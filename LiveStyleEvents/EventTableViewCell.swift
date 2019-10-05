//
//  EventTableViewCell.swift
//  LiveStyleEvents
//
//  Created by Venkat Madira on 05/10/2019.
//  Copyright © 2019 Venkat Madira. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    var link:ViewController?
    
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventNameLbl: UILabel!
    
    @IBOutlet weak var eventDateLbl: UILabel!
    
    @IBOutlet weak var favouriteBtnPressed: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.eventImageView.layer.cornerRadius = self.eventImageView.frame.size.width/2
        self.eventImageView.clipsToBounds = true
        self.eventImageView.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    
    @IBAction func favouriteBtnPressed(_ sender: Any) {
        
        let id =  link?.getCellInformation(cell: self)
        //print(id)
        if let idVal = id{
            if(UserDefaults.standard.bool(forKey:idVal)){
               
                favouriteBtnPressed.setTitle("UnFavourite", for: .normal)
                UserDefaults.standard.set(false, forKey:idVal ) //Bool
                
                favouriteBtnPressed.tag = 1
                
            }else{
                favouriteBtnPressed.setTitle("Favourite", for: .normal)
                UserDefaults.standard.set(true, forKey:idVal ) //Bool
                
                favouriteBtnPressed.tag = 0
            }
        }
        
        
        
    }
    
}
