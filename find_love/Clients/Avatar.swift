

class Avatar {
    private let _hostUrl = "http://boobs.hd2be.com/"
    private var _url: String
    
    var completeURL: String {
        return _hostUrl + _url
    }
    
    required init(url: String) {
        _url = url
    }
}
