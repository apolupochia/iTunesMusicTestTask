//
//  SongCell.swift
//  iTunesMusic
//
//  Created by Алёша Виноградов on 26.05.2023.
//

import UIKit

class SongCell: UITableViewCell {


    @IBOutlet var imageOnCell: UIImageView!
    @IBOutlet var songName: UILabel!
    @IBOutlet var authorName: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func update(cell : SongCell, viewModel : CellIdentifiable) -> SongCell {
        
        
        guard let cellViewModel = viewModel as? SongCellViewModel else { return cell }
        cell.songName.text = cellViewModel.songName
        cell.authorName.text = cellViewModel.authorName
        
            NetworkDataFetch.shared.fetchImg(urlImage: cellViewModel.imageStringURL) { image in
                guard let img = image else {
                    cell.imageOnCell.image = downloadProblem
                    return
                }
                cell.imageOnCell.image = img
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }

        
        return cell
    }


    
}
