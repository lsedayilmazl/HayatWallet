
import UIKit
import SwiftSoup

class CampaignScreen: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel = CampaignScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.onError = { error in
            print("Error fetching data: \(error)")
        }
        viewModel.fetchCampaigns()
    }
    
    @objc func buttonClicked(sender: UIButton) {
        let convertedPoint: CGPoint = sender.convert(CGPoint.zero, to: self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: convertedPoint) else { return }
        let campaign = viewModel.campaigns[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsScreenVC = storyboard.instantiateViewController(withIdentifier: "DetailsScreen") as! DetailsScreen
        detailsScreenVC.body = campaign
        navigationController?.pushViewController(detailsScreenVC, animated: true)
        
        
    }
    
}

extension CampaignScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped the cell")
    }
}

extension CampaignScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.campaigns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
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
        return cell
    }
}

extension CampaignScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20)
        let height = width + 50
        return CGSize(width: width, height: height)
    }
}
