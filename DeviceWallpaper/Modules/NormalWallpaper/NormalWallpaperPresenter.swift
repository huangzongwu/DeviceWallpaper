//
//  NormalWallpaperPresenter.swift
//  DeviceWallpaper
//
//  Created by Kensuke Hoshikawa on 2017/04/13.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

final class NormalWallpaperPresenter: NormalWallpaperPresentation {
    weak var view: NormalWallpaperView?
    var interactor: NormalWallpaperUseCase!
    var router: NormalWallpaperWireframe!

    func viewDidLoad() {
        interactor.retrieveDeviceModel()
    }

    func didTapActionButton() {
        router.presentActions { [weak self] _ in
            if let view = self?.view {
                self?.interactor.save(image: view.toUIImage())
            }
        }
    }
}

extension NormalWallpaperPresenter: NormalWallpaperInteractorOutput {
    func didRetrieve(_ deviceModel: DeviceModel) {
        view?.showSimple(deviceModel: deviceModel)
    }

    func notAuthorizedPhotoLibrary() {
        router.presentAuthorizationDialog()

    }

    func didSaveImage() {
        router.presentSavedSuccessDialog()
    }

    func didSaveImageFail(with message: String) {
        router.presentSavedFailureDialog(with: message)
    }
}
