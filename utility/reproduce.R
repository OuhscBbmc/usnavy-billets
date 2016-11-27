# knitr::stitch_rmd(script="./utility/reproduce.R", output="./utility/reproduce.md")

# Reproducible Research ---------------------------------------------------
#' When executed by R, this file will manipulate the original data sources (ie, ZZZZ)
#' to produce a groomed dataset suitable for analysis and graphing.

# Clear memory from previous runs -----------------------------------------
base::rm(list=base::ls(all=TRUE))

# Check Working Directory -------------------------------------------------
#' Verify the working directory has been set correctly.  Much of the code assumes the working directory is the repository's root directory.
#' In the following line, rename `RAnalysisSkeleton` to your repository.
if( base::basename(base::getwd()) != "usnavy-billets" ) {
  base::stop("The working directory should be set to the root of the package/repository.  ",
       "It's currently set to `", base::getwd(), "`.")
}

# Install the necessary packages ------------------------------------------
path_install_packages <- "./utility/install-packages.R"
if( !file.exists(path_install_packages)) {
  base::stop("The file `", path_install_packages, "` was not found.  Make sure the working directory is set to the root of the repository.")
}
base::source(path_install_packages, local=new.env())

base::rm(path_install_packages)

# Load the necessary packages ---------------------------------------------
base::requireNamespace("base")
base::requireNamespace("knitr")
base::requireNamespace("markdown")
base::requireNamespace("testit")

######################################################################################################

# Declare the paths of the necessary files --------------------------------

# Data Files:
path_data <- c(
  "command-roster"              = "./data-phi-free/raw/command-roster.csv",
  "command-wide"                = "./data-phi-free/raw/command-wide.csv",
  "officer-roster"              = "./data-phi-free/raw/officer-roster.csv",
  "officer-wide"                = "./data-phi-free/raw/officer-wide.csv"
)

# Code Files:
path_manipulations <- c(
  "selection-munge"             = "./manipulation/selection-munge.R"
)

# Report Files:
path_rmds <- c(
  "select-1"     = "./analysis/select-1/select-1.Rmd"
)

# Verify the necessary path can be found ----------------------------------

# The raw/input data files:
testit::assert("All data files should exist.", all(vapply(path_data, file.exists,  logical(1))))

# Code Files:
testit::assert("All manipulation files should exist.", all(base::file.exists(path_manipulations)))

# Report Files:
testit::assert("All Rmd files should exist.", all(base::file.exists(path_rmds)))

# Run the files that manipulate and analyze -------------------------------
for( path_manipulation in path_manipulations ) {
  path_md   <- base::gsub(pattern="\\.R$", replacement=".md"  , x=path_manipulation)
  path_md   <- base::gsub(pattern="^\\./", replacement="./stitched-output/"  , x=path_md)

  cat(path_md, "\n")
  knitr::stitch_rmd(script=path_manipulation, output=path_md, envir=base::new.env())
}
rm(path_manipulation, path_md)

# Build the reports -------------------------------------------------------
for( path_rmd in path_rmds ) {
  path_md   <- base::gsub(pattern="\\.Rmd$", replacement=".md"  , x=path_rmd)
  path_html <- base::gsub(pattern="\\.Rmd$", replacement=".html", x=path_rmd)
  rmarkdown::render(input=path_rmd, envir = new.env(), knit_root_dir=getwd())
  # knitr::knit(input=path_rmd, output=path_md, envir = new.env(), )
  # markdown::markdownToHTML(file=path_md, output=path_html)
}
rm(path_rmd, path_md, path_html)
