//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if canImport(UIKit) && (os(iOS) || os(tvOS))

import UIKit

extension UIWindow {
  /// **Mechanica**
  ///
  /// Returns the topmost UIViewController.
  public var topMostViewController: UIViewController? {
    guard let topMostViewController = rootViewController else { return nil }

    func visibleViewController(from viewController: UIViewController?) -> UIViewController? {
      if let tabBarController = (viewController as? UITabBarController)?.selectedViewController {
        return visibleViewController(from: tabBarController)
      } else if let navigationController = (viewController as? UINavigationController)?.visibleViewController {
        return visibleViewController(from: navigationController)
      } else if let presentingViewController = viewController?.presentedViewController {
        return visibleViewController(from: presentingViewController)
      }
      return viewController
    }

    return visibleViewController(from: topMostViewController)
  }
}

#endif
