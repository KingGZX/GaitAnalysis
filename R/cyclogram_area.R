#### calculate the area of cyclogram ######
#' area of cyclogram
#' @title Area of cyclogram
#'
#' @description The cyclogram area is representative of the conjoint range of joint movements
#'
#' @param ang1 Any body segment joint angle vector.
#' @param ang2 Another body segment joint angle vector.
#' @param len  Length of the input vector
#'
#' @returns A numeric value of the area of cyclogram.
#' @export
#'
#' @examples
#' data(sample)
#' v1 <- sample$hip
#' v2 <- sample$knee
#' len <- length(v1)
#' area(v1, v2, len)
area <- function(ang1, ang2, len) {
  len1 <- length(ang1)
  len2 <- length(ang2)
  if(len1 != len2)
    stop("joint angles length not the same")
  A <- vector()
  for(i in 1:(len-1)) {
    a1 <- ang1[i]*ang2[i+1] - ang2[i]*ang1[i+1]
    A <- c(A, a1)
  }
  return(0.5*sum(A))
}


#### calculate the perimeter of cyclogram ######
#' perimeter of the cyclogram
#' @title perimeter of the cyclogram
#'
#' @description The cyclogram perimeter provides information on the average joint velocity
#'
#' @param ang1 Any body segment joint angle vector.
#' @param ang2 Another body segment joint angle vector.
#' @param len  Length of the input vector
#'
#' @returns A numeric value of the perimeter of cyclogram.
#' @export
#'
#' @examples
#' data(sample)
#' v1 <- sample$hip
#' v2 <- sample$knee
#' len <- length(v1)
#' perimeter(v1, v2, len)
perimeter <- function(ang1, ang2, len) {
  len1 <- length(ang1)
  len2 <- length(ang2)
  if(len1 != len2)
    stop("joint angles length not the same")
  L <- vector()
  for(i in 1:(len-1)) {
    Li <- sqrt((ang1[i]-ang1[i+1])^2 + (ang2[i]-ang2[i+1])^2)
    L <- c(L, Li)
  }
  return(sum(L))
}




