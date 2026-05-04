//
//  toggleLaunchAtStartup.swift
//  ⌘英かな
//
//  MIT License
//  Copyright (c) 2016 iMasanari
//

// ログイン項目に追加、またはそこから削除するための関数

import Cocoa
import ServiceManagement

enum LaunchAtStartupError: Error {
    case permissionDenied
    case unavailable
    case unknown
}

@discardableResult
func setLaunchAtStartup(_ enabled: Bool) -> Result<Void, LaunchAtStartupError> {
    let appBundleIdentifier = "io.github.imasanari.cmd-eikana-helper"

    if #available(macOS 13.0, *) {
        do {
            if enabled {
                try SMAppService.loginItem(identifier: appBundleIdentifier).register()
                print("Successfully registered login item.")
            } else {
                try SMAppService.loginItem(identifier: appBundleIdentifier).unregister()
                print("Successfully unregistered login item.")
            }
            return .success(())
        } catch let error as NSError {
            print("Failed to update login item: \(error)")
            if error.domain == SMAppService.errorDomain,
               error.code == SMAppService.Error.Code.notAuthorized.rawValue {
                return .failure(.permissionDenied)
            }
            return .failure(.unknown)
        }
    }

    // macOS 12 以前は従来 API へフォールバック
    if SMLoginItemSetEnabled(appBundleIdentifier as CFString, enabled) {
        if enabled {
            print("Successfully add login item.")
        } else {
            print("Successfully remove login item.")
        }
        return .success(())
    }

    print("Failed to add login item.")
    return .failure(.unavailable)
}
