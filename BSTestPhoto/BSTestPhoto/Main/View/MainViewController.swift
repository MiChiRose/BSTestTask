//
//  MainViewController.swift
//  BSTestPhoto
//
//  Created by Yura Menschikov on 8/31/20.
//  Copyright © 2020 Yura Menschikov. All rights reserved.
//

import UIKit

// MARK: - MainViewController

final class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var tableView = UITableView()
    private var dataArray = [PhotoContent]()
    private var network: INetworkLayer?
    
    // MARK: - Public properties
    
    var selectedCell = 0
    var moreDataInTable = false
    var stopBreak = false
    var page = 0
    
    var viewImageModel: [ImagePropertiesInCell] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    
        setupView()
    }
    
    // MARK: - Public methods
    
    func getData(){
        if !stopBreak {
            moreDataInTable = true
            NetworkLayer.jsonDataTaskGet(page: page) {
                (viewImageModel) in
                self.page += 1
                self.moreDataInTable = false
                let newData = viewImageModel
                if newData.count < 1 {
                    self.stopBreak = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.stopBreak = false
                    })
                }
                self.viewImageModel.append(contentsOf: newData)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewImageModel.count
        } else if section == 1 && moreDataInTable {
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.indetifire, for: indexPath)
        
        cell.textLabel?.text = viewImageModel[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row - 1
        takePhoto()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offSetY > contentHeight - scrollView.frame.height {
            if !moreDataInTable {
                getData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource{
    
}

// MARK: - UIImagePickerControllerDelegate

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            NetworkLayer.jsonDataTaskPost(id: selectedCell, image: pickedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setups

private extension MainViewController {
    func setupView() {
        addViews()
        
        setupTableView()
        
        layuot()
    }
}

// MARK: - Setups View

private extension MainViewController {
    
    func addViews() {
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.indetifire)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Setups

private extension MainViewController {
    
    func layuot() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: Constants.tableViewTopAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Constants.tableViewBottomAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.tableViewLeadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: Constants.tableViewTrailingAncho),])
    }
}

// MARK: - Constants
    
private extension MainViewController {
    
    enum Constants {
        static let indetifire: String = "Cell"
        
        static let tableViewTopAnchor: CGFloat = 0
        static let tableViewBottomAnchor: CGFloat = 0
        static let tableViewLeadingAnchor: CGFloat = 0
        static let tableViewTrailingAncho: CGFloat = 0
    }
    
}
