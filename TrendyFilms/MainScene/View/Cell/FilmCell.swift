//
//  FilmCell.swift
//  TrendyFilms
//
//  Created by Óscar on 2/7/22.
//

import UIKit

class FilmCell: UITableViewCell {

  @IBOutlet weak var filmTitle: UILabel!
  @IBOutlet weak var filmRating: UILabel!
  @IBOutlet weak var filmOverview: UILabel!
  @IBOutlet weak var filmImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
