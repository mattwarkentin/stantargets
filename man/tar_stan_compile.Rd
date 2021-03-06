% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tar_stan_compile.R
\name{tar_stan_compile}
\alias{tar_stan_compile}
\title{Target to compile a Stan model}
\usage{
tar_stan_compile(
  name,
  stan_file,
  quiet = TRUE,
  dir = NULL,
  include_paths = NULL,
  cpp_options = list(),
  stanc_options = list(),
  force_recompile = FALSE,
  error = targets::tar_option_get("error"),
  memory = targets::tar_option_get("memory"),
  garbage_collection = targets::tar_option_get("garbage_collection"),
  deployment = targets::tar_option_get("deployment"),
  priority = targets::tar_option_get("priority"),
  resources = targets::tar_option_get("resources"),
  storage = targets::tar_option_get("storage"),
  retrieval = targets::tar_option_get("retrieval"),
  cue = targets::tar_option_get("cue")
)
}
\arguments{
\item{name}{Symbol, name of the target.}

\item{stan_file}{The path to a \code{.stan} file containing a Stan program. The
helper function \code{\link[cmdstanr:write_stan_file]{write_stan_file()}} is provided for cases when it is
more convenient to specify the Stan program as a string.}

\item{quiet}{(logical) Should the verbose output from CmdStan during
compilation be suppressed? The default is \code{TRUE}, but if you encounter an
error we recommend trying again with \code{quiet=FALSE} to see more of the
output.}

\item{dir}{(string) The path to the directory in which to store the CmdStan
executable (or \code{.hpp} file if using \verb{$save_hpp_file()}). The default is the
same location as the Stan program.}

\item{include_paths}{(character vector) Paths to directories where Stan
should look for files specified in \verb{#include} directives in the Stan
program.}

\item{cpp_options}{(list) Any makefile options to be used when compiling the
model (\code{STAN_THREADS}, \code{STAN_MPI}, \code{STAN_OPENCL}, etc.). Anything you would
otherwise write in the \code{make/local} file.}

\item{stanc_options}{(list) Any Stan-to-C++ transpiler options to be used
when compiling the model. See the \strong{Examples} section below as well as the
\code{stanc} chapter of the CmdStan Guide for more details on available options:
https://mc-stan.org/docs/cmdstan-guide/stanc.html.}

\item{force_recompile}{(logical) Should the model be recompiled even if was
not modified since last compiled. The default is \code{FALSE}.}

\item{error}{Character of length 1, what to do if the target
runs into an error. If \code{"stop"}, the whole pipeline stops
and throws an error. If \code{"continue"}, the error is recorded,
but the pipeline keeps going.}

\item{memory}{Character of length 1, memory strategy.
If \code{"persistent"}, the target stays in memory
until the end of the pipeline (unless \code{storage} is \code{"worker"},
in which case \code{targets} unloads the value from memory
right after storing it in order to avoid sending
copious data over a network).
If \code{"transient"}, the target gets unloaded
after every new target completes.
Either way, the target gets automatically loaded into memory
whenever another target needs the value.
For cloud-based dynamic files such as \code{format = "aws_file"},
this memory policy applies to
temporary local copies of the file in \verb{_targets/scratch/"}:
\code{"persistent"} means they remain until the end of the pipeline,
and \code{"transient"} means they get deleted from the file system
as soon as possible. The former conserves bandwidth,
and the latter conserves local storage.}

\item{garbage_collection}{Logical, whether to run \code{base::gc()}
just before the target runs.}

\item{deployment}{Character of length 1, only relevant to
\code{\link[targets:tar_make_clustermq]{tar_make_clustermq()}} and \code{\link[targets:tar_make_future]{tar_make_future()}}. If \code{"worker"},
the target builds on a parallel worker. If \code{"main"},
the target builds on the host machine / process managing the pipeline.}

\item{priority}{Numeric of length 1 between 0 and 1. Controls which
targets get deployed first when multiple competing targets are ready
simultaneously. Targets with priorities closer to 1 get built earlier.
Only applies to \code{\link[targets:tar_make_future]{tar_make_future()}} and \code{\link[targets:tar_make_clustermq]{tar_make_clustermq()}}
(not \code{\link[targets:tar_make]{tar_make()}}). \code{\link[targets:tar_make_future]{tar_make_future()}} with no extra settings is
a drop-in replacement for \code{\link[targets:tar_make]{tar_make()}} in this case.}

\item{resources}{A named list of computing resources. Uses:
\itemize{
\item Template file wildcards for \code{future::future()} in \code{\link[targets:tar_make_future]{tar_make_future()}}.
\item Template file wildcards \code{clustermq::workers()} in \code{\link[targets:tar_make_clustermq]{tar_make_clustermq()}}.
\item Custom target-level \code{future::plan()}, e.g.
\code{resources = list(plan = future.callr::callr)}.
\item Custom \code{curl} handle if \code{format = "url"},
e.g. \code{resources = list(handle = curl::new_handle())}.
\item Custom preset for \code{qs::qsave()} if \code{format = "qs"}, e.g.
\code{resources = list(handle = "archive")}.
\item Custom compression level for \code{fst::write_fst()} if
\code{format} is \code{"fst"}, \code{"fst_dt"}, or \code{"fst_tbl"}, e.g.
\code{resources = list(compress = 100)}.
\item AWS bucket and prefix for the \code{"aws_"} formats, e.g.
\code{resources = list(bucket = "your-bucket", prefix = "folder/name")}.
\code{bucket} is required for AWS formats. See the cloud computing chapter
of the manual for details.
}}

\item{storage}{Character of length 1, only relevant to
\code{\link[targets:tar_make_clustermq]{tar_make_clustermq()}} and \code{\link[targets:tar_make_future]{tar_make_future()}}.
If \code{"main"}, the target's return value is sent back to the
host machine and saved locally. If \code{"worker"}, the worker
saves the value.}

\item{retrieval}{Character of length 1, only relevant to
\code{\link[targets:tar_make_clustermq]{tar_make_clustermq()}} and \code{\link[targets:tar_make_future]{tar_make_future()}}.
If \code{"main"}, the target's dependencies are loaded on the host machine
and sent to the worker before the target builds.
If \code{"worker"}, the worker loads the targets dependencies.}

\item{cue}{An optional object from \code{tar_cue()} to customize the
rules that decide whether the target is up to date.}
}
\value{
A target object to compile a Stan file.
Target objects represent skippable steps of the analysis pipeline
as described at \url{https://books.ropensci.org/targets/}.
Please see the design specification at
\url{https://books.ropensci.org/targets-design/}
to learn about the structure and composition of target objects.
}
\description{
Target to compile a Stan model and return the
original Stan model file. Does not compile the model
if the compilation is already up to date.
}
\details{
Most of the arguments are passed to the
\verb{$compile()} method of the \code{CmdStanModel} class.
For details, visit \url{https://mc-stan.org/cmdstanr/reference/}.
}
\examples{
if (Sys.getenv("TAR_LONG_EXAMPLES") == "true") {
targets::tar_dir({ # tar_dir() runs code from a temporary directory.
targets::tar_script({
library(stantargets)
# Do not use temporary storage for stan files in real projects
# or else your targets will always rerun.
path <- tempfile(fileext = ".stan")
tar_stan_example_file(path = path)
list(tar_stan_compile(compiled_model, path))
})
targets::tar_make()
})
}
}
