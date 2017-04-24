//
//  WallpaperViewController.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/13.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import UIKit

final class WallpaperViewController: UIViewController {
    let presenter: WallpaperPresentation
    var barHidden: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
            navigationController?.setNavigationBarHidden(barHidden, animated: true)
        }
    }

    init(presenter: WallpaperPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

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

extension WallpaperViewController: WallpaperView {
    func showSimple(deviceModel: DeviceModel, colorTheme: ColorTheme) {
        let simple = SimpleView(with: deviceModel, colorTheme: colorTheme)
        navigationItem.title = WallpapersType.simple(.white).title
        view = simple
    }

    func showNormal(deviceModel: DeviceModel, colorTheme: ColorTheme) {
        let normal = NormalView(with: deviceModel, colorTheme: colorTheme)
        navigationItem.title = WallpapersType.normal(.white).title
        view = normal
    }

    func toUIImage() -> UIImage {
        return view.snapshot()
    }
}
