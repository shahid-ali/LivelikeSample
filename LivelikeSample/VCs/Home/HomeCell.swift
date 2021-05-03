//
//  HomeCell.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//

import UIKit

class HomeCell: UITableViewCell {

 var imageGIF = UIImageView()
 var giffyItem:GiffyItem?
	{
		didSet
		{
			if let urlStr=giffyItem?.images?.original?.url
			{
				self.imageGIF.loadImage(urlSting:urlStr)
			}
		}
	}
 
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style:style, reuseIdentifier:reuseIdentifier)
		
		imageGIF.translatesAutoresizingMaskIntoConstraints = false
		imageGIF.contentMode = .scaleAspectFit
		contentView.addSubview(imageGIF)
		addSubViewsAndlayout()
	}
	
	
	//Add and sets up subviews with programmically added constraints
	private func addSubViewsAndlayout() {
		imageGIF.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
		imageGIF.heightAnchor.constraint(equalToConstant: 100).isActive = true
		imageGIF.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12).isActive = true
		imageGIF.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12).isActive = true
		
		imageGIF.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12).isActive = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageGIF.image=nil
	}

}
