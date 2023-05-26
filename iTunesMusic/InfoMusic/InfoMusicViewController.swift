//
//  MusicViewController.swift
//  iTunes
//
//  Created by Алёша Виноградов on 25.05.2023.
//

import UIKit

protocol InfoSongViewControllerInputProtocol : AnyObject{
    func fetchImage(image : UIImage, nameOfSong: String, nameOfAuthor : String)
    func changeImagestartSongButton(playNow : Bool)
}

protocol InfoSongViewControllerOutputProtocol : AnyObject{
    init(viewController : InfoSongViewControllerInputProtocol )
    func loadInfoAboutView()
    func tabStartOrPause()
}

class InfoSongViewController: UIViewController {
    
    var presenter : InfoSongViewControllerOutputProtocol!
    
    lazy var image : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.image = UIImage(systemName: "pencil.tip")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameOfTheSongLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Time"
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var nameOfTheAuthorLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Mr. Kitty"
        label.textAlignment = .center

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private lazy var startSongButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        let image = UIImage(systemName: "arrowtriangle.right.fill")
        image?.withTintColor(.red)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(tabStartOrPauseButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadInfoAboutView()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(image)
        view.addSubview(nameOfTheSongLabel)
        view.addSubview(nameOfTheAuthorLabel)
        view.addSubview(startSongButton)
    }

    @objc private func tabStartOrPauseButton(){
        presenter.tabStartOrPause()
    }

}


extension InfoSongViewController : InfoSongViewControllerInputProtocol{
    func changeImagestartSongButton(playNow : Bool) {
        if playNow {
            startSongButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            startSongButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
        }
    }
    
    func fetchImage(image : UIImage, nameOfSong: String, nameOfAuthor : String) {
        self.image.image = image
        self.nameOfTheSongLabel.text = nameOfSong
        self.nameOfTheAuthorLabel.text = nameOfAuthor
    }
    
    
}




extension InfoSongViewController{
  
    func setupConstraints(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * (15 / 100)),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * (10 / 100)),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (80 / 100)),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (80 / 100))
        ])
        
        NSLayoutConstraint.activate([
            nameOfTheSongLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * (52 / 100)),
            nameOfTheSongLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * (10 / 100)),
            nameOfTheSongLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (10 / 100)),
            nameOfTheSongLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (80 / 100))
        ])
        
        NSLayoutConstraint.activate([
            nameOfTheAuthorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * (55 / 100)),
            nameOfTheAuthorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * (10 / 100)),
            nameOfTheAuthorLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (10 / 100)),
            nameOfTheAuthorLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (80 / 100))
        ])
        

        
        NSLayoutConstraint.activate([
            startSongButton.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * (63 / 100)),
            startSongButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width * (35 / 100)),
            startSongButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (10 / 100)),
            startSongButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (30 / 100))
        ])
        

    }
}
