//
//  PlaceDetailsViewController.swift
//  Application
//
//  Created by 胡洞明 on 2021-11-24.
//

import UIKit
import Domain

class PlaceDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailsTextView: UITextView!
    
    private let place: Place
    
    // MARK: - Init
    
    init?(place: Place, coder: NSCoder) {
        self.place = place
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = 20
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.kf.setImage(with: place.imageUrl)  // can load high resolution image if there's one
        
        nameLabel.text = place.name
        typeLabel.text = place.type.rawValue
        addressLabel.text = place.address
        
    }
    


}
