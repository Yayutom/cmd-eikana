# Eikana (⌘英かな)
This application switches alphanumeric / kana when pushing left and right command keys.
It can also be used as a key remapping application that works even with macOS Sierra by fiddling with settings in the preferences window.

## Download
Download latest release at https://ei-kana.appspot.com

## How to use (at first launch)
⌘ Open the .app. Since it is unsigned, please open it by right clicking and choosing "Open".
The app will display a confirmation dialog for accessibility functions, click on "Open" System Preferences ". Please click on the key in the lower left to unlock and mark ⌘ (Eikana) app as checked.

## How to Quit
Open the "⌘" icon in the status bar at the top right and select "Quit".

## How to uninstall

⌘ Drag app to the trash
Also, the configuration file is located at ~ / Library / Preferences / io.github.imasanari.cmd - eikana.plist. If you want to erase cleanly please also put this in the garbage can.

## Tested for compatibility with
- OS X El Capitan 10.11.5 (未確認)
- Mac OS Sierra 10.12 (未確認)
- macOS Big Sur 11.1 (Apple M1)

## License
MIT License

## Build settings policy (Xcode)
- The project file (`⌘英かな.xcodeproj/project.pbxproj`) is updated to current recommended-setting metadata (`LastUpgradeCheck`).
- `MACOSX_DEPLOYMENT_TARGET` is unified to `10.12` for project / app target / helper target to avoid per-target drift in CI.
- Legacy explicit signing identity (`CODE_SIGN_IDENTITY = "-"`) is removed; each target now uses:
  - `CODE_SIGN_STYLE = Automatic`
  - `DEVELOPMENT_TEAM = ""` (set your Team ID in Xcode or via xcconfig/CI at build time)
- Verify effective settings locally or in CI with:
  - `xcodebuild -project "⌘英かな.xcodeproj" -scheme "⌘英かな" -configuration Debug -showBuildSettings`
  - `xcodebuild -project "⌘英かな.xcodeproj" -scheme "⌘英かな" -configuration Release -showBuildSettings`


# ⌘英かな

左右のコマンドキーを単体で押した時に英数/かなを切り替えるようにするアプリです。  
設定をいじることでmacOS Sierraでも動くキーリマップアプリとしても利用できます。  

## ダウンロード
https://ei-kana.appspot.com/  
ここからダウンロードしてください

## 使い方（初回起動時）

⌘英かな.appを起動させます。未署名ですので[右クリック操作](https://support.apple.com/ja-jp/HT202491)で開いてください。  
アクセシビリティ機能へのアクセスの確認ダイアログが表示されるので「"システム環境設定"を開く」をクリックします。
左下の鍵をクリックして解除し、⌘英かな.appにチェックを入れてください。

## 終了方法

右上のステータスバーにある「⌘」アイコンを開き、「Quit」を選びます。

## アンインストール方法

⌘英かな.appをゴミ箱に入れてください。  
また、設定ファイルが`~/Library/Preferences/io.github.imasanari.cmd-eikana.plist`にあります。
綺麗さっぱり消したいという場合はこちらもゴミ箱に入れてください。

## 動作確認

- OS X El Capitan 10.11.5 (未確認)
- mac OS Sierra 10.12 (未確認)
- macOS Big Sur 11.1 (Apple M1)

## ライセンス
MIT License

## ビルド設定方針（Xcode）
- `⌘英かな.xcodeproj/project.pbxproj` の `LastUpgradeCheck` は最新Xcode想定の値に更新しています。
- `MACOSX_DEPLOYMENT_TARGET` は、Project / アプリ本体 / helper のすべてで `10.12` に統一しています（CIでの差分揺れ防止）。
- 旧来の `CODE_SIGN_IDENTITY = "-"` は削除し、各ターゲットを以下に統一しています。
  - `CODE_SIGN_STYLE = Automatic`
  - `DEVELOPMENT_TEAM = ""`（配布時はXcodeまたはCI側でTeam IDを設定）
- 実効値の確認コマンド:
  - `xcodebuild -project "⌘英かな.xcodeproj" -scheme "⌘英かな" -configuration Debug -showBuildSettings`
  - `xcodebuild -project "⌘英かな.xcodeproj" -scheme "⌘英かな" -configuration Release -showBuildSettings`
