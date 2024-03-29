# LaTeX
[Resources](README.md)

## Document

<details>
<summary>What is the common method to write a document as a beginner?</summary>

> **Description**
>
> Using online tex compiler: https://overleaf.com
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

<details>
<summary>What is the best practice in naming tex files?</summary>

> **Description**
>
> Do not use spaces in naming of tex files. Use hyphens or dots instead.
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

<details>
<summary>How many document classes are available?</summary>

> **Description**
>
> - article
> - exam
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

<details>
<summary>Create an empty article document?</summary>

> **Description**
>
> Documents should have at least one line of text to compile.
>
> ```tex
\documentclass{article}

\begin{document}
Sample text.
\end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> - https://www.youtube.com/watch?v=cnEXgHFOxMU&list=PLLybgCU6QCGU2Hh8R3oCwZnVZry-ICY5R&index=2
> ---
> **References**
> ---
</details>

<details>
<summary>Set default font for document?</summary>

> **Description**
>
> ```tex
> \documentclass[11pt]{article}
>
> \begin{document}
> Sample Text
> \end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

<details>
<summary>Make a title in document?</summary>

> **Description**
>
> ```tex
> \documentclass{article}
>
> \title{Sample Document}
> \author{Brian Salehi}
> \date{\today}
>
> \begin{document}
> \maketitle
> \end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

## Package

Which packages come with latex setup?

## Common Packages

What are the common necessary packages to be used?

<details>
<summary>What features does the blindtext package present?</summary>

> **Description**
>
> ```tex
> \documentclass{article}
> \usepackage(blindtext)
>
> \begin{document}
> \blindtext
> \end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=cnEXgHFOxMU&list=PLLybgCU6QCGU2Hh8R3oCwZnVZry-ICY5R&index=2
> ---
> **References**
> ---
</details>

## Unicode Text

<details>
<summary>What package should be used when UTF8 characters are written in text?</summary>

> **Description**
>
> ```tex
> \documentclass{article}
> \usepackage[utf8]{inputenc}
>
> \begin{document}
> Groß Text.
> \end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=cnEXgHFOxMU&list=PLLybgCU6QCGU2Hh8R3oCwZnVZry-ICY5R&index=2
> ---
> **References**
> ---
</details>

## New Line

<details>
<summary>What is best method to separate consequent lines in tex document?</summary>

> **Description**
>
> Newline `\\` can be at the end of the line we want to break.
>
> ```tex
> Sample text.\\
> Next line of text.
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

## Text Format

<details>
<summary>Bold a text?</summary>

> **Description**
>
> ```tex
> \textbf{Bold text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Italic a text?</summary>

> **Description**
>
> ```tex
> \textit{Italic text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Underline a text?</summary>

> **Description**
>
> ```tex
> \underline{Underline text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Underline a text with double line?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \underline{\underline{Double underline text}}
> \uuline{Double underline text}}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Underline a text with wavy line?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \uwave{Wavy Underline text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Strikethrough a text?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \sout{Strikethrough text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Slash through a text?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \xout{Slashed out text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Underline text with dashed line?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \dashuline{Dash underline text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

<details>
<summary>Underline text with dotted line?</summary>

> **Description**
>
> ```tex
> usepackage(ulem)
>
> \dotuline{Dotted underline text}
> ``````
>
> ---
> **Resources**
> - https://latex-tutorial.com/underline-latex
> ---
> **References**
> ---
</details>

## Text Color

<details>
<summary>Color text?</summary>

> **Description**
>
> ```tex
\documentclass[11pt]{article}
\usepackage{xcolor}

\begin{document}
\color{red}Colored Text
\end{document}
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

## Inline Math

<details>
<summary>What symbol is used to create an inline math block?</summary>

> **Description**
>
> ```tex
> A rectangle has side lengths of $(x+1)$ and $(x+3)$.
> The equation $A(x) = x^2 + 4x + 3$ gives the area of the rectangle.
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

<details>
<summary>Protect a piece of inline math block from breaking into two lines?</summary>

> **Description**
>
> Surround the math block with curly braces `${ equation }$` to protect it from
> breakage.
>
> ```tex
> A rectangle has side lengths of $(x+1)$ and $(x+3)$.
> The equation ${A(x) = x^2 + 4x + 3}$ gives the area of the rectangle.
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

## Block Math

<details>
<summary>Write a math equation to be shown in a new separate line?</summary>

> **Description**
>
> ```tex
> The equation $${A(x) = x^2 + 4x + 3}$$ gives the area of the rectangle.
> ``````
>
> ---
> **Resources**
> - https://www.youtube.com/watch?v=0ivLZh9xK1Q&list=PL1D4EAB31D3EBC449&index=1
> ---
> **References**
> ---
</details>

