//
//  MoviesViewModel.swift
//  SwagAdmin
//
//  Created by Kazim Ahmad on 03/02/2026.
//

import Foundation

@MainActor
class MoviesViewModel: ObservableObject {
    var coordinator: MoviesCoordinator?
    @Published var viewState: ViewState = .loading

    @Published var moviesObj: ItemsObject<Movie>?
    @Published var categories: [Category] = []
    @Published var selectedCategory: Category?

    var page: Int = 0

    init(coordinator: MoviesCoordinator?) {
        self.coordinator = coordinator
        self.categories = categories
    }
    
    func movies() -> [Movie] {
        return moviesObj?.items ?? []
    }
    
    func isSelectedCategory(_ category: Category) -> Bool {
        return selectedCategory?.id == category.id
    }
    
    func hasMoreMovies() -> Bool {
        moviesObj?.items.count ?? 0 < moviesObj?.total ?? 0
    }
    
    func showMore(of movie: Movie) {
        let config = SeeMoreConfig(type: .movie,
                                   title: movie.title,
                                   description: movie.myReview) { [weak self] in
            self?.coordinator?.dismissFullScreenCover()
        }
        coordinator?.present(fullScreenCover: .seeMore(config))
    }
    
    func reinitialise() {
        viewState = .loading
        page = 0
        moviesObj = nil
        getMovies()
    }
}

extension MoviesViewModel {
    func seeAllCategories() {
        coordinator?.seeAllCategories(categories: categories,
                                      selectedCategory: selectedCategory) { [weak self] cat in
            if let category = self?.categories.first(where: { $0.id == cat?.id }) {
                self?.selectedCategory = category
            } else {
                let newCategory: Category = .init(id: cat?.id ?? 0, name: cat?.name ?? "")
                self?.selectedCategory = newCategory
                self?.categories.insert(newCategory, at: 0)
            }
            self?.viewState = .loading
            self?.page = 0
            self?.moviesObj = nil
            self?.getMovies()
        } didClearCategory: { [weak self] in
            self?.selectedCategory = nil
            self?.viewState = .loading
            self?.page = 0
            self?.moviesObj = nil
            self?.getMovies()
        } didDeleteCategory: { [weak self] cat in
            let catToDel: Category = .init(id: cat?.id ?? 0, name: cat?.name ?? "")
            self?.categories.removeAll(where: { $0.id == catToDel.id })
        }
    }
}

extension MoviesViewModel {
    func getInitialData() {
        getCategories()
        getMovies()
    }
    
    func getCategories() {
        Task {
            do {
                self.categories = try await coordinator?.repository.fetchCategories() ?? []
            } catch {
                print(error)
            }
        }
    }
    
    func getMovies() {
        page = page + 1
        Task {
            do {
                let movie = try await coordinator?.repository.fetch(for: page, categoryId: selectedCategory?.id)
                if self.moviesObj == nil {
                    self.moviesObj = movie
                } else {
                    self.moviesObj?.items.append(contentsOf: movie?.items ?? [])
                }
                if movie?.items.count ?? 0 == 0 {
                    viewState = .empty
                } else {
                    viewState = .info
                }
            } catch {
                viewState = .error(error)
            }
        }
    }
}
