
<!-- README.md is generated from README.Rmd. Please edit that file -->

# netUtils

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

netUtils is a collection of network analytic (convenience) functions
that may not deserve a package on their own and/or are missing from
other network packages.

## Installation

You can install the development version of netUtils with:

``` r
# install.packages("remotes")
remotes::install_github("schochastics/netUtils")
```

## Functions

*(The functions listed below are just a sample of the available
methods)*  
most functions only support igraph objects

**helper/convenience functions**  
`biggest_component()` extract the biggest connected component of a
network.  
`delete_isolates()` delete vertices with degree zero.  
`bipartite_from_data_frame()` create a two mode network from a data
frame.  
`clique_vertex_mat()` compute the clique vertex matrix

**methods**  
`graph_kpartite()` create a random k-partite network.  
`dyad_census_attr()` calculate dyad census with vertex attributes.  
`triad_census_attr()` calculate triad census with vertex attributes.  
`structural_equivalence()` finds structurally equivalent vertices.
