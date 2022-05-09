---
title: "Group Coursework Assignment"
author: "Dave Matt"
output:
  word_document:
    toc: yes
  html_document:
    number_sections: yes
    toc: yes
    fig_width: 8
    fig_height: 5
    theme: cosmo
    highlight: tango
    code_folding: hide
  pdf_document:
    toc: yes
---

# Tasks:1

  Read and inspect the data set. Provide a descriptive analysis for each of the variables in the data set. 

- **Anwser**

```{r Tasks:1}
# Load packages
library("plotly")
library("tidyverse")
library("data.table")
library("dplyr")
library("gridExtra")
library("knitr")
library("scales")

# Load Cloud Data
df.office <- read_csv("office.csv")
# view first 6 rows of cloud.csv
head(df.office)
# reveal cloud.csv data analysis
str(df.office)
# descriptive analysis of cloud.csv
summary(df.office)
```

# Tasks:2

  Make a new data object (e.g., a data.frame or tibble) for clustering that includes only the attitudinal variables      from the original data set. Then normalise (use z-score standardisation) all variables in this new data object. Which   variable has the smallest minimum value and which variable has the largest maximum value in the normalized data set?

- **Anwser**

```{r Tasks:2}
# make a new data frame with only attitudinal varibales
df.officen <- df.office[,2:7]
head(df.officen)
# Then normalise (use z-score standardisation)
df.officen<-scale(df.officen, center = TRUE, scale = FALSE)
summary(df.officen)
```

  low_prices has the smallest min value of -3.795 
  electronics has the largest maximum value of 5.55

# Tasks:3

  Run the hierarchical clustering algorithm using method = "ward.D2" on the normalised data and use set.seed(123)for     reproducibility. Plot the dendogram.

- **Anwser**

```{r Tasks:3}
set.seed(123)  # Setting seed
Hierar_office <- hclust(dist(df.officen),method = "ward.D2")
Hierar_office
# Plott dendrogram
plot(Hierar_office)

```


# Tasks:4

  Suppose that after looking at the dendrogram and discussing with the marketing department, you decide to proceed      with   a 6-cluster solution. Divide the data points into 6 clusters. How many observations are assigned to each       cluster?

- **Anwser**

```{r Tasks:4}
# 6-cluster solution
Hierar_office_6 <- cutree(Hierar_office, k = 6 )

# display 6-cluster solution
Hierar_office_6
table(Hierar_office_6)
plot.new()
plot(Hierar_office_6)

```




# Tasks:5

  Use the normalised data to calculate the means for each of the attitudinal variables per cluster. Use the flexclust   package to generate a segment profile plot. Comment on whether any cluster memberships have changed, if any. Check    the concordance between the hclust and as.kcca procedures.

- **Anwser**

```{r Tasks:5}
# library flexclust
library(flexclust)
# means for each of the attitudinal variables per cluster
k2 <- kmeans(df.officen, centers = 6, nstart = 20)
str(k2)
k2
k2$size
cl1 <- kcca(df.officen, k=6)
cl1
plot.new()
image(cl1)
points(df.officen)
barplot(cl1)
cl2 <- kcca(df.officen, k=6, family=kccaFamily("kmedians"),
           control=list(initcent="kmeanspp"))
cl2
image(cl2)
points(df.officen)
k2a <- as.kcca(k2, df.officen)
k2a
k2b <- as(k2a, "kmeans")
k2b
```

   All concordance changed
   
# Tasks:6

  Describe the 6-cluster solution using the cluster numbers corresponding to the hierarchical clustering procedure.

- **Anwser**

```{r Tasks:6}

```
  The 6-Cluster Solution visually differentiated the 6 clusters in groups while th heirarchical clustering procedure    was clumsy. 
 
# Tasks:7

  Comment on why you may decide to NOT proceed with this 6-cluster solution.

- **Anwser**

```{r Tasks:7}

```
   The accuracy and qaulity of clustering of the 6-Clustered Solution is impaired after then we may decide not to        proceed with the 6-Cluster solutions
   

# Tasks:8

  Generate a 5-cluster solution. How many observations are assigned to each cluster?

- **Anwser**

```{r Tasks:8}
# 5-cluster solution
Hierar_office_5 <- cutree(Hierar_office, k = 5 )

# display 5-cluster solution
Hierar_office_5
table(Hierar_office_5)

```


# Tasks:9

  Repeat the steps performed previously to describe the clusters for the 5-cluster solution (i.e., calculate cluster    means and segmentation plot). Describe the 5-cluster solution using the cluster numbers corresponding to the          hierarchical clustering procedure. Give “expressive” labels to the clusters.

- **Anwser**

```{r Tasks:9}

k3 <- kmeans(df.officen, centers = 5, nstart = 20)
str(k3)
k3
k3$centers
cl3 <- kcca(df.officen, k=5)
cl3
plot.new()
image(cl3)
points(df.officen)
barplot(cl3)
cl4 <- kcca(df.officen, k=5, family=kccaFamily("kmedians"),
           control=list(initcent="kmeanspp"))
cl4
image(cl4)
points(df.officen)
k3a <- as.kcca(k3, df.officen)
k3a
k3b <- as(k3a, "kmeans")
k3b

```


# Tasks:10

  Comment on why you may find this 5-cluster solution better than the previous 6-cluster solution..

- **Anwser**

```{r Tasks:10}

```
  The 5-Cluster Solution shows more accuracy and detects the similarity better closer to the center

# Tasks:11

  Use all the variables not included in the clustering procedure to evaluate whether the 5-cluster solution is          meaningful. Generate ideas on how to target each segment (at least one idea per segment).

- **Anwser**

```{r Tasks:11}
library(clValid)
rownames(df.officen) <- 1:nrow( df.officen)
stab <- clValid(df.officen, 2:6, clMethods=c("hierarchical","kmeans"),validation="stability")
plot(stab)
intern <- clValid(df.officen, 2:6, clMethods=c("hierarchical","kmeans"),validation="internal")
plot(intern)
summary(intern)
optimalScores(stab)

```


# Tasks:12

  Run the k-means clustering algorithm on the normalised data, creating 5 clusters. Use iter.max = 1000 and nstart =    100 and set.seed(123)for reproducibility. How many observations are assigned to each cluster?

- **Anwser**

```{r Tasks:12}
set.seed(123)
k5 <- kmeans(df.officen, centers = 5, nstart = 100,iter.max = 1000)
k5
k5$size

```


# Tasks:13

  Check the concordance between the hclust and kmeans procedures. What is the Hit Rate?

- **Anwser**

```{r Tasks:13}
k2$clusters
Hierar_office_6
cor.test(k2$cluster,Hierar_office_6)
print(cor.test(k2$cluster,Hierar_office_6))
```
  
