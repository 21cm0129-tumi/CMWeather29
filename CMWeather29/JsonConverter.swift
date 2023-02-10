//
//  JsonConverter.swift
//  CMWeather29
//
//  Created by cmStudent on 2023/02/08.
//

import Foundation

class JSONConverter{
    let url : URL
    
    init(url: URL){
        self.url = url
        
    }
    
    func resume(handler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        // URLからリクエスト(サーバー上のアドレスにデータ取得をお願いする)を作る
        let request = URLRequest(url: url)
        // 通信は共通で実行するれど、取ってきたデータをどうするかは決めてくれ!
        // という状態なのでクロージャー
        // 通信の結果、Data?型(得られたデータ)、
        // URLResponse?型(通信が正常にいったかとかそういうやつ)、
        // Error?型(エラーがあったらエラーを返す)
        // は得られるから、それを使って処理を書いてくれ!ということ。
        var task = URLSession.shared.dataTask(with: request) { data, response, error in
            // dataがあるかどうか?あれば使う。
            //            guard let data = data else { return }
            //
            //            do {
            //                let cat = try JSONDecoder().decode(RequestWether.self, from: data)
            //                print(cat)
            //            } catch let error {
            //                print(error)
            //            }
            //        }
            // データ転送を管理するためのセッションを生成
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: handler)
            
            session.finishTasksAndInvalidate()
            task.resume()
        }
    }
}
