% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zero_measures.R
\name{zero_measures}
\alias{zero_measures}
\title{ZERO MEASURE}
\usage{
zero_measures(x, include.na)
}
\arguments{
\item{x}{a vector}

\item{include.na}{a logical vector. If TRUE, responses entered as NA responses will be removed.}
}
\description{
This function transcribes responses of "zero", "none", or "null" to the numeric equivalent of "0".
It also includes the argument 'include.na' to transcribe responses of "NA" to zero, whilst maintaining NA for true missing values.
}
