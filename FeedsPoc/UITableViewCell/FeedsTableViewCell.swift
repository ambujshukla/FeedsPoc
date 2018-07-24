//
//  FeedsTableViewCell.swift
//  FeedsPoc
//
//  Created by Ambuj Shukla on 24/07/18.
//  Copyright © 2018 Ambuj Shukla. All rights reserved.
//

import UIKit
import SDWebImage

class FeedsTableViewCell: UITableViewCell {
    
    //Cell View Object
    private let imageFeed = UIImageView()
    private let lblTitle = UILabel()
    private let lblDescription = UILabel()
    
    //Constant
    private let paddingWithContent:CGFloat = 20.0
    private let gapBetweenObject:CGFloat = 10.0
    private let heightWidthImage:CGFloat = 40.0
    private let heightTitle:CGFloat = 25.0
    
    //MARK: Private Method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    //Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //cell object property
        imageFeed.contentMode = .scaleAspectFit
        imageFeed.clipsToBounds = true
        lblDescription.numberOfLines = 0
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.minimumScaleFactor = 0.7
        
        //translatesAutoresizingMas
        imageFeed.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        
        //add to cell
        contentView.addSubview(imageFeed)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDescription)
        
        //add constraint
        NSLayoutConstraint.activate([
            //img
            imageFeed.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingWithContent),
            imageFeed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingWithContent),
            imageFeed.widthAnchor.constraint(equalToConstant: heightWidthImage),
            imageFeed.heightAnchor.constraint(equalToConstant: heightWidthImage),
            
            //title lable
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: paddingWithContent),
            lblTitle.leadingAnchor.constraint(equalTo: imageFeed.leadingAnchor, constant: heightWidthImage + gapBetweenObject),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingWithContent),
            lblTitle.heightAnchor.constraint(equalToConstant: heightTitle),
            
            //description label
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: gapBetweenObject),
            lblDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -paddingWithContent),
            lblDescription.leadingAnchor.constraint(equalTo: imageFeed.leadingAnchor, constant: heightWidthImage + gapBetweenObject),
            lblDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingWithContent),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func styleUI(rowModel: RowsDataModel) {
        self.lblTitle.text = rowModel.title
        self.lblDescription.text = rowModel.description
        guard let imgUrl = rowModel.imageHref else {
            self.imageFeed.image = #imageLiteral(resourceName: "placeholder")
            return
        }
        self.imageFeed.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
}
