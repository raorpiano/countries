//
//  CountryDetail.swift
//  Countries
//
//  Created by Roy Orpiano on 11/8/21.
//

import UIKit

class CountryDetail: UIViewController {
    
    @IBOutlet var countryName: UILabel!
    @IBOutlet var flag: UIImageView!
    @IBOutlet var details: UILabel!
    
    var name: String!
    var imageURLString: String!
    var capital: String!
    var currency: String!
    var languages: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryName.text = name
        DispatchQueue.global().async { [self] in
            do {
                let url: URL = URL(string: imageURLString)!
                let data: Data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.flag.image = UIImage(data: data)
//                        activityIndicatorView.isHidden = true
                }
                
            } catch {
                return
            }
        }
        setupDetails()
    }
    
    func setupDetails() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 17.0)
        ]
        var detailAttributedText = NSMutableAttributedString(string: "Capital: ", attributes: attributes)
        detailAttributedText.append(NSAttributedString(string: self.capital))
        
        detailAttributedText.append(NSAttributedString(string: "\nCurrency: ", attributes: attributes))
        detailAttributedText.append(NSAttributedString(string: self.currency))
        
        detailAttributedText.append(NSAttributedString(string: "\nLanguages: ", attributes: attributes))
        detailAttributedText.append(NSAttributedString(string: self.languages))
        
        self.details.attributedText = detailAttributedText
    }
    

}
