% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_metadata.R
\name{zarr_overview}
\alias{zarr_overview}
\title{Print a summary of a Zarr array}
\usage{
zarr_overview(zarr_array_path, s3_client, as_data_frame = FALSE)
}
\arguments{
\item{zarr_array_path}{A character vector of length 1.  This provides the
path to a Zarr array or group of arrays. This can either be on a local file
system or on S3 storage.}

\item{s3_client}{A list representing an S3 client.  This should be produced
by \code{\link[paws.storage:s3]{paws.storage::s3()}}.}

\item{as_data_frame}{Logical determining whether the Zarr array details
should be printed to screen (\code{FALSE}) or returned as a \code{data.frame}
(\code{TRUE}) so they can be used computationally.}
}
\value{
If \code{as_data_frame = FALSE} the function invisible returns \code{TRUE} if
successful.  However it is primarily called for the side effect of printing
details of the Zarr array(s) to the screen.  If \code{as_data_frame = TRUE} then
a \code{data.frame} containing details of the array is returned.
}
\description{
When reading a Zarr array using \code{\link[=read_zarr_array]{read_zarr_array()}} it is necessary to know
it's shape and size. \code{zarr_overview()} can be used to get a quick overview of
the array shape and contents, based on the .zarray metadata file each array
contains.
}
\details{
The function currently prints the following information to the R console:
\itemize{
\item array path
\item array shape and size
\item chunk and size
\item the number of chunks
\item the datatype of the array
\item codec used for data compression (if any)
}

If given the path to a group of arrays the function will attempt to print the
details of all sub-arrays in the group.
}
\examples{

## Using a local file provided with the package
z1 <- system.file("extdata", "zarr_examples", "row-first",
  "int32.zarr",
  package = "Rarr"
)

## read the entire array
zarr_overview(zarr_array_path = z1)

## using a file on S3 storage
## don't run this on the BioC Linux build - it's very slow there
is_BBS_linux <- nzchar(Sys.getenv("IS_BIOC_BUILD_MACHINE")) && Sys.info()["sysname"] == "Linux"
if(!is_BBS_linux) {
  z2 <- "https://uk1s3.embassy.ebi.ac.uk/idr/zarr/v0.4/idr0101A/13457539.zarr/1"
  zarr_overview(z2)
}
}
