//
//  BookViewController.swift
//  TrendMediaProject
//
//  Created by mac on 2021/10/20.
//

import UIKit
import Kingfisher
import Toast


class BookViewController: UIViewController {
    
    static let identifier = "BookViewController"
    
    var Toaststyle = ToastStyle()

    @IBOutlet weak var BookCollectionView: UICollectionView!
    
    var bookInfo = TvShowInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookCollectionView.delegate = self
        BookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        BookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
       
        //flow 레이아웃
        let layout = UICollectionViewFlowLayout()
        let spacing :CGFloat = 16 //Int연산 불가 type적용해야함.
        let width = UIScreen.main.bounds.width - (spacing * 1.5)
        
        //셀의 너비와 높이(CGsize(구조체))
        layout.itemSize = CGSize(width: width / 2.7, height: (width/2))
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        
        
        BookCollectionView.collectionViewLayout = layout
        BookCollectionView.backgroundColor = .white
        
        
    }
    

   

}

func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }



extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
                return UICollectionViewCell() }
            
        let row = bookInfo.tvShow[indexPath.row]
        cell.bookCollectionTitleLabel.text = row.title
        cell.bookCollectionTitleLabel.textColor = .white
        
        
        cell.bookCollectionRateLabel.text = "\(row.rate)"
        cell.bookCollectionRateLabel.textColor = .white
        
        
        let url = URL(string: row.backdropImage)
        cell.bookCollectionImageView.kf.setImage(with: url)
        
        cell.backgroundColor = getRandomColor()
        cell.layer.cornerRadius = 8
        
        
        
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.view.makeToast("number \(indexPath.item) Toast", duration: 2.0, position: .bottom, style:.init())
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return bookInfo.tvShow.count
           
    
 
    
}
}
