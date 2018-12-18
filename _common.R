set.seed(1011)

knitr::opts_chunk$set(
  comment = NA,
  collapse = FALSE,
  out.width = "70%",
  fig.align = "center",
  fig.width = 6,
  fig.asp = .618,
  fig.pos = "H"
 )
 
# figure numbering --------------------------
# https://stackoverflow.com/questions/13848137/figure-captions-references-using-knitr-and-markdown-to-html
# https://github.com/yihui/knitr-examples/blob/master/070-caption-num.Rmd
fig <- local({
  i <- 0
  fig_ref <- list()
  list(
    cap = function(refer, title) {
      i <<- i + 1
      # fig_ref[[refer]] <<- paste("Figure", i)
      fig_ref[[refer]] <<- paste("Figure ", "\\ref{", refer, "}", sep = "") # \ref{refer} = linked i
      paste(title, "\\label{", refer, "}", sep = "")
    },
    ref = function(refer) {
      fig_ref[[refer]]
    }
  )
})
# table numbering ---------------------------
tab <- local({
  j <- 0
  tab_ref <- list()
  list(
    cap = function(refer, title) {
      j <<- j + 1
      tab_ref[[refer]] <<- paste("Figure", j)
      title
      tab_ref[[refer]] <<- paste("Table ", "\\ref{", refer, "}", sep = "")
      paste(title, "\\label{", refer, "}", sep = "")
    },
    ref = function(refer) {
      tab_ref[[refer]]
    }
  )
})
# section reference -------------------------
# https://gist.github.com/Thell/5827832#file-exmple-rmd
sec <- local({
  function(seclabel) {
    sprintf('# <a name="%s"/> %s', seclabel, seclabel)
  }  
})
secref <- local({
  function(seclabel) {
    sprintf('[%s](#%s)', seclabel, seclabel)
  }  
})
# chunk reference ---------------------------
knitr::knit_hooks$set( echo.label = function(before, options, envir) {
  if ( before ) {
    sprintf('> %s', options$label )
  }
})
knitr::knit_hooks$set( anchor = function(before, options, envir) {
  if ( before ) {
    sprintf('<a name="%s"/>\n', options$label )
  }
})
chunkref <- local({
  function(chunklabel) {
    sprintf('[%s](#%s)', chunklabel, chunklabel)
  }  
})

# rounding digits ------------------------------
options(digits = 3)

# pander table remove NA -----------
pander::panderOptions("missing", "")

# ggplot default color ------------------
gg_hcl <- function(n) {
  hue <- seq(15, 375, length.out = n + 1)
  hcl_cols <- hcl(h = hue, c = 100, l = 65)[-(n + 1)]
  hcl_cols
}