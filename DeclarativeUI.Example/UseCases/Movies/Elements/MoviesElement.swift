//
//  Elements.swift
//  DeclarativeUI.Example
//
//  Created by Alexander Martirosov on 11/10/19.
//  Copyright © 2019 Alexander Martirosov. All rights reserved.
//

import UIKit
import ReSwift

protocol MoviesElementProtocol: ListElement where TItem == Movie  {
    
}

final class MoviesElement: ListElementImpl<Movie, MovieElement>, MoviesElementProtocol {
    
    var props: Props? {
        didSet {
            guard let props = props else {
                return
            }
            
            guard props.movies.difference(from: oldValue?.movies ?? []).count > 0 else {
                return
            }
            
            update(with: props.movies, animated: true)
        }
    }
    
    struct Props {
        let movies: [Movie]
        
        init(movies: [Movie]) {
            self.movies = movies
        }
    }
}

extension MoviesElement: StoreSubscriber {
    func newState(state: MoviesState) {
        switch state.movies {
        case .loaded(let movies):
            self.props = Props(movies: movies)
        default:
            break
        }
    }
}

final class MovieElement: ListItemElementImpl<Movie> {
   
    private var thumbnail: ContainerElement!
    
    private var thumbnailIcon: ImageElement!
    
    private var title: TextElement!
    
    private var genre: TextElement!
    
    private var rating: TextElement!
    
    private var about: TextElement!
    
    private var tags: TextElement!
    
    public required init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(model: Movie) {
        super.init(model: model)
        backgroundColor = Color.itemContainer.uiColor
        layer.cornerRadius = 10
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 14, leading: 12, bottom: 16, trailing: 12)
        setupElements()
        update(with: model)
    }
    
    override func update(with model: Movie) {
        super.update(with: model)
        title.text = model.title
        about.text = model.summary
        genre.text = model.genre
        rating.text = Formatter.rating(model.rating)
        thumbnailIcon.image = Icon.movie.image
    }
    
    private func setupElements() {

        thumbnail = addElement {
            ContainerElementMaker()
                .background(Color.background.alpha(0.3))
                .corners(CornerRadius(value: 8))
                .width(70)
                .height(90)
                .pin(at: .leading())
                .pin(at: .top())
        }
        
        thumbnailIcon = thumbnail.addElement {
            ImageElementMaker()
                .width(53)
                .height(53)
                .contentMode(.center)
                .pin()
        }

        title = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.title(size: 21)).line(28).color(.title))
                .pin(at: .top(toElement: thumbnail, offset: 2))
                .pin(at: .trailing(offset: 12))
                .pin(at: .leadingTrailing(toElement: thumbnail, offset: 20))
        }

        genre = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.accent(size: 15)).color(.main))
                .pin(at: .topBottom(toElement: title, offset: 5))
                .pin(at: .leading(toElement: title))
        }
        
        rating = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.dominant(size: 15)).color(.main))
                .pin(at: .bottom(toElement: genre))
                .pin(at: .leadingTrailing(toElement: genre, offset: 5))
        }
        
        about = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.ui(size: 15)).line(20).character(0.2).color(.text))
                .pin(at: .leading(toElement: title))
                .pin(at: .trailing(toElement: title))
                .pin(at: .topBottom(toElement: genre, offset: 11))
        }
        
        tags = addElement {
            TextElementMaker()
                .textStyleFactory(TextStyleBuilder().font(.accent(size: 15)).color(.main))
                .text("Mark Hamill, Daisy Ridley")
                .pin(at: .leading(toElement: title))
                .pin(at: .trailing(toElement: title))
                .pin(at: .topBottom(toElement: about, offset: 11))
                .pin(at: .bottom())
        }
    }
}


