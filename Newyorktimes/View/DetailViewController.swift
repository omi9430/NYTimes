//
//  DetailViewController.swift
//  Newyorktimes
//
//  Created by omair khan on 22/11/2021.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
  
    
    var image : UIImage?
    var caption : String?
    
   
    
   
    
    let viewForImage : UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        return view
    }()
    
    let myImageView : UIImageView = {
       var myImageView = UIImageView()
       myImageView.contentMode = .scaleToFill
       myImageView.clipsToBounds = true
       myImageView.layer.cornerRadius = 8
       myImageView.translatesAutoresizingMaskIntoConstraints = false
       return myImageView
   }()
    
    let titleLabel : UILabel = {
       let myLabel = UILabel()
       myLabel.textAlignment = .center
        myLabel.font =  .systemFont(ofSize: 10, weight: .semibold)
       myLabel.numberOfLines = 0
       myLabel.translatesAutoresizingMaskIntoConstraints = false
       return myLabel
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    
    func setUpView(){
        /*
         - Add SubViews
         - Add Constraints
         */
        
        self.view.addSubview(viewForImage)
        self.view.addSubview(titleLabel)
        
        self.viewForImage.addSubview(myImageView)
        viewForImage.bringSubviewToFront(myImageView)
        
        
        let constraints = [
        // View For image
            
            viewForImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            viewForImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            viewForImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            viewForImage.heightAnchor.constraint(equalToConstant: self.view.frame.height/1.5),
            // title label
            
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: self.viewForImage.bottomAnchor, constant: 1),
            titleLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 1),
            
            //ImageView
            
            myImageView.leadingAnchor.constraint(equalTo: self.viewForImage.leadingAnchor, constant: 1),
            myImageView.trailingAnchor.constraint(equalTo: self.viewForImage.trailingAnchor, constant: 1),
            myImageView.topAnchor.constraint(equalTo: self.viewForImage.topAnchor, constant: 1),
            myImageView.bottomAnchor.constraint(equalTo: self.viewForImage.bottomAnchor, constant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
        self.myImageView.frame = viewForImage.bounds
        
        myImageView.image = image
        titleLabel.text = caption
    }
}
