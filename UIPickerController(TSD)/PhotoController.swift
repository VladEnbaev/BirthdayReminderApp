//
//  PhotoController.swift
//  UIPickerController(TSD)
//
//  Created by Влад Енбаев on 13.12.2022.
//

import UIKit

class PhotoController: UIViewController {

    @IBOutlet weak var photoCollection: UICollectionView!
    
    let insetForCells : CGFloat = 20
    var widthForCell : CGFloat = 100
    
    let catsArray = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7" ,"cat8", "cat9", "cat10", "cat11", "cat12", "cat13", "cat14"]
    var imageName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //collectionView
        photoCollection.delegate = self
        photoCollection.dataSource = self
        //title
        self.title = "Choose Photo"
    }
}

extension PhotoController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = photoCollection.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let catImage = UIImage(named: catsArray[indexPath.item])
        let widthConstraint = NSLayoutConstraint(item: cell.photoImageView!,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: widthForCell)
        let heightConstraint = NSLayoutConstraint(item: cell.photoImageView!,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute:NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: widthForCell)
        cell.addConstraints([widthConstraint, heightConstraint])
        cell.photoImageView.image = catImage
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.clipsToBounds = true
        return cell
    }
    
    //MARK: -Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "photoSegue" else { return }
        let selectedIndexPath = photoCollection.indexPathsForSelectedItems!
        self.imageName = catsArray[selectedIndexPath[0].item]
    }
}

extension PhotoController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerPow : CGFloat = 2
        let paddingWidth : CGFloat = insetForCells * (itemPerPow + 1)
        let availableWidth = self.view.frame.width - paddingWidth
        widthForCell = availableWidth / itemPerPow
        return CGSize(width: widthForCell, height: widthForCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetForCells, left: insetForCells, bottom: insetForCells, right: insetForCells)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insetForCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insetForCells
    }
}
