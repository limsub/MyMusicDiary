//
//  GenreViewModel.swift
//  MyMusicDiary
//
//  Created by 임승섭 on 2023/10/11.
//

import Foundation
import MusicKit


class GenreViewModel {
    
    var genre: Genre?
    
    var musicList: Observable<[MusicItem]> = Observable([])
    var wholeData: [MusicItem] = []
    
    var title: String?
    
    var isLoading: Observable<Bool> = Observable(false)
    
    var currentOffset: Int = 0
    
    var paginationDone = true
    
    
    
    // 데이터 fetch (네트워크 통신)
    func fetchInitialMusic() {
        Task {
            var request = MusicCatalogChartsRequest(
                genre: genre,
                kinds: [.cityTop],
                types: [Song.self]
            )
            request.limit = 25
            request.offset = 1
            
            let result = try await request.response()
            self.musicList.value = result.songCharts[0].items.map {
                return .init(id: $0.id.rawValue, name: $0.title, artist: $0.artistName, bigImageURL: $0.artwork?.url(width: 700, height: 700)?.absoluteString, smallImageURL: $0.artwork?.url(width: 150, height: 150)?.absoluteString, previewURL: $0.previewAssets?[0].url?.absoluteString, genres: $0.genreNames, backgroundColor: $0.artwork?.backgroundColor)
            }
            
            currentOffset += 25
        }
    }
    
    func fetchWholeMusic() {
        Task {
            var request = MusicCatalogChartsRequest(
                genre: genre,
                kinds: [.cityTop],
                types: [Song.self]
            )
            request.limit = 150
            request.offset = 1
            
            let result = try await request.response()
            self.wholeData = result.songCharts[0].items.map {
                return .init(id: $0.id.rawValue, name: $0.title, artist: $0.artistName, bigImageURL: $0.artwork?.url(width: 700, height: 700)?.absoluteString, smallImageURL: $0.artwork?.url(width: 150, height: 150)?.absoluteString, previewURL: $0.previewAssets?[0].url?.absoluteString, genres: $0.genreNames, backgroundColor: $0.artwork?.backgroundColor)
            }
            
            currentOffset += 25
        }
    }
    
    // 데이터 update (wholeList -> musicList)
    func updateMusicListFromWholeList() {
        musicList.value.append(contentsOf: wholeData[currentOffset..<currentOffset+25])
        currentOffset += 25
    }
    
    
    // pagination 가능 여부 (1. indexPath 위치, 2. 더 받을 데이터가 있는지)
    func isPossiblePagination(_ indexPath: IndexPath) -> Bool {
        return (indexPath.row == musicList.value.count - 1 && currentOffset + 25 < wholeData.count)
    }
}
