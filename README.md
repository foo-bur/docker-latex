# Docker + TeXShop + pLaTeX 環境構築手順

本ドキュメントでは、**macOS 上で TeXShop を使いながら Docker コンテナ内の pLaTeX 環境**でビルドする流れを説明します。  
ローカルに大量の LaTeX パッケージをインストールせずに済むため、環境構築を簡単に保ちつつ日本語 LaTeX を扱うことができます。

## 1. Docker Desktop のインストールと起動

1. **[Docker Desktop 公式サイト](https://www.docker.com/products/docker-desktop/)** からインストーラをダウンロード  
   - Intel Mac / Apple Silicon Mac に対応した版を選択してください。
2. インストーラを起動し、画面の手順に沿ってセットアップします。
3. Docker Desktop を起動し、**ログイン時に自動起動**するように設定すると便利です。

> **注意**: 初回起動には少し時間がかかります。ビルド実行前に **Docker Desktop が「Ready」** になっていることを確認してください。

## 2. Docker イメージの用意

GitHub リポジトリにある **Dockerfile** を使って、pLaTeX や latexmk がインストールされたイメージを作成します。

1. Dockerfile を任意のフォルダに置き、ターミナルでそのフォルダへ移動します。  
2. 以下のコマンドでイメージをビルドします。

~~~bash
docker build -t my-latex .
~~~

- `-t my-latex` : 完成したイメージ名を `my-latex` とする  
- `.` : カレントディレクトリの Dockerfile を使用  

ビルドが完了したら、`docker images` などで **`my-latex`** ができていることを確認してください。

## 3. TeXShop 用 `.engine` ファイルの設置

macOS 上の TeXShop は、**`~/Library/TeXShop/Engines`** ディレクトリに配置されている `.engine` ファイルを読み込みます。

1. GitHub リポジトリにある **`DockerLatexmk.engine`** を取得  
2. `~/Library/TeXShop/Engines` フォルダにコピーします
3. ターミナルで実行権限を付与:

~~~bash
chmod +x ~/Library/TeXShop/Engines/DockerLatexmk.engine
~~~

4. TeXShop を再起動すると、「Typeset」メニューに **`DockerLatexmk`** が表示されます。

## 4. 使い方

1. **TeXShop** で `.tex` ファイルを開きます（まだ保存していない場合は `.tex` 拡張子で保存してください）。  
2. メインウィンドウの「Typeset」ボタン横プルダウンで **`DockerLatexmk`** を選択  
3. ⌘T（または「Typeset」ボタン）を押す  
4. **Docker Desktop** が起動中であれば、コンテナ上でビルドが走り、**同じフォルダに PDF** が生成されます。

## 5. まとめ

1. **Docker Desktop** をインストール・起動する  
2. **Dockerfile** をビルドし、`my-latex` イメージを作成（例: `docker build -t my-latex .`）  
3. **TeXShop に `.engine` ファイル** (`DockerLatexmk.engine`) を配置 & 実行権限付与  
4. TeXShop の「Typeset」メニューで **`DockerLatexmk`** を選択 → ビルド実行  
5. **Docker コンテナ内**の pLaTeX + dvipdfmx で PDF が生成され、TeXShop でプレビューできます

これで macOS 上での TeXShop GUI と Docker 内の LaTeX 環境が連携し、ローカル環境をほとんど汚さずに日本語文書をビルドできます。
