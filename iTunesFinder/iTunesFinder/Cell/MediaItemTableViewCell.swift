//
//  MediaItemTableViewCell.swift
//  iTunesFinder
//
//  Created by Aliaksei Gorodji on 30.05.22.
//

import UIKit
import SnapKit

final class MediaItemTableViewCell: UITableViewCell {
        
    private let image: CustomImageView = {
       let imageView = CustomImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 10)
        label.textColor = .black

        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func set(model: Item, imageCashe: NSCache<NSString, UIImage>) {
        titleLabel.text = model.trackName
        image.loadImageUsing(urlString: model.artworkUrl100, with: imageCashe)
        if let description = model.description {
            let data = Data(description.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                descLabel.attributedText = attributedString
            }
        }
    }

}

private extension MediaItemTableViewCell {
    
    func configure() {
        addSubviews()
        setupConstraints()

    }
    
    func addSubviews() {
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        self.contentView.addSubview(image)
        self.contentView.addSubview(containerView)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(80)
            $0.width.equalTo(70)
        }
        
        containerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(85)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.height.greaterThanOrEqualTo(90)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.equalToSuperview().inset(8)
        }
        
        descLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(6)
        }
        
    }
    
    
}
