//
//  ViewController.swift
//  iTunes
//
//  Created by Алёша Виноградов on 25.05.2023.
//

import UIKit

protocol PageWithAllSongsViewControllerInputProtocol : AnyObject{
    func updateSongsModel(songs : MusicModel)
    func reloadData(for section: SongSectionViewModel)
    func reloadDataAfterCancel()
    
}

protocol PageWithAllSongsViewControllerOutputProtocol : AnyObject{
    init(viewController : PageWithAllSongsViewControllerInputProtocol)
    func tabOnSelectRow(song : SongCellViewModel)
    func fetchSongs(songName : String)
    func didTabCancelOrСhangeWord(section : SongSectionViewModel)
}

let downloadProblem = UIImage(systemName: "network")

class PageWithAllSongsViewController: UIViewController {
    
    var indicator = UIActivityIndicatorView()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let tableView = UITableView()
    
    private var section: SectionRowPresentable = SongSectionViewModel()
    
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
    
        indicator.isHidden = true
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
            forCellReuseIdentifier: "songCell"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(section.rows[indexPath.row].cellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presentor.tabOnSelectRow(song: section.rows[indexPath.row] as! SongCellViewModel)
    }
}

extension PageWithAllSongsViewController : UITableViewDataSource{
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.section.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = section.rows[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier:"songCell" ) as! SongCell
        cell = cell.update(cell: cell, viewModel: viewModel)
        return cell
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
            indicator.startAnimating()
            presentor.didTabCancelOrСhangeWord(section: section as! SongSectionViewModel)
            presentor.fetchSongs(songName: searchText)
           
        } else {
            presentor.didTabCancelOrСhangeWord(section: section as! SongSectionViewModel)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presentor.didTabCancelOrСhangeWord(section: section as! SongSectionViewModel)
    }

}



extension PageWithAllSongsViewController : PageWithAllSongsViewControllerInputProtocol {
//    func reloadData(for section: CourseCellViewModel) {
//        <#code#>
//    }
//    
    func reloadDataAfterCancel() {
        tableView.reloadData()
    }
    
    func updateSongsModel(songs: MusicModel) {
//        self.songs = songs
//        tableView.reloadData()
        
    }
    
    func reloadData(for section: SongSectionViewModel) {
        self.section = section
        tableView.reloadData()
        indicator.stopAnimating()
    }
}


