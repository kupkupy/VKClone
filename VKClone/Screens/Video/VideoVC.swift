//
//  VideoVC.swift
//  vk-tanya
//
//  Created by Tanya on 22.08.2022.
//

import UIKit

class VideoVC: UIViewController {
    
    #warning("Добавить prefetch")
    #warning("НЕТ КАРТИНКИ В ВИДЕО!!")
    
    let videosAPI = VideoAPI()
    
    var videos: [Video] = []
    
    lazy var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Видеозаписи"
        
        videosAPI.fetchVideos(offset: 0) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let videos):
                self.videos = videos
                self.videosTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
//        videosAPI.fetchVideos { [weak self] result in
//
//        }
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(videosTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            videosTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            videosTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            videosTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            videosTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension VideoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
        
        let video = videos[indexPath.row]
        
        cell.configureCell(with: video)
        
        return cell
    }
    
}

extension VideoVC: UITableViewDelegate {}

extension VideoVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
