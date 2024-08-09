//
//  HomeScreen.swift
//  HayatWalletTest
//
//  Created by Finartz on 2.08.2024.
//

import Foundation
import UIKit

class HomeScreen: UIViewController{
    
    @IBOutlet weak var secondCustomView: secondCustomView!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let viewModel = CampaignScreenViewModel()
    
    let brandNames = ["Apple", "Samsung"]
    let brandDatesTimes = ["12:27", "12:30"]
    let brandImages = ["applelogo", "samsunglogo"]
    let amounts = ["1000 ₺", "1000 ₺"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondCustomView.mytableView.delegate = self
        secondCustomView.mytableView.dataSource = self
        secondCustomView.mytableView.register(TranscTableViewCell.nib(), forCellReuseIdentifier: TranscTableViewCell.identifier)
        secondCustomView.mytableView.layer.cornerRadius = 20
        
        secondCustomView.collectionView.layer.cornerRadius = 50
        secondCustomView.collectionView.register(secondCollectionViewCell.nib(), forCellWithReuseIdentifier: secondCollectionViewCell.identifier)
        secondCustomView.collectionView.delegate = self
        secondCustomView.collectionView.dataSource = self
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.secondCustomView.collectionView.reloadData()
            }
        }
        viewModel.onError = { error in
            print("Error fetching data: \(error)")
        }
        viewModel.fetchCampaigns()
        
    }
    
    
}

extension HomeScreen: UITableViewDelegate{
    
}
extension HomeScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brandNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = secondCustomView.mytableView.dequeueReusableCell(withIdentifier: TranscTableViewCell.identifier, for: indexPath) as! TranscTableViewCell
        cell.brandNameLabel.text = brandNames[indexPath.row]
        cell.dateTimeLabel.text = brandDatesTimes[indexPath.row]
        cell.amountLabel.text = amounts[indexPath.row]
        let image = brandImages[indexPath.row]
        cell.brandImage.image = UIImage(named: image)
        return cell
    }
}
extension HomeScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let campaign = viewModel.campaigns[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailScreenVC = storyboard.instantiateViewController(withIdentifier: "DetailsScreen") as? DetailsScreen else {
            print("DetailsScreen view controller not found.")
            return
        }
        
        print("cell e tıklandı")
        detailScreenVC.body = campaign
        navigationController?.pushViewController(detailScreenVC, animated: true)
    }
}

extension HomeScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.campaigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: secondCollectionViewCell.identifier, for: indexPath) as! secondCollectionViewCell
        
        let campaign = viewModel.campaigns[indexPath.row]
        cell.titleLabel.text = campaign.title
        if let imageUrl = campaign.imageUrl {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string: imageUrl)!) {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.layer.cornerRadius = 50
        cell.backgroundColor = UIColor.white
        
        return cell
    }
}

extension HomeScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 250.0
        let height = width
        return CGSize(width: width, height: height)
    }
}



