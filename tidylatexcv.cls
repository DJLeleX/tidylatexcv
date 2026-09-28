% ----------------------------------------------------------------------------
% tidylatexcv.cls
% An unofficial LaTeX class for writing Europass-style CVs and Cover Letters.
%
% Author:     DJLeleX <https://github.com/DJLeleX>
% Copyright:  (C) 2026 DJLeleX
% License:    GNU General Public License v3.0 (GPL-3.0) with Document Exception
% Repository: https://github.com/DJLeleX/tidylatexcv
% ----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tidylatexcv}[2026/09/28 v1.0.0 Tidy LaTeX CV class by DJLeleX]

% ============================================================
% 1. EARLY PACKAGES
% ============================================================
\RequirePackage{iftex}
\RequirePackage{etoolbox}

% ============================================================
% 2. CLASS OPTIONS
% ============================================================

% Debug mode
\newif\iftlcv@debug\tlcv@debugfalse
\DeclareOption{debug}{\tlcv@debugtrue}

% Europass logo
\newif\iftlcv@nologo\tlcv@nologofalse
\DeclareOption{nologo}{\tlcv@nologotrue}

% Page number on the footer
\newif\iftlcv@nototpages\tlcv@nototpagesfalse
\DeclareOption{nototpages}{\tlcv@nototpagestrue}

% Language (Default: english)
\newcommand{\tlcv@lang}{english}
\DeclareOption{english}{\renewcommand{\tlcv@lang}{english}}
\DeclareOption{italian}{\renewcommand{\tlcv@lang}{italian}}

% Color schemes (Default: default)
\newcommand{\tlcv@colorscheme}{default}
\DeclareOption{color-default}{\renewcommand{\tlcv@colorscheme}{default}}
\DeclareOption{color-blue}{\renewcommand{\tlcv@colorscheme}{blue}}
\DeclareOption{color-blueblack}{\renewcommand{\tlcv@colorscheme}{blueblack}}
\DeclareOption{color-green}{\renewcommand{\tlcv@colorscheme}{green}}
\DeclareOption{color-greenblack}{\renewcommand{\tlcv@colorscheme}{greenblack}}
\DeclareOption{color-violet}{\renewcommand{\tlcv@colorscheme}{violet}}
\DeclareOption{color-violetblack}{\renewcommand{\tlcv@colorscheme}{violetblack}}

% Pass remaining options to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[a4paper]{article}

% ============================================================
% 3. PACKAGES (Loaded after LoadClass)
% ============================================================
% Layout & Formatting
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{ragged2e}
\RequirePackage[expansion=false]{microtype}
\iftlcv@debug \RequirePackage{showframe} \fi

% Tables & Boxes
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{longtable}
\RequirePackage{tikz}
\RequirePackage[most]{tcolorbox}

% Graphics & Fonts
\RequirePackage{graphicx}
\RequirePackage{fontawesome5}
\RequirePackage[normalem]{ulem}

% Logic & Parsing
\RequirePackage{pgfkeys}
\RequirePackage[\tlcv@lang]{babel}

% Hyperref (Must be loaded last)
\RequirePackage{hyperref}

% ============================================================
% 4. FONT SETUP (Engine-aware)
% ============================================================
\ifPDFTeX
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{helvet}
    \renewcommand{\familydefault}{\sfdefault}
\else
    % XeLaTeX and LuaLaTeX
    \RequirePackage{fontspec}
    \IfFontExistsTF{Helvetica}{%
        \setmainfont{Helvetica}%
        \setsansfont{Helvetica}%
    }{%
        \setmainfont{TeX Gyre Heros}%
        \setsansfont{TeX Gyre Heros}%
    }
    \renewcommand{\familydefault}{\sfdefault}
\fi

% ============================================================
% 5. BUNDLED COLOR SCHEMES & LOCALIZATION
% ============================================================

% Color setters
\newcommand{\tlcvaccentcolor}[1]{\definecolor{tlcv@color@accent}{HTML}{#1}}
\newcommand{\tlcvtextcolor}[1]{\definecolor{tlcv@color@text}{HTML}{#1}}
\newcommand{\tlcvbordercolor}[1]{\definecolor{tlcv@color@border}{HTML}{#1}}
\newcommand{\tlcvtitlecolor}[1]{\definecolor{tlcv@color@title}{HTML}{#1}}
\newcommand{\tlcvinfocolor}[1]{\definecolor{tlcv@color@info}{HTML}{#1}}
\newcommand{\tlcvinfolinkcolor}[1]{\definecolor{tlcv@color@infolink}{HTML}{#1}}
\newcommand{\tlcvsectioncolor}[1]{\definecolor{tlcv@color@section}{HTML}{#1}}
\newcommand{\tlcvhighlightcolor}[1]{\definecolor{tlcv@color@highlight}{HTML}{#1}}
\newcommand{\tlcvlinkcolor}[1]{\definecolor{tlcv@color@link}{HTML}{#1}}
\newcommand{\tlcvtableitemcolor}[1]{\definecolor{tlcv@color@tableitem}{HTML}{#1}}
\newcommand{\tlcvtablesepcolor}[1]{\definecolor{tlcv@color@tablesep}{HTML}{#1}}
\newcommand{\tlcviconcolor}[1]{\definecolor{tlcv@color@icon}{HTML}{#1}}

% ------------------------------------------------------------
% 5.1 Color Scheme Palettes (Dynamic Dispatch)
% ------------------------------------------------------------

% Default Palette (Fallback)
\newcommand{\tlcv@palette@default}{%
    \tlcvaccentcolor{F5F5F5}\tlcvtextcolor{5A5959}\tlcvbordercolor{000000}%
    \tlcvtitlecolor{505050}\tlcviconcolor{000000}\tlcvinfocolor{000000}%
    \tlcvinfolinkcolor{005AA0}\tlcvsectioncolor{000000}\tlcvhighlightcolor{505050}%
    \tlcvlinkcolor{005AA0}\tlcvtableitemcolor{000000}\tlcvtablesepcolor{696969}%
}

% Violet
\newcommand{\tlcv@palette@violet}{%
    \tlcvaccentcolor{F7EDFF}\tlcvtextcolor{3E434B}\tlcvbordercolor{5E3873}%
    \tlcvtitlecolor{5E3873}\tlcviconcolor{5E3873}\tlcvinfocolor{5E3873}%
    \tlcvinfolinkcolor{004494}\tlcvsectioncolor{5E3873}\tlcvhighlightcolor{8E56AD}%
    \tlcvlinkcolor{004494}\tlcvtableitemcolor{5E3873}\tlcvtablesepcolor{876B95}%
}

% Violet & Black
\newcommand{\tlcv@palette@violetblack}{%
    \tlcvaccentcolor{F7EDFF}\tlcvtextcolor{000000}\tlcvbordercolor{5E3873}%
    \tlcvtitlecolor{000000}\tlcviconcolor{000000}\tlcvinfocolor{000000}%
    \tlcvinfolinkcolor{004494}\tlcvsectioncolor{5E3873}\tlcvhighlightcolor{000000}%
    \tlcvlinkcolor{004494}\tlcvtableitemcolor{000000}\tlcvtablesepcolor{876B95}%
}

% Green
\newcommand{\tlcv@palette@green}{%
    \tlcvaccentcolor{E5F7F2}\tlcvtextcolor{3E434B}\tlcvbordercolor{276351}%
    \tlcvtitlecolor{2E7A63}\tlcviconcolor{256451}\tlcvinfocolor{256451}%
    \tlcvinfolinkcolor{004494}\tlcvsectioncolor{256451}\tlcvhighlightcolor{318169}%
    \tlcvlinkcolor{004494}\tlcvtableitemcolor{256451}\tlcvtablesepcolor{8BA99F}%
}

% Green & Black
\newcommand{\tlcv@palette@greenblack}{%
    \tlcvaccentcolor{E5F7F2}\tlcvtextcolor{000000}\tlcvbordercolor{276351}%
    \tlcvtitlecolor{000000}\tlcviconcolor{000000}\tlcvinfocolor{000000}%
    \tlcvinfolinkcolor{004494}\tlcvsectioncolor{256451}\tlcvhighlightcolor{000000}%
    \tlcvlinkcolor{004494}\tlcvtableitemcolor{000000}\tlcvtablesepcolor{8BA99F}%
}

% Blue
\newcommand{\tlcv@palette@blue}{%
    \tlcvaccentcolor{D6F2FF}\tlcvtextcolor{36435C}\tlcvbordercolor{050F35}%
    \tlcvtitlecolor{0F2FA2}\tlcviconcolor{051136}\tlcvinfocolor{051136}%
    \tlcvinfolinkcolor{004593}\tlcvsectioncolor{050F35}\tlcvhighlightcolor{051136}%
    \tlcvlinkcolor{004593}\tlcvtableitemcolor{051136}\tlcvtablesepcolor{48506A}%
}

% Blue & Black
\newcommand{\tlcv@palette@blueblack}{%
    \tlcvaccentcolor{D6F2FF}\tlcvtextcolor{000000}\tlcvbordercolor{050F35}%
    \tlcvtitlecolor{000000}\tlcviconcolor{000000}\tlcvinfocolor{000000}%
    \tlcvinfolinkcolor{004593}\tlcvsectioncolor{050F35}\tlcvhighlightcolor{000000}%
    \tlcvlinkcolor{004593}\tlcvtableitemcolor{000000}\tlcvtablesepcolor{48506A}%
}

% Dispatcher: Executes \tlcv@palette@<scheme> if it exists, otherwise falls back to default
\newcommand{\tlcv@apply@colorscheme}{%
    \ifcsdef{tlcv@palette@\tlcv@colorscheme}%
        {\csname tlcv@palette@\tlcv@colorscheme\endcsname}%
        {\tlcv@palette@default}%
}
\tlcv@apply@colorscheme

\hypersetup{
    colorlinks=true,
    allcolors=tlcv@color@link
}

% ------------------------------------------------------------
% 5.2 Locales (English & Italian)
% ------------------------------------------------------------
\ifdefstring{\tlcv@lang}{italian}{%
    \def\tlcv@label@dob{Data di nascita}
    \def\tlcv@label@gender{Sesso}
    \def\tlcv@label@nationality{Nazionalit\`a}
    \def\tlcv@label@phone{Telefono}
    \def\tlcv@label@email{Indirizzo e-mail}
    \def\tlcv@label@website{Sito internet}
    \def\tlcv@label@address{Indirizzo}
    \def\tlcv@label@home{Abitazione}
    \def\tlcv@label@mobile{Cellulare}
    \def\tlcv@label@mothertongue{Lingua madre}
    \def\tlcv@label@understanding{Comprensione}
    \def\tlcv@label@speaking{Espressione orale}
    \def\tlcv@label@writing{Scrittura}
    \def\tlcv@label@listening{Ascolto}
    \def\tlcv@label@reading{Lettura}
    \def\tlcv@label@spokenproduction{Produzione orale}
    \def\tlcv@label@spokeninteraction{Interazione orale}
    \def\tlcv@label@cefrlevels{Livelli: A1 e A2: Livello elementare -- B1 e B2: Livello intermedio -- C1 e C2: Livello avanzato}
    \def\tlcv@label@drivinglicence{Patente di guida}
    \def\tlcv@label@date{Data}
    \def\tlcv@label@location{Luogo}
    \def\tlcv@label@sector{Settore}
    \def\tlcv@label@grade{Voto finale}
    \def\tlcv@label@eqf{Livello EQF}
    \def\tlcv@label@national{Livello nazionale}
    \def\tlcv@label@badge{Verifica credenziali}
    \def\tlcv@label@certificate{Certificato}
    \def\tlcv@label@page{Pagina}
}{%
    % English (Default)
    \def\tlcv@label@dob{Date of birth}
    \def\tlcv@label@gender{Gender}
    \def\tlcv@label@nationality{Nationality}
    \def\tlcv@label@phone{Phone}
    \def\tlcv@label@email{Email address}
    \def\tlcv@label@website{Website}
    \def\tlcv@label@address{Address}
    \def\tlcv@label@home{Home}
    \def\tlcv@label@mobile{Mobile}
    \def\tlcv@label@mothertongue{Mother tongue(s)}
    \def\tlcv@label@understanding{Understanding}
    \def\tlcv@label@speaking{Speaking}
    \def\tlcv@label@writing{Writing}
    \def\tlcv@label@listening{Listening}
    \def\tlcv@label@reading{Reading}
    \def\tlcv@label@spokenproduction{Spoken production}
    \def\tlcv@label@spokeninteraction{Spoken interaction}
    \def\tlcv@label@cefrlevels{Levels: A1 and A2: Basic user -- B1 and B2: Independent user -- C1 and C2: Proficient user}
    \def\tlcv@label@drivinglicence{Driving licence}
    \def\tlcv@label@date{Date}
    \def\tlcv@label@location{Location}
    \def\tlcv@label@sector{Sector}
    \def\tlcv@label@grade{Final grade}
    \def\tlcv@label@eqf{EQF level}
    \def\tlcv@label@national{National level}
    \def\tlcv@label@badge{Verify credential}
    \def\tlcv@label@certificate{Certificate}
    \def\tlcv@label@page{Page}
}

% ============================================================
% 6. PAGE GEOMETRY & GLOBAL SETTINGS
% ============================================================
\newlength{\tlcv@margin@top}
\newlength{\tlcv@margin@bottom}
\newlength{\tlcv@margin@left}
\newlength{\tlcv@margin@right}

\setlength{\tlcv@margin@top}{10mm}
\setlength{\tlcv@margin@bottom}{15mm}
\setlength{\tlcv@margin@left}{14mm}
\setlength{\tlcv@margin@right}{14mm}

\geometry{
    paper=a4paper,
    left=\tlcv@margin@left,
    right=\tlcv@margin@right,
    top=\tlcv@margin@top,
    bottom=\tlcv@margin@bottom,
    footskip=8mm,
    includefoot=false,
    nohead,
    nomarginpar
}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\renewcommand{\normalcolor}{\color{tlcv@color@text}}

% ============================================================
% 7. HEADER & FOOTER (GDPR, Logo, Pagination)
% ============================================================
\newif\iftlcv@showgdpr\tlcv@showgdprfalse
\newcommand{\tlcv@gdprtext}{}

\NewDocumentCommand{\tlcvgdpr}{O{}}{%
    \tlcv@showgdprtrue%
    \ifstrempty{#1}{%
        \ifdefstring{\tlcv@lang}{italian}{%
            \renewcommand{\tlcv@gdprtext}{Autorizzo il trattamento dei dati personali contenuti nel mio curriculum vitae in base all'art. 13 del D. Lgs. 196/2003 e all'art. 13 del Regolamento UE 2016/679.}%
        }{%
            \renewcommand{\tlcv@gdprtext}{I hereby authorize the processing of the personal data contained in this CV in compliance with the European Regulation (EU) 2016/679.}%
        }%
    }{%
        \renewcommand{\tlcv@gdprtext}{#1}%
    }%
}

\fancypagestyle{tlcv@footer}{%
    \fancyhf{}%
    \renewcommand{\headrulewidth}{0pt}%
    % Left Footer: GDPR Notice
    \fancyfoot[L]{%
        \iftlcv@showgdpr%
            \parbox[b]{0.72\textwidth}{%
                \color{tlcv@color@text}\fontsize{7pt}{8pt}\selectfont\tlcv@gdprtext%
            }%
        \fi%
    }%
    % Right Footer: Logo and Page Number
    \fancyfoot[R]{%
        \iftlcv@nologo\else%
            \IfFileExists{europass_logo.pdf}{%
                \raisebox{-0.20\height}{%
                    \includegraphics[height=4mm]{europass_logo.pdf}%
                }%
                \hspace{0.5em}%
            }{}%
        \fi%
        \iftlcv@nototpages\else%
            {%
                \color{tlcv@color@text}%
                \ifcsdef{tlcv@label@page}{\csname tlcv@label@page\endcsname}{Page}~\thepage/\pageref*{LastPage}%
            }%
            \normalcolor%
        \fi%
    }%
}
\AtBeginDocument{\pagestyle{tlcv@footer}}

% ============================================================
% 8. HELPER FUNCTIONS
% ============================================================
\newcommand{\tlcv@sep}{\allowbreak\space\textbar\space\allowbreak}

\NewDocumentCommand{\tlcv@url@email}{O{tlcv@color@infolink} m}{%
    \begingroup%
    \hypersetup{allcolors=#1}%
    \protected@edef\tlcv@tempa{#2}%
    \edef\tlcv@tempb{\detokenize\expandafter{\tlcv@tempa}}%
    \edef\tlcv@tempc{\endgroup\noexpand\href{mailto:\tlcv@tempa}{\noexpand\uline{\tlcv@tempb}}}% 
    \tlcv@tempc%
}

\NewDocumentCommand{\tlcv@url@web}{O{tlcv@color@link} m}{%
    \begingroup%
    \hypersetup{allcolors=#1}%
    \protected@edef\tlcv@tempa{#2}%
    \edef\tlcv@tempb{\detokenize\expandafter{\tlcv@tempa}}%
    \in@{://}{\tlcv@tempa}%
    \ifin@%
        \edef\tlcv@tempc{\endgroup\noexpand\href{\tlcv@tempa}{\noexpand\uline{\tlcv@tempb}}}%
    \else%
        \edef\tlcv@tempc{\endgroup\noexpand\href{https://\tlcv@tempa}{\noexpand\uline{\tlcv@tempb}}}%
    \fi%
    \tlcv@tempc%
}

\NewDocumentCommand{\tlcv@url}{O{tlcv@color@link} m}{%
    \tlcv@url@web[#1]{#2}%
}

% ============================================================
% 9. PERSONAL INFO VARIABLES & SETTERS
% ============================================================
\newlength{\tlcv@photosize}
\setlength{\tlcv@photosize}{3.5cm} 

\newif\iftlcv@photo\tlcv@photofalse
\newcommand{\tlcv@photo}{}
\newcommand{\tlcvphoto}[1]{\tlcv@phototrue\renewcommand{\tlcv@photo}{#1}}

\newcommand{\tlcv@info@name}{}
\newcommand{\tlcv@info@dob}{}
\newcommand{\tlcv@info@gender}{}
\newcommand{\tlcv@info@nationalitylist}{}
\newcommand{\tlcv@info@addresslist}{}
\newcommand{\tlcv@info@phonelist}{}
\newcommand{\tlcv@info@emaillist}{}
\newcommand{\tlcv@info@websitelist}{}
\newcommand{\tlcv@info@sociallist}{}
\newcommand{\tlcv@info@imlist}{}

\newcommand{\tlcvname}[1]{\renewcommand{\tlcv@info@name}{#1}}
\newcommand{\tlcvdateofbirth}[1]{\renewcommand{\tlcv@info@dob}{#1}}
\newcommand{\tlcvgender}[1]{\renewcommand{\tlcv@info@gender}{#1}}

\newcommand{\tlcvnationality}[1]{%
    \ifdefempty{\tlcv@info@nationalitylist}
        {\renewcommand{\tlcv@info@nationalitylist}{#1}}
        {\gappto{\tlcv@info@nationalitylist}{, #1}}%
}

\newcommand{\tlcvaddress}[2][\faHome]{%
    \ifdefempty{\tlcv@info@addresslist}
        {\renewcommand{\tlcv@info@addresslist}{{\color{tlcv@color@icon}#1}\ #2}}
        {\gappto{\tlcv@info@addresslist}{\tlcv@sep {\color{tlcv@color@icon}#1}\ #2}}%
}

\newcommand{\tlcvphone}[2][\faMobile*]{%
    \ifdefempty{\tlcv@info@phonelist}
        {\renewcommand{\tlcv@info@phonelist}{{\color{tlcv@color@icon}#1}\ #2}}
        {\gappto{\tlcv@info@phonelist}{\tlcv@sep {\color{tlcv@color@icon}#1}\ #2}}%
}

\newcommand{\tlcvemail}[2][\faEnvelope]{%
    \ifdefempty{\tlcv@info@emaillist}
        {\renewcommand{\tlcv@info@emaillist}{{\color{tlcv@color@icon}#1}\ \tlcv@url@email{#2}}}
        {\gappto{\tlcv@info@emaillist}{\tlcv@sep {\color{tlcv@color@icon}#1}\ \tlcv@url@email{#2}}}%
}

\newcommand{\tlcvwebsite}[2][\faGlobe]{%
    \ifdefempty{\tlcv@info@websitelist}
        {\renewcommand{\tlcv@info@websitelist}{{\color{tlcv@color@icon}#1}\ \tlcv@url@web[tlcv@color@infolink]{#2}}}
        {\gappto{\tlcv@info@websitelist}{\tlcv@sep {\color{tlcv@color@icon}#1}\ \tlcv@url@web[tlcv@color@infolink]{#2}}}%
}

\newcommand{\tlcvsocial}[2][\faShareAlt]{%
    \ifdefempty{\tlcv@info@sociallist}
        {\renewcommand{\tlcv@info@sociallist}{{\color{tlcv@color@icon}#1}\ \tlcv@url@web[tlcv@color@infolink]{#2}}}
        {\gappto{\tlcv@info@sociallist}{\tlcv@sep {\color{tlcv@color@icon}#1}\ \tlcv@url@web[tlcv@color@infolink]{#2}}}%
}

% Helper that displays the icon and conditionally creates links
\newcommand{\tlcv@im@format}[2]{%
    {\color{tlcv@color@icon}#1}\ %
    \edef\tlcv@tmp@icon{\detokenize{#1}}%
    \edef\tlcv@tmp@tg{\detokenize{\faTelegram}}%
    \edef\tlcv@tmp@wa{\detokenize{\faWhatsapp}}%
    \ifx\tlcv@tmp@icon\tlcv@tmp@tg%
        \href{https://t.me/#2}{\uline{\detokenize{#2}}}%
    \else\ifx\tlcv@tmp@icon\tlcv@tmp@wa%
        \href{https://wa.me/#2}{\uline{\detokenize{#2}}}%
    \else%
        \detokenize{#2}%
    \fi\fi%
}

% Main setter command
\newcommand{\tlcvim}[2][\faCommentDots]{%
    \ifdefempty{\tlcv@info@imlist}%
        {\renewcommand{\tlcv@info@imlist}{\tlcv@im@format{#1}{#2}}}%
        {\gappto{\tlcv@info@imlist}{\tlcv@sep \tlcv@im@format{#1}{#2}}}%
}

% ============================================================
% 10. PERSONAL INFO COMPILATION & DISPLAY
% ============================================================
\newcommand{\tlcv@personalinfolist}{}
\newcommand{\tlcv@makepersonalinfolist}{%
    % ROW 1: Birth | Gender | Nationality
    \def\tlcv@row@one{}
    \ifdefempty{\tlcv@info@dob}{}{\gappto{\tlcv@row@one}{\tlcv@label@dob:~\tlcv@info@dob}}
    \ifdefempty{\tlcv@info@gender}{}{%
        \ifdefempty{\tlcv@row@one}{}{\gappto{\tlcv@row@one}{\tlcv@sep}}%
        \gappto{\tlcv@row@one}{\tlcv@label@gender:~\tlcv@info@gender}%
    }
    \ifdefempty{\tlcv@info@nationalitylist}{}{%
        \ifdefempty{\tlcv@row@one}{}{\gappto{\tlcv@row@one}{\tlcv@sep}}%
        \gappto{\tlcv@row@one}{\tlcv@label@nationality:~\tlcv@info@nationalitylist}%
    }

    % ROW 2: Address
    \def\tlcv@row@address{}
    \ifdefempty{\tlcv@info@addresslist}{}{\gappto{\tlcv@row@address}{\tlcv@info@addresslist}}

    % ROW 3: Email | Website
    \def\tlcv@row@three{}
    \ifdefempty{\tlcv@info@emaillist}{}{\gappto{\tlcv@row@three}{\tlcv@info@emaillist}}
    \ifdefempty{\tlcv@info@websitelist}{}{%
        \ifdefempty{\tlcv@row@three}{}{\gappto{\tlcv@row@three}{\tlcv@sep}}%
        \gappto{\tlcv@row@three}{\tlcv@info@websitelist}%
    }

    % ROW 4: Phone | Socials | IM
    \def\tlcv@row@four{}
    \ifdefempty{\tlcv@info@phonelist}{}{\gappto{\tlcv@row@four}{\tlcv@info@phonelist}}
    \ifdefempty{\tlcv@info@sociallist}{}{%
        \ifdefempty{\tlcv@row@four}{}{\gappto{\tlcv@row@four}{\tlcv@sep}}%
        \gappto{\tlcv@row@four}{\tlcv@info@sociallist}%
    }
    \ifdefempty{\tlcv@info@imlist}{}{%
        \ifdefempty{\tlcv@row@four}{}{\gappto{\tlcv@row@four}{\tlcv@sep}}%
        \gappto{\tlcv@row@four}{\tlcv@info@imlist}%
    }

    % Final Stack
    \renewcommand{\tlcv@personalinfolist}{%
        \ifdefempty{\tlcv@row@one}{}{\tlcv@row@one}%
        \ifdefempty{\tlcv@row@address}{}{\par\vspace{2pt}\tlcv@row@address}%
        \ifdefempty{\tlcv@row@three}{}{\par\vspace{2pt}\tlcv@row@three}%
        \ifdefempty{\tlcv@row@four}{}{\par\vspace{2pt}\tlcv@row@four}%
    }
}

\newcommand{\tlcv@personalinfo@content}{%
    \ifdefempty{\tlcv@info@name}{}{%
        {%
            \color{tlcv@color@title}%
            \LARGE\textbf{\tlcv@info@name}\par\vspace{8pt}%
        }\normalcolor%
    }%
    {%
        \color{tlcv@color@info}%
        \tlcv@personalinfolist%
    }\normalcolor%
}

\newcommand{\tlcv@photo@content}{%
    \begin{tikzpicture}%
        % 1. Create a circular clipping mask
        \clip (0,0) circle (0.5\tlcv@photosize);%
        % 2. Center the image without squishing it:
        % Setting width=\tlcv@photosize with keepaspectratio ensures it fits the circle.
        \node [anchor=center, inner sep=0pt] at (0,0) {%
            \includegraphics[width=\tlcv@photosize, keepaspectratio]{\tlcv@photo}%
        };%
        % 3. Draw border rings
        \draw[color=tlcv@color@accent, line width=1pt] (0,0) circle (\dimexpr0.5\tlcv@photosize-1pt\relax);%
        \draw[color=tlcv@color@border, line width=2pt] (0,0) circle (0.5\tlcv@photosize);%
    \end{tikzpicture}%
}

% ------------------------------------------------------------
% Header Rendering
% ------------------------------------------------------------
\newsavebox{\tlcv@headerbox}
\newlength{\tlcv@header@height}
\newlength{\tlcv@header@contentwidth}
\newlength{\tlcv@header@contentheight}
\newlength{\tlcv@header@textheight}

\newcommand{\tlcv@header@content}{%
    % Compute widths
    \setlength{\tlcv@header@contentwidth}{\dimexpr\paperwidth-\tlcv@margin@left-\tlcv@margin@right\relax}%
    \iftlcv@photo%
        \addtolength{\tlcv@header@contentwidth}{-\tlcv@photosize}%
        \addtolength{\tlcv@header@contentwidth}{-0.8cm}%
    \fi%
    
    % Compute heights
    \savebox{\tlcv@headerbox}{%
        \parbox[t]{\tlcv@header@contentwidth}{%
            \RaggedRight\tlcv@personalinfo@content%
        }%
    }%
    \setlength{\tlcv@header@contentheight}{\dimexpr\ht\tlcv@headerbox+\dp\tlcv@headerbox\relax}%
    
    \iftlcv@photo%
        \setlength{\tlcv@header@height}{\dimexpr 1cm+\tlcv@photosize+0.5cm\relax}%
        \setlength{\tlcv@header@textheight}{\dimexpr 1.5cm+\tlcv@header@contentheight+0.5cm\relax}%
        \ifdim\tlcv@header@textheight>\tlcv@header@height%
            \setlength{\tlcv@header@height}{\tlcv@header@textheight}%
        \fi%
    \else%
        \setlength{\tlcv@header@height}{\dimexpr 1.5cm+\tlcv@header@contentheight+0.5cm\relax}%
    \fi%
    
    % Draw header
    \par\vspace*{\dimexpr\tlcv@header@height-\tlcv@margin@top-\baselineskip\relax}%
    \noindent\begin{tikzpicture}[remember picture, overlay, baseline=0pt]%
        \useasboundingbox (0,0);%
        \fill[tlcv@color@accent] ([yshift=-\tlcv@header@height] current page.north west) rectangle (current page.north east);%
        
        \iftlcv@photo%
            \node[anchor=north west] at ([xshift=\tlcv@margin@left, yshift=-\tlcv@margin@top] current page.north west) {\tlcv@photo@content};%
        \fi%
        
        \node[anchor=north west, inner sep=0pt, outer sep=0pt]
            at ([xshift=\dimexpr\tlcv@margin@left + \iftlcv@photo\tlcv@photosize+0.8cm\else 0pt\fi\relax, 
                yshift=-\tlcv@margin@top] current page.north west)
        {%
            \begin{minipage}{\tlcv@header@contentwidth}%
                \RaggedRight\tlcv@personalinfo@content%
            \end{minipage}%
        };%
    \end{tikzpicture}%
    \ignorespaces%
}

\newenvironment{tlcvinfo}{%
    \renewcommand{\tlcv@info@name}{}%
    \renewcommand{\tlcv@info@dob}{}%
    \renewcommand{\tlcv@info@gender}{}%
    \renewcommand{\tlcv@info@nationalitylist}{}%
    \renewcommand{\tlcv@info@addresslist}{}%
    \renewcommand{\tlcv@info@phonelist}{}%
    \renewcommand{\tlcv@info@emaillist}{}%
    \renewcommand{\tlcv@info@websitelist}{}%
    \renewcommand{\tlcv@info@sociallist}{}%
    \renewcommand{\tlcv@info@imlist}{}%
}{%
    \tlcv@makepersonalinfolist%
    \tlcv@header@content%
}

% ============================================================
% 11. SECTIONS & ENTRIES
% ============================================================
\newbool{tlcv@firstentry}

\newcommand{\tlcvsection}[1]{%
    \booltrue{tlcv@firstentry}%
    \par\vspace{12pt}\nopagebreak%
    \noindent{%
        {%
            \color{tlcv@color@section}%
            \footnotesize\MakeUppercase{\textbf{#1}}%
            \hspace{4pt}%
            \leaders\hbox{\raisebox{0.5ex}{\rule{1pt}{0.5pt}}}\hfill\kern0pt%
        }%
    }\par\nopagebreak\vspace{2pt}%
    \@afterheading%
    \normalcolor%
    \ignorespaces%
}

\newif\iftlcv@entry@dateicon
\newif\iftlcv@entry@locicon
\newif\iftlcv@entry@gradeicon
\newbool{tlcv@metafirst}

\pgfkeys{
    /tlcv/entry/.is family,
    /tlcv/entry/.cd,
    title/.store in=\tlcv@entry@title,
    organization/.store in=\tlcv@entry@org,
    date/.store in=\tlcv@entry@date,
    location/.store in=\tlcv@entry@location,
    description/.store in=\tlcv@entry@desc,
    link/.store in=\tlcv@entry@link,
    badge/.store in=\tlcv@entry@badge,
    finalgrade/.store in=\tlcv@entry@finalgrade,
    eqf/.store in=\tlcv@entry@eqf,
    national/.store in=\tlcv@entry@national,
    sector/.store in=\tlcv@entry@sector,
    dateicon/.is if=tlcv@entry@dateicon,
    locationicon/.is if=tlcv@entry@locicon,
    gradeicon/.is if=tlcv@entry@gradeicon
}

\NewDocumentCommand{\tlcventry}{s m}{%
    \ifbool{tlcv@firstentry}
        {\par\nopagebreak\vspace{6pt}\boolfalse{tlcv@firstentry}}
        {\par\nopagebreak\nointerlineskip\vspace{7pt}\noindent{\color{tlcv@color@tablesep!60}\rule{\linewidth}{0.2pt}}\par\vspace{8pt}}%

    % Reset
    \def\tlcv@entry@title{}\def\tlcv@entry@org{}\def\tlcv@entry@date{}%
    \def\tlcv@entry@location{}\def\tlcv@entry@desc{}\def\tlcv@entry@link{}%
    \def\tlcv@entry@badge{}\def\tlcv@entry@finalgrade{}%
    \def\tlcv@entry@eqf{}\def\tlcv@entry@national{}\def\tlcv@entry@sector{}%
    \tlcv@entry@dateicontrue \tlcv@entry@locicontrue \tlcv@entry@gradeicontrue
    
    \pgfkeys{/tlcv/entry/.cd,#2}%

    % ROW 1: Date | Loc | Sector | Badge
    \def\tlcv@tmp@metaA{}%
    \booltrue{tlcv@metafirst}%
    \def\tlcv@build@metaA##1{\ifbool{tlcv@metafirst}{\boolfalse{tlcv@metafirst}}{\gappto{\tlcv@tmp@metaA}{\ \tlcv@sep\ }}\gappto{\tlcv@tmp@metaA}{##1}}%

    \ifdefvoid{\tlcv@entry@date}{}{\tlcv@build@metaA{\iftlcv@entry@dateicon{\color{tlcv@color@icon}\faCalendar*}~\else\ifcsdef{tlcv@label@date}{\csname tlcv@label@date\endcsname:~}{}\fi\tlcv@entry@date}}%
    \ifdefvoid{\tlcv@entry@location}{}{\tlcv@build@metaA{\iftlcv@entry@locicon{\color{tlcv@color@icon}\faMapMarker*}~\else\ifcsdef{tlcv@label@location}{\csname tlcv@label@location\endcsname:~}{}\fi\tlcv@entry@location}}%
    \ifdefvoid{\tlcv@entry@sector}{}{\tlcv@build@metaA{\ifcsdef{tlcv@label@sector}{\csname tlcv@label@sector\endcsname:~}{}\tlcv@entry@sector}}%
    \ifdefvoid{\tlcv@entry@badge}{}{\tlcv@build@metaA{{\color{tlcv@color@icon}\faCertificate}~\href{\tlcv@entry@badge}{\uline{\tlcv@label@badge}}}}%

    % ROW 2: Grade | EQF | National
    \def\tlcv@tmp@metaB{}%
    \booltrue{tlcv@metafirst}%
    \def\tlcv@build@metaB##1{\ifbool{tlcv@metafirst}{\boolfalse{tlcv@metafirst}}{\gappto{\tlcv@tmp@metaB}{\ \tlcv@sep\ }}\gappto{\tlcv@tmp@metaB}{##1}}%

    \ifdefvoid{\tlcv@entry@finalgrade}{}{\tlcv@build@metaB{\iftlcv@entry@gradeicon{\color{tlcv@color@icon}\faGraduationCap}~\else\ifcsdef{tlcv@label@grade}{\csname tlcv@label@grade\endcsname:~}{}\fi\tlcv@entry@finalgrade}}%
    \ifdefvoid{\tlcv@entry@eqf}{}{\tlcv@build@metaB{\ifcsdef{tlcv@label@eqf}{\csname tlcv@label@eqf\endcsname~}{}\tlcv@entry@eqf}}%
    \ifdefvoid{\tlcv@entry@national}{}{\tlcv@build@metaB{\ifcsdef{tlcv@label@national}{\csname tlcv@label@national\endcsname:~}{}\tlcv@entry@national}}%

    % Render
    \noindent
    \ifdefvoid{\tlcv@entry@title}{}{{\color{tlcv@color@highlight}\large\textbf{\tlcv@entry@title}}}%
    \ifboolexpr{ test {\notblank{\tlcv@entry@org}} or test {\notblank{\tlcv@entry@link}} }{%
        \par\nopagebreak\vspace{1pt}%
        {\color{tlcv@color@text}\ifdefvoid{\tlcv@entry@org}{}{\tlcv@entry@org\ifdefvoid{\tlcv@entry@link}{}{\ \tlcv@sep\ }}\ifdefvoid{\tlcv@entry@link}{}{\tlcv@url{\tlcv@entry@link}}}%
    }{}%
    \ifdefvoid{\tlcv@tmp@metaA}{}{\par\nopagebreak\vspace{1pt}{\IfBooleanTF{#1}{\color{tlcv@color@highlight}}{\color{tlcv@color@text}}\footnotesize \tlcv@tmp@metaA}}%
    \ifdefvoid{\tlcv@tmp@metaB}{}{\par\nopagebreak\vspace{1pt}{\IfBooleanTF{#1}{\color{tlcv@color@highlight}}{\color{tlcv@color@text}}\footnotesize \tlcv@tmp@metaB}}%
    \ifdefvoid{\tlcv@entry@desc}{}{\par\vspace{3pt}{\normalcolor\IfBooleanTF{#1}{\small}{}\tlcv@entry@desc}}%
    \par\ignorespaces%
}

% ============================================================
% 12. LANGUAGE SKILLS
% ============================================================
\newcommand{\tlcv@mtlist}{}
\newcommand{\tlcv@langtablebody}{}
\newif\iftlcv@cefrlevels\tlcv@cefrlevelsfalse
\newcommand{\tlcvcefrlevels}{\tlcv@cefrlevelstrue}

\newif\iftlcv@langicons\tlcv@langiconsfalse
\newcommand{\tlcvlangicons}{\tlcv@langiconstrue}

\def\tlcv@lang@colA{0.22\linewidth}
\def\tlcv@lang@colB{0.13\linewidth}
\def\tlcv@lang@colC{0.13\linewidth}
\def\tlcv@lang@colD{0.13\linewidth}
\def\tlcv@lang@colE{0.13\linewidth}
\def\tlcv@lang@colF{0.15\linewidth}

\newcommand{\tlcvmothertongue}[1]{%
    \ifdefempty{\tlcv@mtlist}{}{\gappto{\tlcv@mtlist}{, }}%
    \gappto{\tlcv@mtlist}{#1}%
}

\newcommand{\tlcvlanguage}[6]{%
    \ifdefempty{\tlcv@langtablebody}{}{\gappto{\tlcv@langtablebody}{\noalign{\vspace{2pt}}\hline\noalign{\vspace{2pt}}}}%
    \gappto{\tlcv@langtablebody}{\textbf{#1} & #2 & #3 & #4 & #5 & #6 \\}%
}

\newcommand{\tlcvlanguagecertificate}[1]{%
    \gappto{\tlcv@langtablebody}{\noalign{\vspace{-2pt}}{\scriptsize \textit{#1}} & & & & & \\}%
}

\newenvironment{tlcvlanguages}{%
    \renewcommand{\tlcv@mtlist}{}%
    \def\tlcv@langtablebody{}%
}{%
    \ifbool{tlcv@firstentry}{%
        \par\nopagebreak\vspace{6pt}\boolfalse{tlcv@firstentry}%
    }{%
        \par\vspace{6pt}%
    }%
    \ifdefempty{\tlcv@mtlist}{}{%
        \noindent{\color{tlcv@color@highlight}\small\tlcv@label@mothertongue: \textbf{\tlcv@mtlist}}\par\nopagebreak\vspace{3pt}%
    }%
    \nopagebreak%
    \begin{tcolorbox}[
        colback=tlcv@color@accent, colframe=tlcv@color@tablesep,
        arc=4pt, boxrule=0.5pt, 
        left=4pt, right=4pt, top=3pt, bottom=3pt, boxsep=0pt,
        enhanced, before skip=4pt, after skip=0pt, width=\linewidth
    ]
        \setlength{\tabcolsep}{3pt}
        \renewcommand{\arraystretch}{1.1}
        \centering
        \begin{tabular}{@{} p{\tlcv@lang@colA} | >{\centering\arraybackslash}p{\tlcv@lang@colB} >{\centering\arraybackslash}p{\tlcv@lang@colC} | >{\centering\arraybackslash}p{\tlcv@lang@colD} >{\centering\arraybackslash}p{\tlcv@lang@colE} | >{\centering\arraybackslash}p{\tlcv@lang@colF} @{}}
            \rowcolor{tlcv@color@accent}
            & \multicolumn{2}{c}{\scriptsize\textbf{\tlcv@label@understanding}} 
            & \multicolumn{2}{c}{\scriptsize\textbf{\tlcv@label@speaking}} 
            & \scriptsize\textbf{\tlcv@label@writing} \\
            \rowcolor{tlcv@color@accent}
            \noalign{\vspace{-2pt}}
            & \scriptsize\iftlcv@langicons{\faHeadphones}~\fi\tlcv@label@listening 
            & \scriptsize\iftlcv@langicons{\faBookOpen}~\fi\tlcv@label@reading 
            & \scriptsize\iftlcv@langicons{\faBullhorn}~\fi\tlcv@label@spokenproduction 
            & \scriptsize\iftlcv@langicons{\faComments}~\fi\tlcv@label@spokeninteraction 
            & \\ 
            \noalign{\vspace{1pt}}\hline\noalign{\vspace{3pt}}
            \tlcv@langtablebody
        \end{tabular}
    \end{tcolorbox}
    \iftlcv@cefrlevels
        \nopagebreak\vspace{4pt}
        \noindent\footnotesize\textit{\tlcv@label@cefrlevels}\par
    \fi
}

% ============================================================
% 13. PERSONAL SKILLS & DRIVING LICENCES
% ============================================================
\newcommand{\tlcv@skillstitle}{}
\newcommand{\tlcv@skillslist}{}

\newcommand{\tlcvskill}[1]{%
    \ifdefempty{\tlcv@skillslist}{\renewcommand{\tlcv@skillslist}{#1}}{\gappto{\tlcv@skillslist}{\tlcv@sep#1}}%
}

\newenvironment{tlcvskills}[1][]{%
    \renewcommand{\tlcv@skillslist}{}\renewcommand{\tlcv@skillstitle}{#1}%
}{%
    \ifbool{tlcv@firstentry}{%
        \par\nopagebreak\vspace{6pt}\boolfalse{tlcv@firstentry}%
    }{%
        \par\vspace{8pt}%
    }%
    \noindent%
    \ifdefempty{\tlcv@skillstitle}{}{%
        \textbf{\tlcv@skillstitle}%
        {\color{tlcv@color@highlight}\tlcv@sep}%
    }%
    {\color{tlcv@color@highlight}\tlcv@skillslist}\normalcolor\par%
}

\newcommand{\tlcv@licenceslist}{}
\newcommand{\tlcv@drivinglicenceitem}[1]{%
    \ifbool{tlcv@firstentry}{%
        \par\nopagebreak\vspace{6pt}\boolfalse{tlcv@firstentry}%
    }{%
        \par\vspace{8pt}%
    }%
    \noindent\textbf{\tlcv@label@drivinglicence~#1}\par%
}

\newcommand{\tlcvdrivinglicence}[1]{%
    \ifdefempty{\tlcv@licenceslist}%
        {\renewcommand{\tlcv@licenceslist}{\tlcv@drivinglicenceitem{#1}}}%
        {\gappto{\tlcv@licenceslist}{\tlcv@drivinglicenceitem{#1}}}%
}

\newenvironment{tlcvdrivinglicences}[1][]{%
    \renewcommand{\tlcv@licenceslist}{}%
}{%
    {\color{tlcv@color@highlight}\tlcv@licenceslist}\normalcolor%
}

% ============================================================
% 14. DATE, SIGNATURE & COVER LETTER
% ============================================================
\NewDocumentCommand{\tlcvsignature}{O{}}{%
    \par\vfill%
    \noindent\ifstrempty{#1}{}{#1, }\today \hfill \rule{0.4\textwidth}{0.5pt}\par
    \vspace{4pt}%
    \noindent \hfill \makebox[0.4\textwidth][c]{\textbf{\tlcv@info@name}}\par
}

\newcommand{\tlcv@letter@recipientname}{}
\newcommand{\tlcv@letter@recipientaddress}{}
\newcommand{\tlcv@letter@subject}{}
\newcommand{\tlcv@letter@opening}{}
\newcommand{\tlcv@letter@closing}{}

\newcommand{\tlcvrecipient}[2]{%
    \renewcommand{\tlcv@letter@recipientname}{#1}%
    \renewcommand{\tlcv@letter@recipientaddress}{#2}%
}
\newcommand{\tlcvsubject}[1]{\renewcommand{\tlcv@letter@subject}{#1}}
\newcommand{\tlcvopening}[1]{\renewcommand{\tlcv@letter@opening}{#1}}
\newcommand{\tlcvclosing}[1]{\renewcommand{\tlcv@letter@closing}{#1}}

\newenvironment{tlcvcoverletter}{%
    \par\vspace{1cm}%
    \ifdefempty{\tlcv@letter@recipientname}{}{%
        \noindent\textbf{\tlcv@letter@recipientname}\par
        \noindent\tlcv@letter@recipientaddress\par\vspace{2.5em}%
    }
    \ifdefempty{\tlcv@letter@subject}{}{%
        \noindent{\color{tlcv@color@highlight}\textbf{\tlcv@letter@subject}}\par\vspace{1.5em}%
    }
    \ifdefempty{\tlcv@letter@opening}{}{%
        \noindent\tlcv@letter@opening\par\vspace{1em}%
    }
    \setlength{\parskip}{0.8em}\setlength{\parindent}{0pt}\justifying%
}{%
    \par\vspace{1.5em}%
    \ifdefempty{\tlcv@letter@closing}{}{\noindent\tlcv@letter@closing\par}
    \setlength{\parskip}{0pt}%
}