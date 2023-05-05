# URLSession-Example

[Unsplash API](https://unsplash.com/documentation)를 사용해서 URLSession 데이터 fetch, upload 코드를 작성했습니다. 
자세한 내용은 노션 블로그 글에서 보실 수 있습니다.

- [URLSession 뜯어보기 - Shared Session 사용해서 데이터 보내고 받아보기](https://yoonah-dev.oopy.io/a187c843-11d1-4d53-8359-b1ec593a1729)
- [URLSession 뜯어보기 - URLSessionConfiguration 사용, 네트워크 코드 공통화 시키기](https://yoonah-dev.oopy.io/5862dd7a-84c2-413a-8a3e-b19407109562)

<br><br>

## 💭 ViewController

두 API를 사용해서 화면에 사진과 collection 목록을 띄워줍니다.
- [GET] https://api.unsplash.com/photos
- [GET] https://api.unsplash.com/collections

<div align="center"> 

![Simulator Screen Recording - iPhone 14 Pro - 2023-05-05 at 20 12 24](https://user-images.githubusercontent.com/55099365/236443174-21a93885-a2bb-44d0-acb4-cf881462bfae.gif)

</div>

### fetchImages
shared session `dataTask` 메소드로 사진을 가져와서 completion handler를 사용해서 응답 데이터를 받습니다.

```swift
private func fetchImages() {
    var url = URL(string: "https://api.unsplash.com/photos")!
    url.append(queryItems: [
        URLQueryItem(name: "per_page", value: "20"),
        URLQueryItem(name: "order_by", value: "popular")
    ])
    var urlRequest = URLRequest(url: url)
    urlRequest.allHTTPHeaderFields = ["Authorization": "\(KeyProvider.appKey(of: .clientId))"]
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        // ...
    }
    task.resume()
}
```

### fetchCollections
default session `dataTask` 메소드로 콜렉션 목록을 가져와서 URLSessionDataDelegate 안에 있는 메서드를 통해서 응답 데이터를 받습니다.

```swift
private func fetchCollections() {
    let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        return URLSession(configuration: configuration,
                          delegate: self, delegateQueue: nil)
    }()
    let url = URL(string: "https://api.unsplash.com/collections")!
    var urlRequest = URLRequest(url: url)
    urlRequest.allHTTPHeaderFields = ["Authorization": "\(KeyProvider.appKey(of: .clientId))"]
    let task = session.dataTask(with: urlRequest)
    task.resume()
}
```

#### URLSessionDataDelegate Method
```swift
// MARK: - URLSessionDataDelegate
extension ViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        // ...
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // ...
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // ...
    }
}
```

<br>

## 💭 CollectionViewController

API를 사용해서 Collection를 생성합니다.
- [POST] https://api.unsplash.com/collections

<div align="center"> 

![Simulator Screen Recording - iPhone 14 Pro - 2023-05-05 at 00 16 01](https://user-images.githubusercontent.com/55099365/236444940-b4fd9b46-7900-47d4-80e4-33a5dc06e9ea.gif)

</div>

### uploadCollection
shared session `upload` 메소드로 title, description, private 값을 메시지 바디에 보내어 콜렉션을 생성합니다.  
completion handler를 사용해서 응답 데이터를 받습니다.

```swift
private func uploadCollection(_ collection: CollectionRequestDTO) {
    guard let data = self.encodeCollection(collection) else { return }
    let task = URLSession.shared.uploadTask(with: self.urlRequest, from: data) { data, response, error in
        // ...
    }
    task.resume()
}
```
        
