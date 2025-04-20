\ProvidesClass{classes/report}[2023/02/20 report]

% (u)pLaTeX非互換パッケージに対して互換させるパッチを読み込む命令
\RequirePackage{plautopatch}

\NeedsTeXFormat{LaTeX2e}

% 2カラム,A4,フォントサイズ11pt
\LoadClass[
    paper=a4,
    fontsize=10pt,
    disablejfam,
    head_space=30mm,
    foot_space=30mm,
    gutter=25mm,
    fore-edge=25mm,
    linegap=0.5zw,
    report]
    {jlreq}

\RequirePackage{tocloft} % 目次関連のパッケージ
\RequirePackage{fancyhdr}

% @を含むコマンドを修正するためのパッチ
\makeatletter
\def\@chapapp{第}  % 明示的に\@chapappを定義する
\makeatother

% 脚注に関する設定
\RequirePackage{chngcntr} % カウンターの依存関係を変更するパッケージ
% 脚注番号を章ごとにリセットしないで連番にする
\counterwithout{footnote}{chapter}
% 脚注を上付き文字で表示するための設定
\makeatletter
% 脚注番号を小さい上付き文字にする
\renewcommand\@makefnmark{\textsuperscript{\scriptsize\@thefnmark}}
% 脚注を右に寄せるため、インデントとマージンを調整
\renewcommand\@makefntext[1]{\noindent\hspace{2em}\makebox[0pt][r]{\textsuperscript{\scriptsize\@thefnmark}}\@setfontsize\scriptsize\@viipt{8}#1}
\makeatother
% 脚注を区切る線の設定
\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width 5cm
  \kern 2.6pt
}

% 表のキャプション名を「表」に変更
\renewcommand{\tablename}{表}
% 表番号から章番号を省いて連番にする
\counterwithout{table}{chapter}

% 目次関連の設定
\renewcommand{\contentsname}{\Large 目次} % 目次のタイトルを小さく

\AtBeginDocument{
  \setlength{\cftbeforetoctitleskip}{0pt} % 目次タイトル前の空白をなくす
  \setlength{\cftaftertoctitleskip}{0pt} % 目次タイトル後の空白を調整
  \renewcommand{\cftchapfont}{\sffamily\bfseries} % チャプターのタイトルをサンセリフ体太字に
  \renewcommand{\cftchappagefont}{\rmfamily\bfseries} % チャプターのページ番号はローマン体のまま
  \renewcommand{\cftsubsecpagefont}{\normalfont} % 目次のサブセクションのページ番号を通常フォントに
  \renewcommand{\cftsubsubsecpagefont}{\normalfont} % 目次のサブサブセクションのページ番号を通常フォントに
}

\RequirePackage{ifptex}
\RequirePackage{ifluatex}

\PassOptionsToPackage{hyphens}{url}
\RequirePackage{setspace} % 行間設定用パッケージ
\RequirePackage{here} % 好きな位置にfigなどを置くためのパッケージ
\RequirePackage{bm} % ベクトルを大文字で書くためのパッケージ
\RequirePackage[hyphens]{xurl} % URLを表示するためのパッケージ、ハイフンでの改行を許可
\urlstyle{same} % URLの表示形式を本文と同じにする
\RequirePackage{paralist} % インラインリストのパッケージ
\RequirePackage{amssymb, amsmath} % 高度な数式記述用パッケージ
\RequirePackage{mathtools} % 高度な数式記述用パッケージ
\RequirePackage{amsthm} % 定理環境を使用するためのパッケージ
\RequirePackage{newtxtext,newtxmath} % Times系フォントを使用するためのパッケージ
\RequirePackage{tabularray} % 高度な表組み用パッケージ
% \RequirePackage{minted} % ソースコード表示の用パッケージ
\RequirePackage{siunitx} % SI単位記法に準拠した形式で単位を書くためのパッケージ
\RequirePackage{subfiles} % 大規模な文章を分割して記述して、統合するためのパッケージ
\RequirePackage{indentfirst} % 最初の段落でインデントするためのパッケージ
\RequirePackage{framed} % 囲み付き文章を出すためのパッケージ
\RequirePackage{type1cm} % 文字の大きさを自由に変えるためのパッケージ

\ifluatex
    % LuaTeXを日本語で使うための設定
    \RequirePackage{luatexja}
    % 日本語フォントは原ノ味フォントを使用
    \RequirePackage{luatexja-fontspec}
    \RequirePackage[haranoaji,no-math,deluxe]{luatexja-preset}

    % 図表関連のパッケージを読み込む
    \RequirePackage{graphicx}

    % ハイパーリンクを設定
    \RequirePackage[unicode,hidelinks,pdfusetitle]{hyperref}
\else
    \ifuptex
        % upLaTeXのフォントを設定
        \RequirePackage[deluxe]{otf}
        \RequirePackage[haranoaji,noalphabet]{pxchfon}

        % Font shape JY2/hmc/b/n' undefined (Font) using JY2/hmc/bx/n' instead.
        \DeclareFontShape{JY2}{hmc}{b}{n}{<->ssub*hmc/bx/n}{}

        % LaTeX Font: Font shape `JT2/hmc/b/n' undefine(Font)	using `JT2/hmc/m/n' instead.
        \DeclareFontShape{JT2}{hmc}{b}{n}{<->ssub*hmc/m/n}{}

        % 図表関連のパッケージを読み込む
        \RequirePackage{color}
        \RequirePackage[dvipdfmx]{graphicx}

        % ハイパーリンクを設定
        \RequirePackage[dvipdfmx,unicode,hidelinks,pdfusetitle]{hyperref}

    \else
        % pTeXでコンパイルしようとする場合はエラーを出す
        \ClassError{repost}{This class file is for LuaLaTeX or upLaTeX only.}{Use LuaLaTeX or upLaTeX to compile this document.}
    \fi
\fi

\RequirePackage{enumitem} % 高機能番号付き箇条書きのパッケージ

% カスタムリストスタイルの定義
\newlist{myitemize}{itemize}{3}
\setlist[myitemize]{
  label={\textbullet},
  font={\bfseries},
  itemsep=0.7em,
  leftmargin=2em,
  labelsep=0.7em,
}

% 既存のitemize環境の設定もカスタマイズ
\setlist[itemize]{
  label={\textbullet}, % 太字の点を使用
  font={\bfseries}, % マーカーを太字にする
  itemsep=0.7em,
  leftmargin=2em, % 左マージンを設定
  labelsep=0.7em, % 点と文字の間のスペースを広げる
}

\RequirePackage{tabularx} % 表の幅を指定するためのパッケージ
\RequirePackage[bibstyle=bibliography,sorting=none,date=year,isbn=false,doi,giveninits,urldate=iso,seconds]{biblatex} % biblatexを使用するためのパッケージ
\addbibresource{references.bib}

\RequirePackage{tikz} % 図を描画するためのパッケージ

% \DeclareFieldFormat*{journaltitle}{\textit{#1}} % 日本語雑誌名を通常に、英語雑誌名を斜体に
% \DeclareFieldFormat*{title}{\textit{#1}}
% \DeclareFieldFormat[inproceedings]{booktitle}{\textit{#1}}
% \DeclareFieldFormat[book]{title}{\textit{#1}}

% キャプションとサブキャプションの設定
\RequirePackage{silence}
\WarningFilter{caption}{Unknown document class (or package)}
\RequirePackage{caption}
\RequirePackage{subcaption}
\captionsetup[figure]{labelsep=quad, labelformat=simple, name=Fig.}
\captionsetup[subfigure]{labelsep=quad, labelformat=simple, name=Fig.}
\renewcommand*{\thesubfigure}{(\alph{subfigure})}
\captionsetup[table]{labelsep=colon, labelformat=simple, name=表}

% 本文中のFigureとTableの表記統一のため，\Fig・\Tableを定義
% 引数としてlabelを受け取り，それを使ってFigureやTableを参照する
% \FigTableEqマクロの定義
\newcommand{\FigTableEq}[3][]{%
    \def\temp{#1}%
    \ifx\temp\empty
        {#2~\ref{#3}}%
    \else
        \textbf{#2~\ref{#3}}%
    \fi
}

% \Figマクロの定義
\newcommand{\Fig}[2][]{%
    \FigTableEq[#1]{Fig.}{#2}%
}

% \Figureマクロの定義
\newcommand{\Figure}[2][]{%
    \FigTableEq[#1]{Figure}{#2}%
}

% \Tableマクロの定義
\newcommand{\Table}[2][]{%
    \FigTableEq[#1]{表}{#2}%
}

% \Equationマクロの定義
\newcommand{\Eq}[2][]{%
    \FigTableEq[#1]{Eq.}{#2}%
}

% sectionのサイズを合わせる
\RenewBlockHeading{chapter}{0}{lines=2,label_format={{\rmfamily\thechapter}},font={\sffamily\bfseries\Large},after_label_space=1zw,second_heading_text_indent={-1zw,1zw},subtitle_font={\sffamily\Large}}
\RenewBlockHeading{section}{1}{font=\normalsize,after_label_space=1zw}
\RenewBlockHeading{subsection}{2}{font=\normalsize,after_label_space=1zw}
\RenewBlockHeading{subsubsection}{3}{font=\normalsize,after_label_space=1zw}

% セクション類の空白の設定
\ModifyHeading{chapter}{before_space=15pt, after_space=13pt}
\ModifyHeading{section}{before_space=15pt, after_space=15pt}
\ModifyHeading{subsection}{before_space=20pt, after_space=20pt}
\ModifyHeading{subsubsection}{before_space=15pt, after_space=15pt}

% セクションが連続する際の行取りを設定
\SetBlockHeadingSpaces{
    {_chapter{*},_section{before_space=0pt, after_space=15pt}},
    {_section{*},_subsection{before_space=5pt, after_space=15pt}}
    {_subsection{*},_subsubsection{before_space=5pt, after_space=15pt}}
}

\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}

% 円で囲むコマンドの定義 (文字全体を囲む)
\newcommand{\circletext}[1]{%
    \tikz[baseline=(char.base)]{
        \node[shape=circle,draw,inner sep=0.5pt] (char) {#1};
    }%
}

% 角丸の長方形で囲むコマンドの定義
\newcommand{\roundedbox}[1]{%
  \tikz[baseline=(box.base)]{
    \node[draw,rounded corners=3pt,inner sep=3pt] (box) {#1};
  }%
}

% descriptionリスト環境の設定 - すべての項目にラベルと説明文の間のスペースを設定
\setlist[description]{
  itemsep=0.7em,
  labelsep=0.5em,
}
