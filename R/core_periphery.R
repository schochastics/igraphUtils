#' Discrete core-periphery model
#' @description Fits a discrete core-periphery model to a give network
#' @param graph igraph object.
#' @param method algorithm to use (see details)
#' @param iter number of iterations for SA optimization
#' @details The function fits the data to an optimal pattern matrix with simulated annealing (method="SA") or a rank 1 approximation, either with degree centrality (method="rk1_dc") or eigenvector centrality (method="rk1_ec") . The rank 1 approximation is computationally far cheaper but also more experimental. Best is to compare the results from both models.
#' @return list with numeric vector with entries (k1,k2,...ki...) where ki assigns vertex i to either the core (ki=1) or periphery (ki=0), and the maximal correlation with an optimal pattern matrix
#' @references
#' Borgatti, Stephen P., and Martin G. Everett. "Models of core/periphery structures." Social networks 21.4 (2000): 375-395.
#' @author David Schoch
#' @export
core_periphery <- function(graph,method="rk1_dc",iter=5000){
  A <- igraph::as_adj(graph,type = "both",sparse = FALSE)
  if(method=="SA"){
    n <- nrow(A)
    cvec <- sample(0:1,n,replace = TRUE)
    res <- stats::optim(par = cvec, fn = cp_fct1__0, A = A,gr = genperm,method = "SANN",
                 control = list(maxit = iter, temp = 10, tmax = 100, trace = FALSE,
                                REPORT = 5))
    return(list(vec=res$par,corr=-res$value))
  } else if(method=="rk1_dc"){
    ev <- igraph::degree(graph,mode="all",loops = FALSE)

    thresh <- unique(ev)
    optcorr <- -2

    for(tr in thresh){
      evabs <- (ev>=tr)+0
      E <- outer(evabs,evabs,"+")
      E[E==1] <- NA
      E[E==2] <- 1
      diag(E) <- NA
      if(sum(E,na.rm = TRUE)==0){
        next()
      }
      tmp <- suppressWarnings(graph_cor(E,A))
      if(is.na(tmp)){
        next()
      }
      if(tmp>optcorr){
        optperm <- evabs
        optcorr <- tmp
      }
    }
    return(list(vec = optperm,corr=optcorr))
  }else if(method=="rk1_ec"){
    ev <- round(igraph::evcent(graph)$vector,8)

    thresh <- unique(ev)
    optcorr <- -2

    for(tr in thresh){
      evabs <- (ev>=tr)+0
      E <- outer(evabs,evabs,"+")
      E[E==1] <- NA
      E[E==2] <- 1
      diag(E) <- NA
      if(sum(E,na.rm = TRUE)==0){
        next()
      }
      tmp <- suppressWarnings(graph_cor(E,A))
      if(is.na(tmp)){
        next()
      }
      if(tmp>optcorr){
        optperm <- evabs
        optcorr <- tmp
      }
    }
    return(list(vec = optperm,corr=optcorr))
  } else{
    stop("method must be one of 'SA' and 'rk1'")
  }
}


#helper functions ----
cp_fct1110 <- function(A,cvec){ #core=1 periphery=0
  delta <- outer(cvec,cvec,function(x,y) x==1 | y==1 )
  -sum(A*delta,na.rm = TRUE)
}

cp_fct1__0 <- function(A,cvec){ #core=1 periphery=0
  delta <- outer(cvec,cvec,function(x,y) x+y)
  delta[delta==1] <- NA
  delta[delta==2] <- 1
  diag(delta) <- NA
  # -sum(A*delta,na.rm = TRUE)
  -graph_cor(delta,A)
}

genperm <- function(A,cvec){
  # 1=switch between values, 2= switch two nodes
  what <- sample(1:2,1,prob = c(0.5,0.5))
  if(what==1){
    v <- sample(1:length(cvec),1)
    cvec[v] <- 1-cvec[v]
  } else if(what==2){
    core <- which(cvec==1)
    pery <- which(cvec==0)
    v <- sample(core,1)
    w <- sample(pery,1)
    cvec[v] <- 0
    cvec[w] <- 1
  } else{

  }
  cvec
}


genperm_switch <- function(A,cvec){
  core <- which(cvec==1)
  pery <- which(cvec==0)
  v <- sample(core,1)
  w <- sample(pery,1)
  cvec[v] <- 0
  cvec[w] <- 1
  cvec
}


# Rombach/Porter
# a <- 0.99
# b <- 0.2
# iter <- 5000
# trans_vec <- trans_fct(a,b,n)
# plot(trans_vec)
# perm <- sample(1:n)
#
# res <- stats::optim(par = perm, fn = cp_rombach, A = A,trans_vec = trans_vec,gr = genpermN,method = "SANN",
#                     control = list(maxit = iter, temp = 10, tmax = 100, trace = TRUE,
#                                    REPORT = 5))
#
# plot(trans_vec[res$par],degree(g))
#
# genpermN <- function(A,trans_vec,perm){
#   uv <- sample(perm,2)
#   u <- uv[1]
#   v <- uv[2]
#   tmp <- perm[u]
#   perm[u] <- perm[v]
#   perm[v] <- tmp
#   perm
# }
#
# cp_rombach <- function(A,trans_vec,perm){
#   -sum(A*outer(trans_vec[perm],trans_vec[perm],"*"))
# }
#
# trans_fct <- function(a,b,n){
#   csize <- floor(b*n)
#   nseq <- 1:n
#   c(nseq[1:csize]*(1-a)/(2*csize),
#     (nseq[(csize+1):n]-csize)*(1-a)/(2*(n-csize))+(1+a)/2
#   )
# }


#CONCOR
# VecFun <- Vectorize( cor )
# system.time({
#   for(k in 1:10){
#     M <- outer(M_rows, M_rows, VecFun)
#     M_rows <- split(M, row(M))
#   }
# })
