\name{ssize.Fvary}
\alias{ssize.Fvary}
\title{Sample Size Calculations for Multi-Sample Microarray Experiments
	with Differing Variances among Genes}
\description{
  This function calculates appropriate sample sizes for multi-sample
  microarray experiments in which standard deviations vary among genes.
  Sample sizes are determined based on a desired power, a  controlled
  false discovery rate, and user-specified proportions of
  non-differentially expressed genes and design matrix. A graph of
  power versus sample size is created.
}
\usage{
ssize.Fvary(X, beta, L = NULL, dn, a, b, fdr = 0.05, power = 0.8, pi0 = 0.95, 
            maxN = 20, cex.title=1.15, cex.legend=1)
}
\arguments{
  \item{X}{design matrix of experiment}
  \item{beta}{parameter vector}
  \item{L}{coefficient matrix or vector for linear contrasts of 
	interest}
  \item{dn}{a function of the degrees of freedom based on the design
	 of the experiment}
  \item{a}{shape parameter of inverse gamma distribution followed by
	variances of genes}
  \item{b}{scale parameter of inverse gamma distribution followed by
	variances of genes}
  \item{fdr}{the false discovery rate to be controlled}
  \item{power}{the desired power to be achieved}
  \item{pi0}{a vector (or scalar) of proportions of non-differentially 
	expressed genes}
  \item{maxN}{the maximum sample size used for power calculations}
  \item{cex.title}{controls size of chart titles}
  \item{cex.legend}{controls size of chart legend}
}
\details{
The variances among genes are assumed to follow an Inverse Gamma
distribution with shape parameter \code{a} and scale parameter
\code{b}.


If a vector is input for \code{pi0}, sample size calculations 
are performed for each proportion.
}
\value{
  \item{ssize}{sample sizes (for each treatment) at which desired power 
	is first reached}
  \item{power}{power calculations with corresponding sample sizes}
  \item{crit.vals}{critical value calculations with corresponding sample
	 sizes}
}
\references{ Liu, Peng and J. T. Gene Hwang. 2007. Quick calculation for
  sample size while controlling false discovery rate with application 
  to microarray analysis. \emph{Bioinformatics} 23(6): 739-746. }
\author{Megan Orr \email{megan.orr@ndsu.edu}, Peng Liu \email{pliu@iastate.edu}}
\note{
Numerical integration used in calculations performed by the function 
\code{\link{integrate}}, which uses adaptive quadrature of functions.


Powers calculated to be 0 may be negligibly conservative.


Critical values calculated as \sQuote{NA} are values >100.
}
\seealso{\code{\link{ssize.twoSamp}}, \code{\link{ssize.twoSampVary}}, 
	\code{\link{ssize.oneSamp}}, \code{\link{ssize.oneSampVary}}, 
	\code{\link{ssize.F}}}
\examples{
 ##Sample size calculation for three-treatment loop design microarray experiment
 des<-matrix(c(1,-1,0,0,1,-1),ncol=2,byrow=FALSE)	##design matrix of loop design experiment
 b<-c(1,-0.5)			##difference between first two treatments is 1 and second and third 
               ##treatments is -0.5
 df<-function(n){3*n-2}		##degrees of freedom for this design is 3n-2
 alph<-3;beta<-1	##variances among genes follow an Inverse Gamma(3,1)
 a1<-0.05	##fdr to be fixed
 pwr<-0.8	##desired power
 p0<-c(0.9,0.95,0.995)		##proportions of non-differentially expressed genes
 N1<-35		##maximum sample size to be used in calculations

 ftv<-ssize.Fvary(X=des,beta=b,dn=df,a=alph,b=beta,fdr=a1,power=pwr,pi0=p0,maxN=N1)
 ftv$ssize	##first sample sizes to reach desired power
 ftv$power	##calculated power for each sample size
 ftv$crit.vals	##calculated critical value for each sample sizeft$ssize

}
