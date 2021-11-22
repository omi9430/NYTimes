//
//  BookMarkCell.swift
//  Newyorktimes
//
//  Created by omair khan on 22/11/2021.
//

import Foundation
import UIKit
import SDWebImage

class BookMarkCell : UICollectionViewCell {
    
    /*
     - View for image
     - imageView
     - title label
     */
    
    var cellData : Bookmarks? {
        didSet{
            titleLabel.text = cellData?.title
            myImageView.sd_setImage(with: URL(string: (cellData?.imageURL!)!), placeholderImage: UIImage(named: "NY"), options:.continueInBackground, context: nil)
 
        }
    }
    
    let viewForImage : UIView = {
        var view = UIView()
        view.contentMode = .center
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
   
    
    
    // SetUp Views
    
    func setUpView(){
        /*
         - Add SubViews
         - Add Constraints
         */
        
        self.contentView.addSubview(viewForImage)
        self.contentView.addSubview(titleLabel)
        
        self.viewForImage.addSubview(myImageView)
        viewForImage.bringSubviewToFront(myImageView)
        
        
        let constraints = [
        // View For image
            
            viewForImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            viewForImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            viewForImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            viewForImage.heightAnchor.constraint(equalToConstant: self.contentView.frame.height/1.5),
            // title label
            
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: self.viewForImage.bottomAnchor, constant: 1),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 1),
            
            //ImageView
            
            myImageView.leadingAnchor.constraint(equalTo: self.viewForImage.leadingAnchor, constant: 1),
            myImageView.trailingAnchor.constraint(equalTo: self.viewForImage.trailingAnchor, constant: 1),
            myImageView.topAnchor.constraint(equalTo: self.viewForImage.topAnchor, constant: 1),
            myImageView.bottomAnchor.constraint(equalTo: self.viewForImage.bottomAnchor, constant: 1)
        ]
        
        NSLayoutConstraint.activate(constraints)
        self.myImageView.frame = viewForImage.bounds
    }
    
    
}
