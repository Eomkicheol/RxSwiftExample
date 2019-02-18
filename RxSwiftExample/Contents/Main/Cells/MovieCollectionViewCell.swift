//
//  MovieCollectionViewCell.swift
//  RxSwiftExample
//
//  Created by 엄기철 on 18/02/2019.
//  Copyright © 2019 Hanzo. All rights reserved.
//

import UIKit
import Kingfisher

 class MovieCollectionViewCell: BaseCollectionViewCell {
	
	// MARK: Constants
	private enum Constants {
		static let labelFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
		static let subLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 12)
		static let titleLabelColor: UIColor = UIColor.blue
		static let labelAlignment: NSTextAlignment = NSTextAlignment.left
		static let labelColor: UIColor = UIColor.darkGray
	}
	
	let movieImageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleToFill
		view.clipsToBounds = true
		return view
	}()
	
	let titleLabel: UILabel = {
		let view  = UILabel()
		view.textColor = Constants.titleLabelColor
		view.textAlignment = Constants.labelAlignment
		view.font = Constants.labelFont
		return view
	}()
	
	let subtitleLabel: UILabel = {
		let view = UILabel()
		view.textColor = Constants.labelColor
		view.textAlignment = Constants.labelAlignment
		view.font = Constants.subLabelFont
		return view
	}()
	
	let actorLabel: UILabel = {
		let view = UILabel()
		view.textColor = Constants.labelColor
		view.textAlignment = Constants.labelAlignment
		view.numberOfLines = 0
		view.font = Constants.subLabelFont
		return view
	}()
	
	let directorLabel: UILabel = {
		let view = UILabel()
		view.textColor = Constants.labelColor
		view.textAlignment = Constants.labelAlignment
		view.font = Constants.subLabelFont
		return view
	}()
	
	
	let userRatingLabel: UILabel = {
		let view = UILabel()
		view.textColor = Constants.labelColor
		view.textAlignment = Constants.labelAlignment
		view.font = Constants.subLabelFont
		return view
	}()
	
	override func configureUI() {
		
		self.contentView.backgroundColor = .white
		
		
		[movieImageView, titleLabel, subtitleLabel,
		 actorLabel, directorLabel, userRatingLabel].forEach {
			self.contentView.addSubview($0)
		}
		
		movieImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		movieImageView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		
		self.movieImageView.snp.makeConstraints {
			$0.top.equalToSuperview().offset(15)
			$0.left.equalToSuperview().offset(5)
			$0.height.equalTo(155)
		}
		
		self.titleLabel.snp.makeConstraints {
			$0.top.equalTo(movieImageView)
			$0.left.equalTo(movieImageView.snp.right).offset(5)
			$0.right.equalToSuperview().offset(-15)
		}
		
		self.subtitleLabel.snp.makeConstraints {
			$0.top.equalTo(titleLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}
		
		self.actorLabel.snp.makeConstraints {
			$0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}
		
		self.directorLabel.snp.makeConstraints {
			$0.top.equalTo(actorLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
		}
		
		self.userRatingLabel.snp.makeConstraints {
			$0.top.equalTo(directorLabel.snp.bottom).offset(5)
			$0.left.equalTo(titleLabel)
			$0.right.equalToSuperview().offset(-5)
		}
	}
	
	func setEntity(value: ItemModel) {
		
		print(value)
		
		if let url = URL(string: value.image) {
			self.movieImageView.kf.setImage(with: url)
		}
		
		self.titleLabel.text = value.title.removeHTMLTag
		self.subtitleLabel.text = "( \(value.subtitle))"
		self.actorLabel.text = "출연: \(value.actor.replacingComma.dropLast())"
		self.directorLabel.text = "감독: \(value.director.dropLast())"
		self.userRatingLabel.text = "평점: \(value.userRating)"
		
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
	
	static func cellHeight(width: CGFloat) -> CGSize {
		let height: CGFloat = 120 + Constants.labelFont.lineHeight + 25 +  Constants.subLabelFont.lineHeight

		return  CGSize(width: width, height: height)
	}
}
