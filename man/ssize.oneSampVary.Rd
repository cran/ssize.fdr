\name{ssize.oneSampVary}
\alias{ssize.oneSampVary}
\title{Sample Size Calculations for One-Sample Microarray Experiments with 
	Differing Mean Expressions and Standard Deviations Among Genes}
\description{
 This function calculates appropriate sample sizes for two-sample microarray
 experiments in which effect sizes as well as variances vary among genes.
 Sample sizes are determined based on a desired power, a controlled false
 discovery rate, and user-specified proportions of non-differentially
 expressed genes. Outputs a graph of power versus sample size. A graph of
 power versus sample size is created.
}
\usage{
ssize.oneSampVary(deltaMean, deltaSE, a, b, fdr = 0.05, power = 0.8, pi0 = 0.95,
                  maxN = 35, side = "two-sided", cex.title=1.15, cex.legend=1)
}
\arguments{
  \item{deltaMean}{mean of normal distribution followed 
		by effect sizes among genes}
  \item{deltaSE}{standard deviation of normal distribution 
		followed by effect sizes among genes}
  \item{a}{shape parameter of inverse gamma distribution followed by variances
		of genes}
  \item{b}{scale parameter of inverse gamma distribution followed by variances
		of genes}
  \item{fdr}{the false discovery rate to be controlled}
  \item{power}{the desired power to be achieved}
  \item{pi0}{a vector (or scalar) of proportions of non-differentially expressed 
		genes}
  \item{maxN}{the maximum sample size used for power calculations}
  \item{side}{options are "two-sided", "upper", or "lower"}
  \item{cex.title}{controls size of chart titles}
  \item{cex.legend}{controls size of chart legend}
}
\details{
The effect sizes among genes are assumed to follow a Normal distribution
with mean specified by \code{deltaMean} and standard deviation specified by
\code{deltaSE}. The variances among genes are assumed to follow an 
Inverse Gamma distribution with shape parameter \code{a} and scale parameter
\code{b}.


If a vector is input for \code{pi0}, sample size calculations 
are performed for each proportion.
}
\value{
  \item{ssize}{sample sizes (for each treatment) at which desired power is first
		 reached}
  \item{power}{power calculations with corresponding sample sizes}
  \item{crit.vals}{critical value calculations with corresponding sample sizes}
}
\references{Liu, Peng and J. T. Gene Hwang. 2007. Quick calculation for sample 
  size while controlling false discovery rate with application to microarray 
  analysis. \emph{Bioinformatics} 23(6): 739-746. }
\author{Megan Orr \email{megan.orr@ndsu.edu}, Peng Liu \email{pliu@iastate.edu}}
\note{
Numerical integration used in calculations performed by the function 
\code{\link{integrate}}, which uses adaptive quadrature of functions.


Powers calculated to be 0 may be negligibly conservative.


Critical values calculated as \sQuote{NA} are values >20.


Running this function may result in many warnings. Probabilities under
different t-distributions with non-zero non-centrality parameters are
calculated many times while the function runs.  If these probabilities
are virtually zero, the function \code{\link{pt}} outputs a value <1e-8
and outputs a warning of \dQuote{full precision not achieved}.  These values
have no impact on the accuracy of the resulting calculations.
}
\seealso{\code{\link{ssize.twoSampVary}}, \code{\link{ssize.oneSamp}}, 
	\code{\link{ssize.oneSampVary}}, \code{\link{ssize.F}}, 
	\code{\link{ssize.Fvary}}}
\examples{
 dm<-2;  ds<-1	##the effect sizes of the genes follow a Normal(2,1) distribution
 alph<-3;  beta<-1	##the variances of the genes follow an Inverse Gamma(3,1) distribution.
 a2<-0.05	##false discovery rate to be controlled
 pwr2<-0.8	##desired power
 p0<-c(0.90,0.95,0.995)	##proportions of non-differentially expressed genes
 N1<-35		##maximum sample size to be used in calculations

 osv<-ssize.oneSampVary(deltaMean=dm,deltaSE=ds,a=alph,b=beta,fdr=a2,power=pwr2,pi0=p0,
        maxN=N1,side="two-sided")
 osv$ssize	##first sample sizes to reach desired power
 osv$power	##calculated power for each sample size
 osv$crit.vals	##calculated critical value for each sample size
}

