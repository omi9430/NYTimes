//
//  BookMarksViewController.swift
//  Newyorktimes
//
//  Created by omair khan on 22/11/2021.
//

import Foundation
import UIKit
import SafariServices

class BookMarksViewController : UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
   
    
    
    let cellId = "cell"
    
    var dataArray = [Bookmarks]()
    
    private var collectionView : UICollectionView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up collectionview
        title = "BookMarks"
        setUpCollectionView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Loads the data everytime you switch to this controller
        dataArray = DatabaseManager.shared.getBookMarks()
        self.collectionView?.reloadData()
        
    }
    
    
    
    
    //Setup Collectionview
    func setUpCollectionView(){
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewlayout())
        collectionView?.register(BookMarkCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        
        self.view.addSubview(collectionView!)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        self.collectionView!.topAnchor.constraint(equalTo: self.view.topAnchor, constant: (self.navigationController?.navigationBar.frame.height)!).isActive = true
        self.collectionView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.collectionView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.collectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: (self.tabBarController?.tabBar.frame.height)!).isActive = true
        
    }
    
    //MARK: CollectionView LayOut
    
    func collectionViewlayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 2)
        // 4 items per row
        let size =  (self.view.frame.width - 4)/4
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        return layout
    }
    
    
    
    //MARK: CollectionView DataSoruce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BookMarkCell
        cell.cellData = dataArray[indexPath.row]
        //cell.titleLabel.text = dataArray[indexPath.row].title

        return cell
    }
    
    //MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        // Present browser
        let browser = SFSafariViewController(url: URL(string: dataArray[indexPath.row].link!)!)
        self.present(browser, animated: true, completion: nil)
    }
    
 
    //MARK: Adding 3d touch to collectionView
    func collectionView(_ collectionView: UICollectionView,contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
       
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
            return self.makeContextMenu(indexPath: indexPath)
        }
    }
    
    func makeContextMenu(indexPath : IndexPath) -> UIMenu {

      

        // Here we specify the "destructive" attribute to show that it’s destructive in nature
        let delete = UIAction(title: "Delete BookMark", image: UIImage(systemName: "trash"), attributes: .destructive) { [self] action in
            // Delete this data from array
            self.collectionView?.deleteItems(at: [indexPath])
            self.dataArray = DatabaseManager.shared.deleteData(indexPath: indexPath.row)
        }

        // Create our menu 
        return UIMenu(title: "Main Menu", children: [delete])
    }
}




