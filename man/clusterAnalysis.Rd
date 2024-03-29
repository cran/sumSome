% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clusterAnalysis.R
\name{clusterAnalysis}
\alias{clusterAnalysis}
\title{True Discovery Guarantee for Cluster Analysis}
\usage{
clusterAnalysis(sumBrain, clusters, nMax = 50, silent = FALSE)
}
\arguments{
\item{sumBrain}{an object of class sumBrain, as returned by the functions \code{\link{brainScores}} and \code{\link{brainPvals}}.}

\item{clusters}{3D numeric array of cluster indices, or character for a Nifti file name.
If NULL, the whole brain is considered.}

\item{nMax}{maximum number of iterations per cluster.}

\item{silent}{logical, \code{FALSE} to print the summary.}
}
\value{
\code{clusterAnalysis} returns a list containing \code{summary} (matrix) and
\code{TDPmap} (3D numeric array of the true discovery proportions).
The matrix \code{summary} contains, for each cluster,
\itemize{
\item \code{size}: size
\item \code{TD}: lower (1-\code{alpha})-confidence bound for the number of true discoveries
\item \code{maxTD}: maximum value of \code{TD} that could be found under convergence of the algorithm
\item \code{TDP}: lower (1-\code{alpha})-confidence bound for the true discovery proportion
\item \code{maxTD}: maximum value of \code{TDP} that could be found under convergence of the algorithm
\item \code{dim1}, \code{dim2}, \code{dim3}: coordinates of the center of mass.
}
}
\description{
This function determines a true discovery guarantee for fMRI cluster analysis.
It computes confidence bounds for the number of true discoveries and the true discovery proportion
within each cluster. The bounds are simultaneous over all sets, and remain valid under post-hoc selection.
}
\examples{
# simulate 20 copes with dimensions 10x10x10
set.seed(42)
copes <- list()
for(i in seq(20)){copes[[i]] <- array(rnorm(10^3, mean = -10, sd = 30), dim=c(10,10,10))}

# cluster map where t scores are grater than 2.8, in absolute value
thr <- 2.8
cl <- findClusters(copes = copes, thr = thr)

# create object of class sumBrain
res <- brainScores(copes = copes, alpha = 0.2, seed = 42, truncFrom = thr)
res
summary(res)

# confidence bound for the number of true discoveries and the TDP within clusters
out <- clusterAnalysis(res, clusters = cl$clusters)
}
\references{
Goeman, J. J. and Solari, A. (2011). Multiple testing for exploratory research. Statistical Science, 26(4):584-597.

Hemerik, J. and Goeman, J. J. (2018). False discovery proportion estimation by permutations: confidence for significance analysis of microarrays. JRSS B, 80(1):137-155.

Vesely, A., Finos, L., and Goeman, J. J. (2020). Permutation-based true discovery guarantee by sum tests. Pre-print arXiv:2102.11759.
}
\seealso{
Permutation statistics for brain imaging: \code{\link{brainScores}}, \code{\link{brainPvals}}

Suprathreshold clusters: \code{\link{findClusters}}
}
\author{
Anna Vesely.
}
