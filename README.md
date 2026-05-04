# Eikana (⌘英かな)
This application switches alphanumeric / kana when pushing left and right command keys.
It can also be used as a key remapping application that works even with macOS Sierra by fiddling with settings in the preferences window.

## Download
Download latest release at https://ei-kana.appspot.com

## How to use (at first launch)
1. Open `⌘英かな.app` as usual (double-click).
2. This app is distributed with **Developer ID Application signature** and **Apple notarization**. If Gatekeeper shows a warning, click **Done** and then open from Finder again.
3. If macOS asks for Accessibility access, click **Open System Settings**.
4. In **System Settings → Privacy & Security → Accessibility**, enable `⌘英かな.app`.
   - If the toggle is locked, click the lock icon and authenticate first.

## Release flow (archive → sign → notarize → staple)
The current recommended macOS release process is:

1. **Archive**
   - Build release archive from Xcode (`Product` → `Archive`) or `xcodebuild archive`.
2. **Export signed app**
   - Use a `Developer ID Application` certificate when exporting.
3. **Package**
   - Create distributable artifact (`.dmg` or `.zip`) from the signed `.app`.
4. **Submit to notary service**
   - Run `xcrun notarytool submit <artifact> --wait`.
5. **Staple ticket**
   - For `.app`: `xcrun stapler staple "⌘英かな.app"`
   - For `.dmg`: `xcrun stapler staple <artifact>.dmg`
6. **Verify**
   - `spctl --assess --type execute --verbose "⌘英かな.app"`
   - `xcrun stapler validate "⌘英かな.app"` (or `.dmg`)

## How to Quit
Open the "⌘" icon in the status bar at the top right and select "Quit".

## How to uninstall

⌘ Drag app to the trash.
Also, the configuration file is located at `~/Library/Preferences/io.github.imasanari.cmd-eikana.plist`. If you want to erase cleanly please also move this file to the trash.

## Tested for compatibility with
- macOS Sequoia 15.5
- macOS Sonoma 14.7
- macOS Ventura 13.7

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

1. `⌘英かな.app`を通常どおり起動します（ダブルクリック）。
2. 本アプリは **Developer ID 署名** と **Notarization（公証）** 済みで配布する前提です。
   - Gatekeeperの警告が表示された場合は一度「完了」で閉じ、Finderから再度開いてください。
3. アクセシビリティ許可のダイアログが表示されたら「システム設定を開く」をクリックします。
4. **システム設定 → プライバシーとセキュリティ → アクセシビリティ** で `⌘英かな.app` をオンにします。
   - 変更できない場合は左下の鍵アイコンを解除してから設定してください。

## リリース作成フロー（archive → sign → notary submit → staple）

現行macOS向けの推奨手順です。

1. **Archive**
   - Xcode の `Product` → `Archive`（または `xcodebuild archive`）でアーカイブを作成。
2. **署名付きアプリを書き出し**
   - `Developer ID Application` 証明書で `.app` を書き出し。
3. **配布物を作成**
   - 署名済み `.app` から `.dmg` または `.zip` を作成。
4. **Notary service に提出**
   - `xcrun notarytool submit <artifact> --wait`
5. **Staple**
   - `.app` の場合: `xcrun stapler staple "⌘英かな.app"`
   - `.dmg` の場合: `xcrun stapler staple <artifact>.dmg`
6. **検証**
   - `spctl --assess --type execute --verbose "⌘英かな.app"`
   - `xcrun stapler validate "⌘英かな.app"`（または `.dmg`）

## 終了方法

右上のステータスバーにある「⌘」アイコンを開き、「Quit」を選びます。

## アンインストール方法

⌘英かな.appをゴミ箱に入れてください。  
また、設定ファイルが`~/Library/Preferences/io.github.imasanari.cmd-eikana.plist`にあります。
綺麗さっぱり消したいという場合はこちらもゴミ箱に入れてください。

## 動作確認（Tested for compatibility）

- macOS Sequoia 15.5
- macOS Sonoma 14.7
- macOS Ventura 13.7

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
