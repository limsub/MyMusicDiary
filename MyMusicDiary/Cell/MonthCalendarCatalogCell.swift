//
//  MonthCalendarCatalogCell.swift
//  MyMusicDiary
//
//  Created by 임승섭 on 2023/10/04.
//

import UIKit
import Kingfisher

class MonthCalendarCatalogCell: BaseCollectionViewCell {
    
    
    var artworkImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        view.text = String(localized: "제목")
        view.numberOfLines = 1
        return view
    }()
    
    var artistLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.text = String(localized: "가수")
        view.textColor = .lightGray
        view.numberOfLines = 1
        return view
    }()
    
    override func setConfigure() {
        super.setConfigure()
        
        contentView.addSubview(artworkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
    }
    override func setConstraints() {
        super.setConstraints()
        
//        contentView.layer.borderColor = UIColor.black.cgColor
//        contentView.layer.borderWidth = 1
        
        
        artworkImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(artworkImageView.snp.width)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(artworkImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
        }
        artistLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
        }
    }
    
    func designCell(_ sender: MusicItemTable) {
        
        if let str = sender.bigImageURL, let url = URL(string: str) {
            // * 다운샘플링 필요
            artworkImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = sender.name
        artistLabel.text = sender.artist
        
    }
}
