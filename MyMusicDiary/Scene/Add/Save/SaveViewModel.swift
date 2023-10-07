//
//  SaveViewModel.swift
//  MyMusicDiary
//
//  Created by 임승섭 on 2023/09/27.
//

import Foundation

class SaveViewModel {
    
    let repository = MusicItemTableRepository()
    
    var musicList: Observable<[MusicItem]> = Observable([])
    
    func numberOfItems() -> Int {
        return musicList.value.count
    }
    

    
    // 데이터 추가 (저장 버튼 클릭)
    func addNewData() {
//        let todayTable = DayItemTable(day: Date())
        

        let todayTable = DayItemTable(day: Calendar.current.date(byAdding: .day, value: -25, to: Date())!)
        
    
        
        // 저장할 음악들
        musicList.value.forEach {
            // 기존에 저장했던 음악
            if let alreadyMusic = repository.alreadySave($0.id) {
                repository.plusCnt(alreadyMusic)
                repository.appendMusicItem(todayTable, musicItem: alreadyMusic)
            } else {    // 처음 저장하는 음악
                let newMusic = repository.makeMusicItemTable($0)
                repository.appendMusicItem(todayTable, musicItem: newMusic) // MusicItemTable에 자동 추가
            }
        }
        repository.createDayItem(todayTable)
    }
    
    func music(_ indexPath: IndexPath) -> MusicItem {
        return musicList.value[indexPath.row]
    }
    
    func musicRecordCount(_ indexPath: IndexPath) -> Int {
        let id = musicList.value[indexPath.row].id
        if let music = repository.fetchMusic(id) {
            return music.count
        } else {
            return 0
        }
    }
    
    func insertMusic(_ item: MusicItem, indexPath: IndexPath) {
        musicList.value.insert(item, at: indexPath.item)
    }
    func removeMusic(_ indexPath: IndexPath) {
        musicList.value.remove(at: indexPath.item)
    }
    func appendMusic(_ item: MusicItem) {
        musicList.value.append(item)
    }
    
    func musicListCount() -> Int {
        return musicList.value.count
    }
}
