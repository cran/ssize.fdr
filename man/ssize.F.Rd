\name{ssize.F}
\alias{ssize.F}
\title{Sample Size Calculations for Multi-Sample Microarray Experiments}
\description{
  This function calculates appropriate sample sizes for multi-sample
  microarray experiments for a desired power.  Sample size
  calculations are performed at controlled false discovery rates
  and user-specified proportions of non-differentially expressed
  genes, design matrix, and standard deviation. A graph of power
  versus sample size is created.
}
\usage{
ssize.F(X, beta, L = NULL, dn, sigma, fdr = 0.05, power = 0.8, pi0 = 0.95, maxN = 20,
        cex.title=1.15, cex.legend=1)
}
\arguments{
  \item{X}{design matrix of experiment}
  \item{beta}{parameter vector}
  \item{L}{coefficient matrix or vector for linear contrasts of 
	interest}
  \item{dn}{a function of the degrees of freedom based on the design
	 of the experiment}
  \item{sigma}{the standard deviation for all genes}
  \item{fdr}{the false discovery rate to be controlled}
  \item{power}{the desired power to be achieved}
  \item{pi0}{a vector (or scalar) of proportions of non-differentially 
	expressed genes}
  \item{maxN}{the maximum sample size used for power calculations}
  \item{cex.title}{controls size of chart titles}
  \item{cex.legend}{controls size of chart legend}
}
\details{
Standard deviations are assumed to be identical for all genes.
See the function \code{\link{ssize.Fvary}} for sample size
calculations with varying standard deviations among genes.
 

If a vector is input for \code{pi0}, sample size calculations 
are performed for each proportion.
}
\value{
  \item{ssize}{sample sizes (for each treatment) at which desired
	power is first reached}
  \item{power}{power calculations with corresponding sample sizes}
  \item{crit.vals}{critical value calculations with corresponding
 	sample sizes}
}
\references{ Liu, Peng and J. T. Gene Hwang. 2007. Quick calculation
  for sample size while controlling false discovery rate with
  application to microarray analysis. \emph{Bioinformatics} 23(6): 739-746. }
\author{Megan Orr \email{megan.orr@ndsu.edu}, Peng Liu \email{pliu@iastate.edu}}
\note{
Powers calculated to be 0 may be negligibly conservative.


Critical values calculated as \sQuote{NA} are values >100.
}
\seealso{\code{\link{ssize.twoSampVary}}, \code{\link{ssize.oneSamp}}, 
	\code{\link{ssize.oneSampVary}}, \code{\link{ssize.F}}, 
	\code{\link{ssize.Fvary}}}
\examples{
 ##Sample size calculation for three-treatment loop design microarray experiment
 ##See Figure S2 of Liu & Hwang (2007)
 des<-matrix(c(1,-1,0,0,1,-1),ncol=2,byrow=FALSE)	##design matrix of loop design experiment
 b<-c(1,-0.5)			##difference between first two treatments is 1 and second and 
                ##third treatments is -0.5
 df<-function(n){3*n-2}		##degrees of freedom for this design is 3n-2
 s<-1				##standard deviation
 a<-0.05			##false discovery rate to be controlled
 pwr1<-0.8			##desired power
 p0<-c(0.5,0.9,0.95,0.995)	##proportions of non-differentially expressed genes
 N1<-20				##maximum sample size for calculations

 ft<-ssize.F(X=des,beta=b,dn=df,sigma=s,fdr=a,power=pwr1,pi0=p0,maxN=N1)
 ft$ssize	##first sample sizes to reach desired power for each proportion of 
            ##non-differentially expressed genes
 ft$power	##power for each sample size
 ft$crit.vals	##critical value for each sample size

}
