//
//  HomeVM.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/12/21.
//

import UIKit

class HomeVM {
	private let apiClient=APIClient()  // APIclient instance will be shared among VMs and not be created for each VM
	private var fetchLimit=5 // it will be passed from view controller in real world scenario
	private var rating="g"
	private var offset=0
	private var dataItems:[GiffyItem]=[]
	private var oldSearchTasks:[URLSessionDataTask]=[]
	
	//MARK: fetchTrendingGifs
	func fetchTrendingGifs(completion : @escaping (Bool) -> Void)
	{
		//cancel all previous tasks
		for task in oldSearchTasks
		{
			task.cancel()
		}
		
		oldSearchTasks=[]
		
		let limitQueryItem = URLQueryItem(name: "limit", value:"\(fetchLimit)")
		let ratingQueryItem = URLQueryItem(name: "rating", value:"\(rating)")
		let queryItems=[limitQueryItem,ratingQueryItem]
		let task=apiClient.sendRequest(for:GIffyResponseData.self,url: .trendingGIF,method: .get, queryItems:queryItems) {[weak self] (result) in
			
			switch result {
				case let .success(GIFs):
					if let dataItems=GIFs.data
					{
					self?.dataItems=dataItems
					}
					completion(true)
				case let .failure(error):
					print("error \(error)")
					completion(false)
				}
		}
		
		//add new task in array
		if let task=task
		{
		oldSearchTasks.append(task)
		}
	}
	
	
	
	
	//MARK: search GIF items
	func searchGifs(query:String,completion : @escaping (Bool) -> Void)
	{
		let limitQueryItem = URLQueryItem(name: "limit", value:"\(fetchLimit)")
		let offsetQueryItem = URLQueryItem(name: "offset", value:"\(offset)")
		let ratingQueryItem = URLQueryItem(name: "rating", value:"\(rating)")
		let langQueryItem = URLQueryItem(name: "lang", value:"\("en")")
		let qQueryItem = URLQueryItem(name: "q", value:"\(query)")
		
		
		let queryItems:[URLQueryItem]=[limitQueryItem,offsetQueryItem,ratingQueryItem,langQueryItem,qQueryItem]
			
		
		//cancel all previous tasks
		for task in oldSearchTasks
		{
			task.cancel()
		}
		
		oldSearchTasks=[]
		
		let task=apiClient.sendRequest(for:GIffyResponseData.self,url: .searchGIF,method: .get, queryItems:queryItems) {[weak self] (result) in
			
			switch result {
				case let .success(GIFs):
					if let dataItems=GIFs.data
					{
					self?.dataItems=dataItems
					completion(true)
					}
					
					print("searchGifs")
			case .failure(_):
					completion(false)
				}
		}
		
		//add new task in array
		if let task=task
		{
		oldSearchTasks.append(task)
		}
	}
	
	
	
	//MARK:getItemCounts return item count
	func getItemCounts() -> Int
	{
		return dataItems.count
	}
	
	
	
	//MARK:getItem return item at given index
	func getItem(at:Int) -> GiffyItem
	{
		return dataItems[at]
	}
	

}
