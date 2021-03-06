/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import SnapKit

extension QuizViewController {
  func setupConstraints() {
    updateProgress(to: 0)

//      lblTimer.snp.makeConstraints { make in
//          make.width.equalToSuperview().multipliedBy(0.45)      // Make the label’s width equal to the superview’s width, multiplied by 0.45 (i.e., 45% of the superview’s width).
//          make.height.equalTo(45)                               // Set the label’s height to a static 45.
//          make.top.equalTo(viewProgress.snp.bottom).offset(32)  // Constrain the top of the label to the bottom of the progress bar, offset by 32.
//          make.centerX.equalToSuperview()                       // Center the X axis to the superview’s X axis, making the label horizontally centered.
//          make.centerY.equalToSuperview()
//      }
    lblTimer.snp.makeConstraints { make in
        make.width.equalToSuperview().multipliedBy(0.45).labeled("timerWidth")
        make.height.equalTo(45).labeled("timerHeight")
        make.top.equalTo(viewProgress.snp.bottom).offset(32).labeled("timerTop")
        make.centerX.equalToSuperview().labeled("timerCenterX")
    }

      
      lblQuestion.snp.makeConstraints { make in
          make.top.equalTo(lblTimer.snp.bottom).offset(24)
//          make.leading.trailing.equalToSuperview().inset(16)
          make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            .inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))

      }
      
      
      lblMessage.snp.makeConstraints { make in
          make.edges.equalToSuperview()
      }
      
      svButtons.snp.makeConstraints { make in
          make.leading.trailing.equalTo(lblQuestion)
          make.top.equalTo(lblQuestion.snp.bottom).offset(16)
          make.height.equalTo(80)
      }
  }
  
    func updateProgress(to progress: Double) {
      viewProgress.snp.remakeConstraints { make in
        make.top.equalTo(view.safeAreaLayoutGuide)
        make.width.equalToSuperview().multipliedBy(progress)
        make.height.equalTo(32)
        make.leading.equalToSuperview()
      }
    }

}

// MARK: - Orientation Transition Handling
extension QuizViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        // Determine the current orientation of the device
        let isPortrait = UIDevice.current.orientation.isPortrait

        // Use updateConstraints(_:) and update the timer label’s height to 45 if it’s in portrait — otherwise, you set it to 65.
        lblTimer.snp.updateConstraints { make in
            make.height.equalTo(isPortrait ? 45 : 65)
        }

        // Finally, increase the font size accordingly depending on the orientation.
        lblTimer.font = UIFont.systemFont(ofSize: isPortrait ? 20 : 32, weight: .light)
    }
}
