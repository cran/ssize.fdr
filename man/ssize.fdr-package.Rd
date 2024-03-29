\name{ssize.fdr-package}
\alias{ssize.fdr-package}
\alias{ssize.fdr}
\docType{package}
\title{Sample Size Calculations for Microarray Experiments}
\description{
 This package calculates appropriate sample sizes for one-sample,
 two-sample, and multi-sample microarray experiments for a desired power
 of the test.  Sample sizes are calculated under controlled false
 discovery rates and fixed proportions of non-differentially expressed
 genes. Outputs a graph of power versus sample size.
}
\details{
\tabular{ll}{
Package: \tab ssize.fdr\cr
Type: \tab Package\cr
Version: \tab 1.3\cr
Date: \tab 2022-06-05\cr
License: \tab GPL-3\cr
}
 For all functions, the user inputs the desired power, the false
 discovery rate to be controlled, the proportion(s) of non-
 differentially expressed genes, and the maximum possible sample size
 to be used in calculations. If the user inputs a vector of proportions
 of non-differentially expressed genes, samples size calculations are
 performed for each proportion. For the function \code{\link{ssize.twoSamp}},
 the user must additionally input the common difference in mean treatment
 expressions as well as the common standard deviation for all genes.
 This becomes the common effect size and common standard deviation for
 all genes when using the function \code{\link{ssize.oneSamp}}. For the
 function \code{\link{ssize.twoSampVary}} (\code{\link{ssize.oneSampVary}})
 the differences in mean treatment expressions (effect sizes) are assumed
 to follow a normal distribution and the variances among genes are assumed
 to follow an inverse gamma distribution, so parameters for these
 distributions must be entered. For the function \code{\link{ssize.F}},
 the design matrix of the experiment, the parameter vector, and an optional
 coefficient matrix or vector of linear contrasts of interest must also be
 entered. The function \code{\link{ssize.Fvary}} allows the variances of
 the genes to follow an inverse gamma distribution, so the shape and scale
 parameters must be specified by the user.

}
\author{Megan Orr <megan.orr@ndsu.edu>, Peng Liu <pliu@iastate.edu>}
\references{Liu, Peng and J. T. Gene Hwang. 2007. Quick calculation for
 sample size while controlling false discovery rate with application
 to microarray analysis. \emph{Bioinformatics} 23(6): 739-746.}
\keyword{ package }
\examples{

 a<-0.05	##false discovery rate to be controlled
 pwr<-0.8	##desired power
 p0<-c(0.5,0.9,0.95)	##proportions of non-differentially expressed genes
 N<-20; N1<-35	##maximum sample size for calculations


 ##Example of function ssize.oneSamp
 d<-1		##effect size
 s<-0.5  	##standard deviation
 os<-ssize.oneSamp(delta=d,sigma=s,fdr=a,power=pwr,pi0=p0,maxN=N,side="two-sided")
 os$ssize	##first sample sizes to reach desired power
 os$power	##calculated power for each sample size
 os$crit.vals	##calculated critical value for each sample size


 ##Example of function ssize.oneSampVary
 dm<-2;  ds<-1	##the effect sizes of the genes follow a Normal(2,1) distribution
 alph<-3;  beta<-1	##the variances of the genes follow an Inverse Gamma(3,1) distribution.
 osv<-ssize.oneSampVary(deltaMean=dm,deltaSE=ds,a=alph,b=beta,fdr=a,power=pwr,
 pi0=p0,maxN=N1,side="two-sided")
 osv$ssize	##first sample sizes to reach desired power
 osv$power	##calculated power for each sample size
 osv$crit.vals	##calculated critical value for each sample size


 ##Example of function ssize.twoSamp
 ##Calculates sample sizes for two-sample microarray experiments
 ##See Figure 1.(a) of Liu & Hwang (2007)
 d1<-1		##difference in differentially expressed genes to be detected
 s1<-0.5  	##standard deviation
 ts<-ssize.twoSamp(delta=d1,sigma=s1,fdr=a,power=pwr,pi0=pi,maxN=N,side="two-sided")
 ts$ssize	##first sample sizes to reach desired power
 ts$power	##calculated power for each sample size
 ts$crit.vals	##calculated critical value for each sample size


 ##Example of function ssize.twoSampVary
 ##Calculates sample sizes for multi-sample microarray experiments in which both the differences in
   ##expressions between treatments and the standard deviations vary among genes.
 ##See Figure 3.(a) of Liu & Hwang (2007)
 dm<-2		##mean parameter of normal distribution of differences
 ##between treatments among genes
 ds<-1		##standard deviation parameter of normal distribution
 ##of differences between treatments among genes
 alph<-3	##shape parameter of inverse gamma distribution followed
 ##by standard deviations of genes
 beta<-1	##scale parameter of inverse gamma distribution followed
 ##by standard deviations of genes
 tsv<-ssize.twoSampVary(deltaMean=dm,deltaSE=ds,a=alph,b=beta,
 fdr=a,power=pwr,pi0=p0,maxN=N1,side="two-sided")
 tsv$ssize	##first sample sizes to reach desired power
 tsv$power	##calculated power for each sample size
 tsv$crit.vals	##calculated critical value for each sample sizesv


 ##Example of function ssize.F
 ##Sample size calculation for three-treatment loop design microarray experiment
 ##See Figure S2. of Liu & Hwang (2007)
 des<-matrix(c(1,-1,0,0,1,-1),ncol=2,byrow=FALSE)	##design matrix of loop design experiment
 b<-c(1,-0.5)			##difference between first two treatments is 1 and
 ##second and third treatments is -0.5
 df<-function(n){3*n-2}		##degrees of freedom for this design is 3n-2
 s<-1				##standard deviation
 p0.F<-c(0.5,0.9,0.95,0.995)	##proportions of non-differentially expressed genes

 ft<-ssize.F(X=des,beta=b,dn=df,sigma=s,fdr=a,power=pwr,pi0=p0.F,maxN=N)
 ft$ssize	##first sample sizes to reach desired power
 ft$power	##calculated power for each sample size
 ft$crit.vals	##calculated critical value for each sample sizeft$ssize


 ##Example of function ssize.Fvary
 ##Sample size calculation for three-treatment loop design microarray experiment
 des<-matrix(c(1,-1,0,0,1,-1),ncol=2,byrow=FALSE)	##design matrix of loop design experiment
 b<-c(1,-0.5)			##difference between first two treatments is 1 and
 ##second and third treatments is -0.5
 df<-function(n){3*n-2}		##degrees of freedom for this design is 3n-2
 alph<-3;beta<-1	##variances among genes follow an Inverse Gamma(3,1)
 a1<-0.05	##fdr to be fixed
 p0.F<-c(0.9,0.95,0.995)		##proportions of non-differentially expressed genes

 ftv<-ssize.Fvary(X=des,beta=b,dn=df,a=alph,b=beta,fdr=a1,power=pwr,pi0=p0,maxN=N1)
 ftv$ssize	##first sample sizes to reach desired power
 ftv$power	##calculated power for each sample size
 ftv$crit.vals	##calculated critical value for each sample sizeft$ssize

}
