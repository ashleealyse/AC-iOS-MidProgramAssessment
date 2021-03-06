//
//  DetailedElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Ashlee Krammer on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedElementViewController: UIViewController {
    
    
    //Outlets
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var elementWeightLabel: UILabel!
    @IBOutlet weak var atomicNumber: UILabel!
    @IBOutlet weak var detailedScroll: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //Actions
    
    @IBAction func postToFavorites(_ sender: UIButton) {
        let elementPost = ElementPost(name: "Ashlee", favorite_element: element.symbol)
        ElementAPIClient.manager.post(elementPost: elementPost, completionHandler: {print($0)}, errorHandler: {print($0)})
    }
    
    
    //Variables
    var element: Element!

    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setAllLabels()
        
        
    }
    func setAllLabels() {
        elementSymbolLabel.text = element.symbol
        elementNameLabel.text = element.name
        elementWeightLabel.text = element.weight.description
        atomicNumber.text = element.number.description
        var boilingPoint = "N/A"
        var meltingPoint = "N/A"
        var detailedText = ""
        
        if element.boiling_c != nil {
            boilingPoint = element.boiling_c!.description
        }
        if element.melting_c != nil {
            meltingPoint = element.melting_c!.description
        }
        
        detailedText =
        """
        Melting Point: \(meltingPoint)
        
        Boiling Point: \(boilingPoint)
        """
        detailedScroll.text = detailedText
        
        
        elementImage.image = #imageLiteral(resourceName: "images")
        
        
        
        let imageUrlStr = "http://images-of-elements.com/\(element.name.lowercased()).jpg"
        
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            
            self.elementImage.image = onlineImage
            
            self.activityIndicator.stopAnimating()
        }
        let imageError: (Error) -> Void = {(error: Error) in
            self.activityIndicator.stopAnimating()
            print(error)
        }
        activityIndicator.startAnimating()
        ImageAPIClient.manager.getImage(from: imageUrlStr, completionHandler: completion, errorHandler: imageError)
        
        
        
    }
    
}



