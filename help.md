## AMADA

Welcome to the AMADA - Analysis of Muldimensional Astronomical DAtasets 

AMADA allows an iterative exploration and information retrieval of high-dimensional data sets.
This is done by performing a hierarchical clustering analysis for different choices of correlation matrices and by doing a principal components analysis
in the original data. Additionally, AMADA provides a set of modern  visualization data-mining diagnostics.  The user can switch between them using the different tabs. 



###  Data Input
  
AMADA allows the users to either use available datasets or upload their own.   Check the bottom of the 'Import Dataset' panel to see if the data have been properly imported. The data can be seen on the screen by clicking in the tab "Dataset" on the main page. 

#### Available datasets

The enclosed datasets  are examples following the same nomenclature of  their respective source 
articles. I suggest the user to check the original articles or catalogs for a better understanding of
their meaning.

* Supernova host properties ([Table 1, Sako, M. et al. 2014](http://adsabs.harvard.edu/abs/2014arXiv1401.3317S)): Type Ia and II  Supernova host-galaxy  properties  from  Sloan Digital Sky Survey  multi-band photometry.

* Mock galaxy catalog ([Guo et al. 2011](http://adsabs.harvard.edu/abs/2011MNRAS.413..101G)): Galaxy semi-analytic  formation models build on top of  the Millennium  ([Springel et al. 2005](http://adsabs.harvard.edu/abs/2003MNRAS.339..312S)) and Millenium II simulations ([Boylan-Kolchin et al. 2009](http://adsabs.harvard.edu/abs/2009MNRAS.398.1150B)). 

* [ZENS catalog](http://www.astro.ethz.ch/carollo/research/ZENS) ([Carollo et al. 2012](http://arxiv.org/abs/1206.5807), [Cibinel et al. 2012](http://arxiv.org/abs/1206.6108), [Cibinel et al. 2013](http://adsabs.harvard.edu/cgi-bin/bib_query?arXiv:1206.6496)): The Zurich ENvironmental Study (ZENS) is a survey of galaxy groups in the local universe.  The  sample consists of 141 groups in the  redshift range 0.05 < z < 0.0585.
    


#### Import dataset

 Data must be imported as a CSV/TXT format, columns are named and  separated by  spaces.
It may contain an arbitrary number of columns and rows. If missing data is present, it should be marked as NA.

### Control Options

On the left panel, the user can choose among different methods of analysis and visualization. Once the combination is chosen, click on the button "make it so" to update the plots. 

**Fraction of data to display** choose the percentage of data displayed on the screen. 

 **Correlation method**: *pearson*, *spearman* or *maximum information coefficient*. 

 **Display numbers** choose if correlation coefficients should be displayed in the heatmap. 

**Dendrogram type**: *phylogram*, *cladrogram* or *fan*.

**Graph layout**: *spring* or *circular*.

 **Number of PCs** choose the number or principal components to display as Nightingale charts. 

 **PCA method**: *standard PCA* or *robust PCA*. 


### Employed  Analysis 


The current version of AMADA allows the user to choose among different types of correlation methods and PCA analysis.  

#### Principal Components Analysis


 **PCA** A orthogonal  transformation that linearly convert  a  dataset into a set of uncorrelated  variables called principal components (PCs). The PCs are computed by diagonalization of the data correlation matrix, with the resulting eigenvectors corresponding to PCs and the resulting
eigenvalues to the variance explained by the PCs.
The eigenvector corresponding to the largest eigenvalue gives the direction
of greatest variance (PC1), the second largest eigenvalue gives the direction
of the next highest variance (PC2), and so on (e.g., [Jolliffe 2002](http://www.springer.com/statistics/statistical+theory+and+methods/book/978-0-387-95442-4)). 

 **Robust PCA**  Robust  principal component analysis using the Projection–Pursuit principle. The data is projected on  a lower-dimensional space such that a robust measure of variance of the projected data will be maximized ([Croux, Filzmoser and Oliveira, 2007](http://www.sciencedirect.com/science/article/pii/S016974390700007X)). 

#### Hierarchical Clustering

One of the advantages of hierarchical clustering is the needless of a prior specification of the number of clusters to be searched. Instead, the method requires a measurement of dissimilarity between groups of observations, which is  based
on the pairwise dissimilarities among the observations within each of  two groups. The outcome is a  hierarchical representations in which
the clusters at each level of the hierarchy are created by merging clusters
at the next lower level. 
We employ an  agglomerative approach. Initially each variable is assigned to its own cluster, then the method   recursively merges a selected pair of
clusters into a single cluster, where each  new pair composed by  merging  the two
groups with the smallest  dissimilarity in the immediately  lower level. 

**Number of Clusters**  To guide the user, we  display an optimal number of clusters via [Calinski and Harabasz, 1972](http://www.tandfonline.com/doi/abs/10.1080/03610927408827101#.VFtZ_77ZLlc) index. The groups are  color-coded  in the dendrogram and graph visualizations.


#### Correlation Method

**Pearson** a measure of the linear correlation  between two variables X and Y ([Pearson  1895](http://adsabs.harvard.edu/abs/1895RSPS...58..240P)).

**Spearman** a measure of the monotonic  correlation  between two variables X and Y 
([Spearman 1904](http://www.jstor.org/stable/1412159?origin=JSTOR-pdf)).

**Maximum Information Coefficient** a measure of linear or non-linear correlation  between two variables X and Y ([Reshef et al. 2011](http://www.sciencemag.org/content/334/6062/1518)). The current version of MIC does not support NA.



### Visualization

AMADA offers many different plots to analyze your data set  using correlation analysis and unsupervised learning. 

These are the standard types of plots:


**Heatmap** Plots a correlation matrix color-coded by the correlation level between each pair of variables (e.g., [Raivo Kolde, 2013](http://CRAN.R-project.org/package=pheatmap)). 

**Distogram** Plots  a distance  matrix  containing the distances, taken pairwise, of a all sets of variables (e.g., [Aron Eklund,  2012](http://www.cbs.dtu.dk/~eklund/squash/)). The distance being used is the correlation distance, given by d(x,y)= 1-|corr(x,y)|. 

**Dendrogram**  Plots the dendrogram of the hierarchical clustering applied to the catalog variables. Options are: Phylogram, Cladrogram or Fan. This type visualization is adapted from  tools for  Phylogenetic studies
(e.g., [Paradis et al. 2003](http://bioinformatics.oxfordjournals.org/content/20/2/289.abstract)). 

**Graph** Plots a  clustered graph is built in which vertices represent features  and edge widths  are weighted by the degree of correlation between each pair or variables ([Epskamp et al. 2012](http://www.jstatsoft.org/v48/i04/)). 

**Nightingale chart** Plots a polar barplot whose lenght of the strips displays  the relative contribution of  each variable to the *i-th* Principal Component. This plot  is inspired by the original chart from  [Nightingale 1858](http://www.florence-nightingale-avenging-angel.co.uk/Nightingale_Hockey_Stick.pdf).  
*Probably one of the most influential visualizations of all time used by  Florence Nightingale to convince Queen Victoria about improving hygiene at military hospitals, therefore  saving lives of  thousands of soldiers.*

### References
R Core Team (2014). R: A language and environment for statistical computing. R
Foundation for Statistical Computing, Vienna, Austria. URL [http://www.R-project.org/](http://www.
-project.org/).

#### Package dependencies

[ape](http://bioinformatics.oxfordjournals.org/content/20/2/289.abstract),
[phytools](http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210X.2011.00169.x/abstract),
[squash](http://CRAN.R-project.org/package=squash),
[fpc](http://CRAN.R-project.org/package=fpc),
[minerva](http://CRAN.R-project.org/package=minerva),
[MASS](http://www.stats.ox.ac.uk/pub/MASS4),
[corrplot](http://CRAN.R-project.org/package=corrplot),
[qgraph](http://www.jstatsoft.org/v48/i04/),
[ggplot2](http://had.co.nz/ggplot2/book),
[ggthemes](http://CRAN.R-project.org/package=ggthemes),
[reshape](http://www.jstatsoft.org/v21/i12/paper),
[pcaPP](http://CRAN.R-project.org/package=pcaPP),
[mvtnorm](http://CRAN.R-project.org/package=mvtnorm)


