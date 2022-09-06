//
//  RestaurantTableViewCell.swift
//  RestaurantiOS
//
//  Created by Marcelo Fernandez on 05/09/2022.
//

import Foundation
import UIKit

class RestaurantTableViewCell: UITableViewCell {
    static let identifier = "RestaurantTableViewCell"
    
    var restaurantId: String = ""
    let restaurantImg = UIImageView()
    let restaurantName = UILabel()
    let restaurantRating = UILabel()
    let restaurantAddress = UILabel()
    let restaurantFavorite = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
        configureLabelsFont()
        setFavoriteIconHandler()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteIconHandler() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteIconTapped(tapGestureRecognizer:)))
        restaurantFavorite.isUserInteractionEnabled = true
        restaurantFavorite.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func favoriteIconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if RestaurantCellModel.isFavorite(self.restaurantId) {
            restaurantFavorite.image = UIImage(named: "FavoriteOff")
            RestaurantCellModel.removeFavorite(self.restaurantId)
        } else {
            restaurantFavorite.image = UIImage(named: "FavoriteOn")
            RestaurantCellModel.addFavorite(self.restaurantId)
        }
    }
    
    func configureLayout() {
        restaurantImg.translatesAutoresizingMaskIntoConstraints = false
        restaurantName.translatesAutoresizingMaskIntoConstraints = false
        restaurantRating.translatesAutoresizingMaskIntoConstraints = false
        restaurantAddress.translatesAutoresizingMaskIntoConstraints = false
        restaurantFavorite.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(restaurantImg)
        contentView.addSubview(restaurantName)
        contentView.addSubview(restaurantRating)
        contentView.addSubview(restaurantAddress)
        contentView.addSubview(restaurantFavorite)
    }
    
    func configureLabelsFont() {
        restaurantName.font = UIFont.boldSystemFont(ofSize: 15.0)
        restaurantAddress.font = UIFont.systemFont(ofSize: 10.0)
        restaurantRating.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    func configureCellWith(model: RestaurantCellModel) {
        restaurantId = model.id
        if let imageUrl = model.image {
            restaurantImg.load(url: imageUrl)
        } else {
            restaurantImg.image = UIImage(named: "Placeholder")
        }
        restaurantName.text = model.name
        restaurantRating.text = "\(model.rating)"
        restaurantAddress.text = model.address
        restaurantFavorite.image = model.favorite ? UIImage(named: "FavoriteOn") : UIImage(named: "FavoriteOff")
    }
    
    func setConstraints() {
        let constraints = [
            restaurantImg.topAnchor.constraint(equalTo: topAnchor),
            restaurantImg.bottomAnchor.constraint(equalTo: bottomAnchor),
            restaurantImg.leftAnchor.constraint(equalTo: leftAnchor),
            restaurantImg.widthAnchor.constraint(equalTo: restaurantImg.heightAnchor),
            restaurantName.leftAnchor.constraint(equalTo: restaurantImg.rightAnchor),
            restaurantName.topAnchor.constraint(equalTo: topAnchor),
            restaurantAddress.topAnchor.constraint(equalTo: restaurantName.bottomAnchor),
            restaurantAddress.leftAnchor.constraint(equalTo: restaurantImg.rightAnchor),
            restaurantFavorite.rightAnchor.constraint(equalTo: rightAnchor),
            restaurantFavorite.topAnchor.constraint(equalTo: topAnchor),
            restaurantFavorite.widthAnchor.constraint(equalToConstant: 20.0),
            restaurantFavorite.heightAnchor.constraint(equalToConstant: 20.0),
            restaurantRating.rightAnchor.constraint(equalTo: rightAnchor),
            restaurantRating.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
