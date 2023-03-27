library(readxl)
library(tidyverse)
sample <- read_excel("sample.xlsx")


v1 <- sample$hip
v2 <- sample$knee
v3 <- sample$ankle


#### calculate the coupling angle ######
#' Phase-angle plot
#'
#' @param ang1 Hip angle vector.
#' @param ang2 Knee angle vector.
#' @returns A phase_angle figure.
#' @export
#' @examples
#' phase_angle(c(31.1977, 30.14246, 29.17131), c(22.40979, 24.59055, 26.00155))
phase_angle <- function(ang1, ang2) {
  v1_d <- diff(ang1)
  v2_d <- diff(ang2)
  v_mag <- sqrt(v1_d ^ 2 + v2_d ^ 2)
  cosang <- v1_d / v_mag
  sinang <- v2_d / v_mag
  rad <- 180 / 3.14159
  phsang <- atan2(sinang, cosang) * rad
  n <- length(v1_d)
  for (i in 1:n) {
    if (phsang[i] < 0) {
      phsang[i] <- phsang[i] + 360
    }
  }
  ts.plot(phsang)

  return(phsang)

}
pa <- phase_angle(v1, v2)


########### plot the angle-angle plot############
ang_ang_plot <- function(ang1, ang2) {
  angle <- data.frame(A1 = ang1,
                      A2 = ang2,
                      time = 1:length(v1))
  ang_l <- gather(angle, angle, joint, -time)
  ggplot(angle, aes(y = A1, x = A2)) + geom_point(aes(col = time), size = 4) +
    scale_colour_gradientn(colours = rainbow(7)) + theme_bw()
}
ang_ang_plot(v1, v2)


###get the ratio of phases #####
phase_ratio <- function(pa) {
  pr <-
    sum(pa >= 0 &
          pa < 22.5) + sum(pa >= 157.5 &
                             pa < 202.5) + sum(pa >= 337.5 & pa < 360)
  in_phase <-
    sum(pa >= 22.5 & pa < 67.5) + sum(pa > 202.5 & pa < 247.5)
  di <- sum(pa >= 67.5 & pa < 112.5) + sum(pa >= 247.5 & pa < 292.5)
  anti <-
    sum(pa >= 112.5 & pa < 157.5) + sum(pa >= 292.5 & pa < 337.5)
  phase <-
    data.frame(
      pr = pr,
      in_phase = in_phase,
      di = di,
      anti = anti
    ) * 100 / (pr + in_phase + di + anti)
  return(phase)
}
phase_ratio(pa)


###get the ratio of phases for multiple trials/ subject and provide a boxplot #####
phase_ratio_multi <- function(df) {
  P_angs <- apply(angle, 2, phase_ratio)
  P_angs_df <- do.call(rbind, a)
  boxplot(P_angs_df)
  return(P_angs_df)

}

############calculate the variability ###########

CAV <- function(df) {
  rad <- 180 / 3.14159
  n_trial <- ncol(df)
  bar_CA <- vector()
  bar_x <- apply(df, 1, cos) %>% colMeans()
  bar_y <- apply(df, 1, sin) %>% colMeans()

   for(i in 1:length(bar_x)) {
    if(bar_x[i] > 0 & bar_y[i] > 0) {
      bar_CA[i] <- atan(bar_x[i] / bar_y[i]) * rad
    } else if(bar_x[i] < 0) {
      bar_CA[i] <- atan(bar_x[i] / bar_y[i]) * rad + 180
    } else if(bar_x[i] > 0 & bar_y[i] < 0) {
      bar_CA[i] <- atan(bar_x[i] / bar_y[i]) * rad + 360
    } else if(bar_x[i]  == 0 & bar_y[i] > 0) {
      bar_CA[i] = 90
    } else if(bar_x[i]  == 0 & bar_y[i] < 0) {
      bar_CA[i] = -90
    }
   }
  return(bar_CA)
}
CAV(df)
ts.plot(CAV(df))
