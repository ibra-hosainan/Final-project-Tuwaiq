

import UIKit
import Lottie

class LunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
configureAnimation()
    }
    func configureAnimation() {
          let animation = Animation.named("4887-book")
          let animationView = AnimationView(animation:animation)
          animationView.contentMode = .scaleAspectFill
          animationView.frame = CGRect(x: 0, y: 70, width: 600, height: 600)
          animationView.center = view.center
          view.addSubview(animationView)
          animationView.play()
          animationView.loopMode = .loop
          animationView.animationSpeed = 1
          DispatchQueue.main.asyncAfter(deadline: .now()+3, execute:{
              self.performSegue(withIdentifier: "move", sender: self)
          })
      }


}
