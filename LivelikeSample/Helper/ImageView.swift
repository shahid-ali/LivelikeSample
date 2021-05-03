//
//  ImageView.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//

import UIKit


final class LiveLikeNetworking {
	
	// MARK: - getData
	private static func getData(url: URL,
								completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	
	// MARK: - downloadImage
	public static func downloadImage(url: URL,
									 completion: @escaping (Result<Data,Error>) -> Void) {
		LiveLikeNetworking.getData(url: url) { data, response, error in
			
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data, error == nil else {
				return
			}
			
			DispatchQueue.main.async() {
				completion(.success(data))
			}
		}
	}
}

let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView extension
extension UIImageView {
	
	func loadImage(urlSting: String) {
		guard let url = URL(string: urlSting) else { return }
		image = nil
		
		if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
			image = imageFromCache as? UIImage
			return
		}
		LiveLikeNetworking.downloadImage(url: url) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let data):
				guard let imageToCache = UIImage(data: data) else { return }
				imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
				self.image = UIImage(data: data)
			case .failure(_):
				self.image = UIImage(named: "noImage")
			}
		}
	}
}
