//
//  VideoCell.swift
//  vk-tanya
//
//  Created by Tanya on 22.08.2022.
//

import UIKit
import WebKit

class VideoCell: UITableViewCell {
    
    var webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .systemPink
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var videoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Video title"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(webView)
        contentView.addSubview(videoTitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            webView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: videoTitleLabel.topAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            videoTitleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor),
            videoTitleLabel.leadingAnchor.constraint(equalTo: webView.leadingAnchor, constant: 16),
            videoTitleLabel.trailingAnchor.constraint(equalTo: webView.trailingAnchor, constant: -16),
            videoTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configureCell(with data: Video) {
        videoTitleLabel.text = data.title
        guard let url = URL(string: data.player) else { return }
        let request = URLRequest(url: url)
        
        
        webView.load(request)
    }
}
