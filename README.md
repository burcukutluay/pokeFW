# pokeFW READ ME

## About pokeFW

pokeFW is a framework which gets the result of the searched pokemon Shakespearian style description and default pokemon front image with given keyword. 
- As a result if the pokemon found by the given keyword, pokeFW returns a component (UIView, named InfoView - self). 
- If there is no matched pokemon with the given keyword, pokeFW returns error message with error type ("No Data", "Error").



## pokeFW Dependencies

pokeFW deployment target is IOS 13.0.
pokeFW uses following pods for API calls and download images:

   'Alamofire'
   'AlamofireImage'
   'CodableAlamofire'

## pokeFW How to Use

After adding pokeFW as a framework to XCode project, to get the full benefits import pokeFW wherever you import UIKit.
```
import UIKit
import pokeFW
```
InfoView is the view which runs the operations and returns the view (self). InfoViewDelegate, a protocol, should be implemented to get result and update the view.
```
public protocol InfoViewDelegate: class {
    func viewShouldReturn(view: InfoView, height: CGFloat) // returns InfoView(self) with result (the description and the image)
    func emptyViewShouldReturn(errorMessage: String, type: String) // returns an error message and the error type. 
}
```

If there is matched pokemon with the keyword, viewShouldReturn delegation will be fired. 
```
  func viewShouldReturn(view: InfoView, height: CGFloat) // returns InfoView(self) with result (the description and the image)
 ```
According to viewShouldReturn, view (InfoView - UIView) will be returned with Shakespearian description and the image. height (CGFloat) is a calculated height of the description and the image will be returned. So that imported view controller or class will be informed about the actual height of the view.

If there is no matched pokemon with the keyword or there is a network depended error, emptyViewShouldReturn delegation will be fired. 
```
 func emptyViewShouldReturn(errorMessage: String, type: String)
 ```
According to emptyViewShouldReturn, type (String) will be returned. type can be returned as 'Error' or 'No Data'. 'Error' means network related errors. 'No Data' means there is no matched pokemon with the given keyword.

### pokeFW Public Functions
```
public protocol InfoViewDelegate: class {
    func viewShouldReturn(view: InfoView, height: CGFloat)
    func emptyViewShouldReturn(errorMessage: String, type: String)
}
public init(frame: CGRect)
public init()
public func getAndSetResultView(keyword: String)
public func deleteSubviews()
```
### pokeFW Public Variables
```
    public var descriptionText: String = ""
    public var descriptionImageURL: URL?
```

