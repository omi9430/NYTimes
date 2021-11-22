//
//  TopNewsTableViewCell.swift
//  Newyorktimes
//
//  Created by omair khan on 21/11/2021.
//

import UIKit
import SDWebImage
class TopNewsTableViewCell: UITableViewCell {
    

    
    
    /// Formatter to Covert `Date` to required format
    let dateFormatter : DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    
    var cellData : Results? {
        didSet{
            
            if let title = cellData?.title{
                titleLabel.text = title
                bookMarkBtn.title = title
            }else{
                titleLabel.text = "HEllo"
            }
            if let abstract = cellData?.abstract{
                abbstractLabel.text = abstract
            }else{
                abbstractLabel.text = ""
            }
            if let publishedDatetxt = cellData?.published_date{
                
                //Converting date to string
                let date = dateFormatter.string(from: publishedDatetxt)
                publishedDateLabel.text = date
                
            }else{
                titleLabel.text = ""
            }
            if let image = cellData?.multimedia[0].url{
                bookMarkBtn.imageURL = image
            //    imageView?.sd_setImage(with: URL(string: image), completed: nil)
           myImageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "NY"), options: .continueInBackground, context: nil)
            }
            if let urlToStory = cellData?.url {
                bookMarkBtn.url = urlToStory
            }
            
        }
    }
    
    
    
    /*
     - UIView For Labels
     - UIView For Image
     - ImageView
     - Title Label
     - Abstract Label
     - Published Date Label
     - Bookmark UIbbutton
     */
    
    
    let viewForLabels : UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        return view
    }()
    
    let viewForImage : UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .clear
        return view
    }()
    
     let myImageView : UIImageView = {
        var myImageView = UIImageView()
        myImageView.contentMode = .scaleToFill
        myImageView.clipsToBounds = true
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.layer.cornerRadius = 8
        return myImageView
    }()
    
     let titleLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .left
        myLabel.font =  .systemFont(ofSize: 13, weight: .bold)
        myLabel.numberOfLines = 2
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
     let abbstractLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .left
        myLabel.numberOfLines = 0
        myLabel.font =  .systemFont(ofSize: 13, weight: .regular)
        myLabel.textColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
     let publishedDateLabel : UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.font =  .systemFont(ofSize: 10, weight: .medium)
        myLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        myLabel.numberOfLines = 1
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLabel
    }()
    
    let bookMarkBtn  : BookMarkButton = {
        let btn = BookMarkButton()
        btn.backgroundColor = .black
        btn.setTitle("BookMark", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10, weight: .heavy)
        btn.titleLabel?.textColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        setUpView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    func setUpView(){
        
        /*
         - Add SubViews
         - Add Constraints
         */
        
    
        
        self.contentView.addSubview(viewForImage)
        self.contentView.addSubview(viewForLabels)
//        self.contentView.addSubview(titleLabel)
//        self.contentView.addSubview(abbstractLabel)
//        self.contentView.addSubview(publishedDateLabel)
//        self.contentView.addSubview(bookMarkBtn)
        
        self.viewForImage.addSubview(myImageView)
        self.viewForImage.sendSubviewToBack(myImageView)
        
        
        self.viewForLabels.addSubview(titleLabel)
        self.viewForLabels.addSubview(abbstractLabel)
        self.viewForLabels.addSubview(publishedDateLabel)
        self.viewForLabels.addSubview(bookMarkBtn)
        
       // viewForLabels.bringSubviewToFront(titleLabel)
        
        let constraints = [
            
            // View for labels
            viewForLabels.leadingAnchor.constraint(equalTo: self.viewForImage.trailingAnchor, constant: 1),
            viewForLabels.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            viewForLabels.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            viewForLabels.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -2),
            
            // View for image
            
            viewForImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            viewForImage.trailingAnchor.constraint(equalTo: self.viewForLabels.leadingAnchor, constant: 1),
            viewForImage.widthAnchor.constraint(equalToConstant: self.contentView.frame.size.width/3),
            viewForImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2),
            viewForImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -2),
          
            
            // title label
            titleLabel.leadingAnchor.constraint(equalTo: self.viewForLabels.leadingAnchor, constant: 1),
            titleLabel.trailingAnchor.constraint(equalTo: self.viewForLabels.trailingAnchor, constant: 2),
            titleLabel.topAnchor.constraint(equalTo: self.viewForLabels.topAnchor, constant: 2),
            titleLabel.heightAnchor.constraint(equalToConstant: self.contentView.frame.height/3),
            

            
            // abstract label
            abbstractLabel.leadingAnchor.constraint(equalTo: self.viewForLabels.leadingAnchor, constant: 1),
            abbstractLabel.trailingAnchor.constraint(equalTo: self.viewForLabels.trailingAnchor, constant: 2),
            abbstractLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            abbstractLabel.bottomAnchor.constraint(equalTo: self.bookMarkBtn.topAnchor, constant: -4),
            

          
            // published date label
            publishedDateLabel.trailingAnchor.constraint(equalTo: self.viewForLabels.trailingAnchor, constant: 2),
            publishedDateLabel.bottomAnchor.constraint(equalTo: self.viewForLabels.bottomAnchor, constant: 2),
            publishedDateLabel.heightAnchor.constraint(equalToConstant: self.contentView.frame.width/6),
            publishedDateLabel.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/4),

            
            // Bookmark button
            bookMarkBtn.leadingAnchor.constraint(equalTo: self.viewForLabels.leadingAnchor, constant: 2),
            bookMarkBtn.bottomAnchor.constraint(equalTo: self.viewForLabels.bottomAnchor, constant: -10),
            bookMarkBtn.heightAnchor.constraint(equalToConstant: self.contentView.frame.width/12),
            bookMarkBtn.widthAnchor.constraint(equalToConstant: self.contentView.frame.width/4),

            
            
            //ImageView Constraints
            myImageView.leadingAnchor.constraint(equalTo: self.viewForImage.leadingAnchor, constant: 1),
            myImageView.trailingAnchor.constraint(equalTo: self.viewForImage.trailingAnchor, constant: 1),
            myImageView.topAnchor.constraint(equalTo: self.viewForImage.topAnchor, constant: 1),
            myImageView.bottomAnchor.constraint(equalTo: self.viewForImage.bottomAnchor, constant: 1)
            
        ]
        print(myImageView.frame)
        
        NSLayoutConstraint.activate(constraints)
    }

}
