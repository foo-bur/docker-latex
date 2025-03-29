# ファイル名: Dockerfile
FROM ubuntu:20.04

# 非対話モード設定
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # ---------------------------------------------------
    # ビルドに必要かもしれないもの
    build-essential \
    # ---------------------------------------------------
    # TeX Live本体 + よく使うパッケージ
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-luatex \
    texlive-xetex \
    texlive-science \
    # ---------------------------------------------------
    # 多言語対応 (日本語やCJK等)
    texlive-lang-cjk \
    texlive-lang-japanese \
    texlive-lang-english \
    texlive-lang-european \
    # ---------------------------------------------------
    # latexmk (自動コンパイルに便利)
    latexmk \
    # ---------------------------------------------------
    # フォント（Notoフォントなど、日本語/多言語表示用）
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    # ---------------------------------------------------
    # 画像処理やPDF関連ツール (必要に応じて)
    ghostscript \
    poppler-utils \
    # ---------------------------------------------------
    # Python3 が必要なスクリプト等もあるなら
    python3 \
    python3-pip \
    # ---------------------------------------------------
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを /work に設定
WORKDIR /work
