\name{ssize.oneSamp}
\alias{ssize.oneSamp}
\title{Sample Size Calculations for One-Sample Microarray Experiments}
\description{
  This function calculates appropriate sample sizes for one-sample
  microarray experiments for a desired power.  Sample size calculations
  are performed at controlled false discovery rates and user-specified
  proportions of non-differentially expressed genes, effect size, and
  standard deviation.  A graph of power versus sample size is created.
}
\usage{
ssize.oneSamp(delta, sigma, fdr = 0.05, power = 0.8, pi0 = 0.95, maxN = 35, side = "two-sided")
}
\arguments{
  \item{delta}{the common effect size for all genes}
  \item{sigma}{the standard deviation for all genes}
  \item{fdr}{the false discovery rate to be controlled}
  \item{power}{the desired power to be achieved}
  \item{pi0}{a vector (or scalar) of proportions of non-differentially 
		expressed genes}
  \item{maxN}{the maximum sample size used for power calculations}
  \item{side}{options are "two-sided", "upper", or "lower"}
}
\details{
Effect sizes and standard deviations are assumed to be identical 
for all genes.  See the function \code{\link{ssize.oneSampVary}}
for sample size calculations with varying effects sizes and
standard deviations among genes.


If a vector is input for \code{pi0}, sample size calculations 
are performed for each proportion.
}
\value{
  \item{ssize}{sample sizes at which desired power is first reached}
  \item{power}{power calculations with corresponding sample sizes}
  \item{crit.vals}{critical value calculations with corresponding sample sizes}
}
\references{ Liu, Peng and J. T. Gene Hwang. 2007. Quick calculation for
  sample size while controlling false discovery rate with application
  to microarray analysis. Bioinformatics 23(6): 739-746.}
\author{Megan Orr \email{meganorr@iastate.edu}, Peng Liu \email{pliu@iastate.edu}}
\note{
Powers calculated to be 0 may be negligibly conservative.


Critical values calculated as \sQuote{NA} are values >20.


Running this function with the \code{side} option of \dQuote{lower} will
possibly result in multiple warnings. Calculating the probability
that an observation is less than the negative critical value under
a t-distribution with non-centrality parameter \emph{delta/sigma}
(see argument section above) and the appropriate degrees of freedom
is a calculation that is performed many times while the function
runs. When the difference between the critical value and
\emph{delta/sigma} is large, this probability is virtually zero.
This happens repeatedly while the function \code{\link{optimize}}
finds the appropriate critical value for each sample size.  Because
of this, the function \code{\link{pt}} outputs a value <1e-8 in
addition to a warning of \dQuote{full precision not achieved}. This has no
impact on the accuracy of the resulting calculations of sample size.
}
\seealso{\code{\link{ssize.twoSampVary}}, \code{\link{ssize.oneSamp}}, 
	\code{\link{ssize.oneSampVary}}, \code{\link{ssize.F}}, 
	\code{\link{ssize.Fvary}}}
\examples{
 d<-2		##effect size
 s<-1  		##standard deviation 
 a<-0.05	##false discovery rate to be controlled
 pwr<-0.8	##desired power
 p0<-c(0.5,0.9,0.95)	##proportions of non-differentially expressed genes
 N<-20		##maximum sample size for calculations
 os<-ssize.oneSamp(delta=d,sigma=s,fdr=a,power=pwr,pi0=p0,maxN=N,side="two-sided")
 os$ssize	##first sample sizes to reach desired power
 os$power	##calculated power for each sample size
 os$crit.vals	##calculated critical value for each sample size
}

