//
//  ViewController.swift
//  iTunes
//
//  Created by Алёша Виноградов on 25.05.2023.
//

import UIKit

protocol PageWithAllSongsViewControllerInputProtocol : AnyObject{
    func updateSongsModel(songs : MusicModel)
}

protocol PageWithAllSongsViewControllerOutputProtocol : AnyObject{
    init(viewController : PageWithAllSongsViewControllerInputProtocol)
    func tabOnSelectRow(song : Result)
    func fetchSongs(songName : String)
}

let downloadProblem = UIImage(systemName: "network")

class PageWithAllSongsViewController: UIViewController {
    
    var indicator = UIActivityIndicatorView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    var songs = MusicModel(resultCount: 0, results: [])
    
    var presentor : PageWithAllSongsViewControllerOutputProtocol!
    private let configurator : PageWithAllSongsConfiguratorInputProtocol = PageWithAllSongsConfigurator()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configurator.configur(with: self)
        
        
        setupIndicator()
        
    }
    func setupIndicator(){
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.color = .gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    
        indicator.isHidden = false
      //  indicator.startAnimating()
        indicator.stopAnimating()
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
        
        
    }
    
    func setupView(){

        view.backgroundColor = .white
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        view.addSubview(tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "search"
        searchController.obscuresBackgroundDuringPresentation = false

        tableView.register(
            UINib(nibName: "SongCell", bundle: nil),
            forCellReuseIdentifier: "cell"
        )
    }
    
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * (9 / 100)),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


extension PageWithAllSongsViewController : UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentor.tabOnSelectRow(song: songs.results[indexPath.row])
    }
}

extension PageWithAllSongsViewController : UITableViewDataSource{
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell" ) as! SongCell
        
        cell.songName.text =  songs.results[indexPath.row].trackName
        cell.authorName.text = songs.results[indexPath.row].artistName
        
        if let urlImg = songs.results[indexPath.row].artworkUrl100{
            NetworkDataFetch.shared.fetchImg(urlImage: urlImg) { image in
                guard let img = image else {
                    cell.imageOnCell.image = downloadProblem
                    return
                }
                cell.imageOnCell.image = img
            }
        } else {
            cell.imageOnCell.image = downloadProblem
        }
        cell.selectionStyle = .none
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }


}

extension PageWithAllSongsViewController :  UISearchControllerDelegate{
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        })
    }
}

extension PageWithAllSongsViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2{
            presentor.fetchSongs(songName: searchText)
            indicator.startAnimating()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        songs.results = []
        tableView.reloadData()
    }

}



extension PageWithAllSongsViewController : PageWithAllSongsViewControllerInputProtocol {
    func updateSongsModel(songs: MusicModel) {
        self.songs = songs
        tableView.reloadData()
        indicator.stopAnimating()
    }
}


