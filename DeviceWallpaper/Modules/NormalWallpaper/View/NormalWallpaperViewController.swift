//
//  NormalWallpaperViewController.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/13.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit

class NormalWallpaperViewController: UIViewController {
    var presenter: NormalWallpaperPresentation!
    var barHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            navigationController?.setNavigationBarHidden(barHidden, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didClickActionButton))
        presenter.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(tap)
    }

    @objc private func didClickActionButton(_ sender: Any?) {
        presenter.didTapActionButton()
    }

    @objc private func tapGesture(_ sender: UITapGestureRecognizer) {
        barHidden = !barHidden
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }

    override var prefersStatusBarHidden: Bool {
        return barHidden
    }
}

extension NormalWallpaperViewController: NormalWallpaperView {
    func showSimple(deviceModel: DeviceModel) {
        let simple = SimpleView(with: deviceModel)
        navigationItem.title = WallpapersType.simple.title
        view = simple
    }

    func showNormal(deviceModel: DeviceModel) {
        let normal = NormalView(with: deviceModel)
        navigationItem.title = WallpapersType.normal.title
        view = normal
    }

    func toUIImage() -> UIImage {
        return view.snapshot()
    }
}
