
A tailored version of https://github.com/COINtoolbox/AMADA_shiny for KiDS

Download AMADA compatible KiDS catalogues from here http://great.roe.ac.uk/data/protected/KiDS/GAMA_DR2_KIDS/amada including a random catalogue example.

## AMADA

Welcome to the AMADA - Analysis of Muldimensional Astronomical DAtasets - for KiDS 

AMADA for KiDS allows an iterative exploration and information retrieval of the high-dimensional data set in the KiDS catalogue.
This is done by performing a hierarchical clustering analysis for different choices of correlation matrices and by doing a principal components analysis
in the original data. Additionally, AMADA provides a set of modern  visualization data-mining diagnostics.  The user can switch between them using the different tabs. 

###  Data Input
  
AMADA allows the users to either use available datasets or upload their own.   Check the bottom of the 'Import Dataset' panel to see if the data have been properly imported. The data can be seen on the screen by clicking in the tab "Dataset" on the main page. 

#### Import dataset

 Data must be imported as a CSV/TXT format, columns are named and  separated by  spaces.
It may contain an arbitrary number of columns and rows. If missing data is present, it should be marked as NA. An example of how a dataset should be formatted can be found by clicking the tab "Dataset" on the main page.

### Control Options

On the left panel, the user can choose among different methods of analysis and visualization. Once the combination is chosen, click on the button "Make it so" to update the plots. The following options are available:

**Fraction of data to display**: choose the percentage of data displayed on the screen. 

 **Correlation method**: choose among *Pearson*, *Spearman* or *Maximum Information Coefficient (MIC)*. 

 **Display numbers**: choose if correlation coefficients should be displayed in the heatmap. 

**Dendrogram type**: choose among *Phylogram*, *Cladogram* or *Fan*.

**Graph layout**: choose among *Spring* or *Circular*.

 **Chord diagram colour**: choose among different colour schemes. 


 **Number of PCs**: choose the number or principal components to display as Nightingale charts. 

 **PCA method**: choose among *Standard PCA* or *Robust PCA*. 


### Employed  Analysis 


The current version of AMADA allows the user to choose among different types of correlation methods and PCA analysis.  

#### Principal Components Analysis


 **PCA**: A orthogonal  transformation that linearly converts  a  dataset into a set of uncorrelated  variables called principal components (PCs). The PCs are computed by diagonalization of the data correlation matrix, with the resulting eigenvectors corresponding to PCs and the resulting
eigenvalues to the variance explained by the PCs.
The eigenvector corresponding to the largest eigenvalue gives the direction
of greatest variance (PC1), the second largest eigenvalue gives the direction
of the next highest variance (PC2), and so on (e.g., [Jolliffe 2002](http://www.springer.com/statistics/statistical+theory+and+methods/book/978-0-387-95442-4)). 

 **Robust PCA**:  Robust  principal component analysis using the Projection–Pursuit principle. The data is projected on  a lower-dimensional space such that a robust measure of variance of the projected data will be maximized ([Croux, Filzmoser and Oliveira, 2007](http://www.sciencedirect.com/science/article/pii/S016974390700007X)). 

#### Hierarchical Clustering
An unsupervised learning technique whose aim is to find hidden structures  in the dataset. 
Instead of find a single partitioning of the
data, the goal of hierarchical clustering is to build a hierarchy of partitions which may reveal interesting structure in the dataset at multiple levels of association. A clear advantage is the needless of a prior specification of the number of clusters to be searched.
Nonetheless, the method implicitly  assumes a measure of similarity between pairs of objects. Which in our case is given by the correlation distance d(x,y)= 1-|corr(x,y)|. The outcome is a hierarchical representations in which
the clusters at each level of the hierarchy are created by merging clusters
at the next lower level.
We employ an agglomerative approach, which starts with a single cluster assigned for each object and then
progressively merge the two closest clusters until a single cluster remains.

**Number of Clusters**:  To guide the user, we  display an optimal number of clusters via [Calinski and Harabasz, 1972](http://www.tandfonline.com/doi/abs/10.1080/03610927408827101#.VFtZ_77ZLlc) index. The groups are  color-coded  in the dendrogram and graph visualizations.


#### Correlation Method

**Pearson**: a measure of the linear correlation  between two variables X and Y ([Pearson  1895](http://adsabs.harvard.edu/abs/1895RSPS...58..240P)).

**Spearman**: a measure of the monotonic  correlation  between two variables X and Y 
([Spearman 1904](http://www.jstor.org/stable/1412159?origin=JSTOR-pdf)).

**Maximum Information Coefficient**: a measure of linear or non-linear correlation  between two variables X and Y ([Reshef et al. 2011](http://www.sciencemag.org/content/334/6062/1518)). The current version of MIC does not support NA.



### Visualization
AMADA offers many different plots to represent the results of the  correlation analysis and unsupervised learning of the datasets.


The user can choose any of the following plots:


**Heatmap**: Plots a correlation matrix color-coded by the correlation level between each pair of variables (e.g., [Raivo Kolde, 2013](http://CRAN.R-project.org/package=pheatmap)). For visualization purposes, the arrangement of the rows and columns are made following a hierarchical clustering with a dendrogram drawn at the edges of the matrix.

**Distogram**: Plots  a distance  matrix  containing the distances, taken pairwise, of  all sets of variables (e.g., [Aron Eklund,  2012](http://www.cbs.dtu.dk/~eklund/squash/)). The distance being used is the correlation distance, given by d(x,y)= 1-|corr(x,y)|. 

**Dendrogram**:  Plots the dendrogram of the hierarchical clustering applied to the catalog variables. Options are: Phylogram, Cladogram or Fan. This type of visualization is adapted from  tools for  Phylogenetic studies
(e.g., [Paradis et al. 2003](http://bioinformatics.oxfordjournals.org/content/20/2/289.abstract)). 

**Graph**: Plots a clustered graph built in such way that each vertice represent a different parameter and the thickness of the edges are weighted by the degree of correlation between each pair of variables ([Epskamp et al. 2012](http://www.jstatsoft.org/v48/i04/)). The configuration is such that highly correlated parameters appear closer in the graph.

**Chord diagram**: Plots a matrix using a  circular layout. The columns and rows are represented by segments around the circle. Individual cells are shown as ribbons, which connect the corresponding row and column segments ([Gu, Z. (2014)](http://bioinformatics.oxfordjournals.org/content/early/2014/06/14/bioinformatics.btu393)). The  thickness of the ribbons  are weighted by the degree of correlation between each pair of variables. For a given choice of colour pallete, the colour intensity ranges from fully anti-correlated to correlated.   


**Nightingale chart**: Plots a polar barplot. The length of the strips represents  the relative contribution of  each variable to the *i-th* Principal Component. This plot  is inspired by the original chart from  [Nightingale 1858](http://www.florence-nightingale-avenging-angel.co.uk/Nightingale_Hockey_Stick.pdf).  
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
[mvtnorm](http://CRAN.R-project.org/package=mvtnorm),
[circlize](http://CRAN.R-project.org/package=circlize)


