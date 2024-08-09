import Foundation
import SwiftSoup

class CampaignScreenViewModel {
    
    var onDataUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    private(set) var campaigns = [HayatCampaignModel]() {
        didSet {
            onDataUpdate?()
        }
    }
    
    func fetchCampaigns() {
        guard let url = URL(string: "https://www.hayatfinans.com.tr/kendim-icin-kampanyalar") else { return }
        URLSession.shared.dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
            if let error = error {
                self?.onError?(error)
                return
            }
            guard let data = data else { return }
            let html = String(decoding: data, as: UTF8.self)
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let container: Element? = doc.body()
                
                // Ensure container is not nil
                guard let container = container else { return }
                
                //  class "card h-100" ile get elements
                let cards: Elements = try container.getElementsByClass("card h-100")
                for element in cards {
                    let imageUrl = try element.getElementsByTag("img").first()?.attr("data-src")
                    let title = try element.getElementsByClass("card-title").first()?.text()
                    let fullImageUrl = "https://www.hayatfinans.com.tr\(imageUrl ?? "")"
                    let campaign = HayatCampaignModel(imageUrl: fullImageUrl, title: title)
                    self?.campaigns.append(campaign)
                }
            } catch {
                self?.onError?(error)
            }
        }.resume()
    }
}
