import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    public func imageFromUrl(urlString: String?, placeHolderImage:UIImage?) {
        
        image = placeHolderImage
        
        if var urlS = urlString{
            
            //Servis may return image url without base url so control it
            if !urlS.hasPrefix("http") {
                urlS = ServiceBrain.serviceBaseURL + urlS
            }
            
            if let url = URL(string: urlS) {
                self.af_setImage(withURL: url)
            }
            
        }
    }
    
    
    public func imageFromUrl(urlString: String?, placeHolderImage:UIImage?, success:@escaping ()->Void, fail:@escaping ()->Void) {
        
        image = placeHolderImage
        
        if var urlS = urlString{
            
            //Servis may return image url without base url so control it
            if !urlS.hasPrefix("http") {
                urlS = ServiceBrain.serviceBaseURL + urlS
            }
            
            Alamofire.request(urlS, method: .).responseImage { response in
                guard let image = response.result.value else {
                    // Handle error
                    DispatchQueue.main.async {
                        fail()
                    }
                    return
                }
                // Do stuff with your image
                DispatchQueue.main.async {
                    self.image = image
                    success()
                }
            }
        }
    }
    
}
