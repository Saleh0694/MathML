% mathbook.cls
% Author: Y. Saleh
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathbook}[2024/02/27 Math Book Class]

\LoadClass{book}
% Reset section counter at the start of each chapter
\let\oldchapter\chapter
\renewcommand{\chapter}{\setcounter{section}{0}\oldchapter}

% adjust the geometry
\usepackage{geometry}
\geometry{
    a4paper,
    left=3cm,
    right=3cm,
    top=2cm,
    bottom=2cm
}


\RequirePackage{amsmath} % For advanced mathematical typesetting
\RequirePackage{amsthm} % For theorem environments
\RequirePackage{amsfonts} % For additional mathematical fonts
\RequirePackage{amssymb} % For additional mathematical symbols
\RequirePackage{xcolor}
\RequirePackage{hyperref} % For hyperlinks
\hypersetup{
    colorlinks=true,
    linkcolor=blue!60!green, % Dark blue color for internal links
    urlcolor=blue!60!green, % Dark blue color for URLs
    citecolor=blue!60!green, % Dark blue color for citations
}
%\setcounter{chapter}{1}
\renewcommand\thechapter{\Roman{chapter}} % Use Roman numerals for chapter numbers
\makeatletter
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \refstepcounter{chapter} % Increment the chapter counter
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      {\color{blue!60!green}\thechapter}~{\color{blue!60!green}#1}\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\makeatother
% Library 
\usepackage[backend=bibtex,maxbibnames=99,firstinits=true,style=numeric-comp,url=false,sorting=none]{biblatex}
% Use 
\renewbibmacro{in:}{}
\renewcommand*{\newunitpunct}{\addcomma\space}
\DeclareFieldFormat{pages}{#1}


% Remove the some fields for all other types of entries
 \AtEveryBibitem{\ifentrytype{}{}{\clearfield{month}}}
 \AtEveryBibitem{\ifentrytype{}{}{\clearfield{isbn}}}
 \AtEveryBibitem{\ifentrytype{}{}{\clearfield{issn}}}
 \AtEveryBibitem{\clearfield{address}}
 \AtEveryBibitem{\ifentrytype{article}{}{\clearfield{publisher}}}
 


 % % Redefine the bibmacro for volume+number+eid for articles only
\renewbibmacro*{volume+number+eid}{%
   \ifentrytype{article}{%
 	\textbf{\printfield{volume}}%
    \iffieldundef{eid}{}{\addcomma\printfield{eid}}%
      }
 }

\ExecuteBibliographyOptions{doi=false}
\DeclareFieldFormat{doilink}{%
\iffieldundef{doi}{#1}%
{\href{http://dx.doi.org/\thefield{doi}}{#1}}}

\DeclareBibliographyDriver{article}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\labelnamepunct}\newblock
  \usebibmacro{title}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{bytranslator+others}%
  \newunit\newblock
  \printfield{version}%
  \newunit\newblock
  \usebibmacro{in:}%
  \printtext[doilink]{%
  \usebibmacro{journal+issuetitle}%
  \newunit
  \usebibmacro{byeditor+others}%
  \newunit
  \usebibmacro{note+pages}%
  }%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{issn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \usebibmacro{finentry}}


 % Define a new format for the howpublished field that includes the URL
 \DeclareFieldFormat[misc]{howpublished}{%
  \iffieldundef{url}{#1}{\href{\thefield{url}}{#1}}%
}

  % define environments for theorems, lemmas, examples, etc. 
\newcommand{\definitionautorefname}{Definition}

\newtheorem{example}{Example}[chapter] % 

  
  \usepackage{mdframed}
  \newenvironment{boxedexample}{%
  \refstepcounter{example}
  \label{example:\theexample} % Add label with custom prefix
  \begin{mdframed}[linewidth=1pt,linecolor=black,backgroundcolor=gray!10,roundcorner=5pt]
    \textbf{Example \theexample.}
}{%
  \end{mdframed}
  }
% Modify autoref name for the example prefix
\providecommand*{\exampleautorefname}{Example}

  \newenvironment{boxedrmk}{%
  \refstepcounter{rmk}
  \begin{mdframed}[linewidth=1pt,linecolor=black,backgroundcolor=gray!10,roundcorner=5pt]
    \textbf{Remark \thermk.}
}{%
  \end{mdframed}
  }



  % Define a command to refer to problems in the Lab. 
\usepackage{tikz}
\usepackage{fontawesome5}
% Define custom command
\newcommand{\complementary}[1]{%
    \faHandPointRight \ \textcolor{green!50!black} {#1}%
}


\RequirePackage{graphicx} % Required to include images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images