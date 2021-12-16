//
//  BlogTableViewCell.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 10-12-21.
//

import UIKit

class BlogTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blogAvatar: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    
    let baseURLImg = "https://bv-content.beenverified.com/"
    let newFormatURL = "fit-in/60x0/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Methods
    
    func configCell(with data: Articles.Article) {
        guard let imgUrl = configURL(data.image), let url = URL(string: imgUrl) else { return }
        blogAvatar.load(url: url)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        authorLabel.text = data.author
        dateLabel.text = data.article_date?.convertToDisplayFormat()
        
    }
    
    
    /// This method configures the new url to optimize size
    /// - Parameter url: Image url
    /// - Returns: The new url
    func configURL(_ url: String?) -> String? {
        guard var url = url else { return nil }
        
        let indexImg = url.index(url.startIndex, offsetBy: baseURLImg.count)
        url.insert(contentsOf: newFormatURL, at: indexImg)
        
        return url
    }
    
    override func prepareForReuse() {
        blogAvatar.image = nil
    }
    
    
}
