//
//  ViewController.swift
//  LivelikeSample
//
//  Created by Shahid Ali on 4/11/21.
//

import UIKit

class HomeVC: UIViewController {

	private let viewModel = HomeVM()
	private let cellId = "cellId"

	private lazy var tableView: UITableView = {

			let tv = UITableView(frame: .zero, style: .plain)
				tv.translatesAutoresizingMaskIntoConstraints = false
				tv.dataSource = self
				tv.register(HomeCell.self, forCellReuseIdentifier: self.cellId)
				tv.rowHeight = UITableView.automaticDimension
				tv.estimatedRowHeight = 44
			return tv
		}()
	
	
	private lazy var searchTF: UITextField = {
		let tf = UITextField(frame: .zero)
		    tf.translatesAutoresizingMaskIntoConstraints = false
			tf.backgroundColor = .lightGray
			tf.delegate=self
			tf.returnKeyType = .done
			tf.borderStyle = .roundedRect
			tf.placeholder="Search"
			tf.autocorrectionType = .no
			return tf
		}()
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.large)
			indicator.hidesWhenStopped = false
			return indicator
		}()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "LiveLikeDemo"
				
		setupViews()
		
		//fetch trending gifs
		activityIndicator.startAnimating()
		viewModel.fetchTrendingGifs {[weak self] (flag) in
			
			DispatchQueue.main.async {
				self?.activityIndicator.stopAnimating()
				self?.tableView.reloadData()
			}
		}
	}

	//MARK:setupViews
	func setupViews()
	{
		view.addSubview(searchTF)
		view.addSubview(tableView)
		view.addSubview(activityIndicator)
		
		view.backgroundColor = .white
		
		setupAutoLayout()
	}
	
	//MARK:setupAutoLayout
	func setupAutoLayout() {
		searchTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		searchTF.heightAnchor.constraint(equalToConstant: 40).isActive = true
		searchTF.widthAnchor.constraint(equalTo:view.widthAnchor, multiplier:1.0).isActive = true
		
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		tableView.topAnchor.constraint(lessThanOrEqualTo:searchTF.bottomAnchor, constant:10).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		
		activityIndicator.center = tableView.center
		}

}

extension HomeVC:UITableViewDataSource
{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

			return viewModel.getItemCounts()
		}

		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

			let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeCell
			cell.giffyItem=viewModel.getItem(at:indexPath.row)
			return cell
		}
}

extension HomeVC:UITextFieldDelegate
{
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
	{
		return true
	}

	
	func textFieldDidBeginEditing(_ textField: UITextField)
	{
	}

	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
	{
		return true
	}

	
	func textFieldDidEndEditing(_ textField: UITextField)
	{
	}

	
	func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason)
	{
	}

	
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
	{
		return true
	}

	
	
	func textFieldDidChangeSelection(_ textField: UITextField)
	{
		if let text=textField.text
		{
				if text.isEmpty
				{
					activityIndicator.startAnimating()
					viewModel.fetchTrendingGifs { [weak self](flag) in
						DispatchQueue.main.async {
							self?.activityIndicator.stopAnimating()
							self?.tableView.reloadData()
						}
					}
				}
				else
				{
					activityIndicator.startAnimating()
					viewModel.searchGifs(query:text) { [weak self](flag) in
						DispatchQueue.main.async {
							self?.activityIndicator.stopAnimating()
							self?.tableView.reloadData()
						}
					}
				}
		}
		
	}

	
	
	func textFieldShouldClear(_ textField: UITextField) -> Bool
	{
		return true
	}

	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		return true
	}
}
