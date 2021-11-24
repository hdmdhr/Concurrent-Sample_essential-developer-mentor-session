//
//  PlaceCell.swift
//  Application
//
//  Created by 胡洞明 on 2021-11-22.
//

import UIKit
import Domain
import Kingfisher

class PlaceCell: UITableViewCell {

    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func configure(with place: Places.Place) {
        placeImageView.kf.setImage(with: place.imageUrl, placeholder: UIImage(systemName: "applelogo"))
        
        nameLabel.text = place.name
        
        typeLabel.text = place.type.rawValue
        
        addressLabel.text = place.address
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeImageView.layer.cornerRadius = 12
    }


}
