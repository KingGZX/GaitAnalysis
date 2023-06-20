library(readxl)
library(tidyverse)
# sample <- read_excel("./sample.xlsx")



# v1 <- sample$hip
# v2 <- sample$knee
# v3 <- sample$ankle
# angle <- data.frame()


#### calculate the coupling angle ######
#' coupling angle plot
#' @title phase_angle
#'
#' @description waited to read the paper
#'
#' @param ang1 Any body segment joint angle vector.
#' @param ang2 Another body segment joint angle vector.
#'
#' @returns A phase_angle figure.
#' @export
#' @import readxl tidyverse grDevices graphics stats
#'
#' @examples
#' data(sample)
#' v1 <- sample$hip
#' v2 <- sample$knee
#' v3 <- sample$ankle
#' phase_angle(v1, v2)
phase_angle <- function(ang1, ang2) {
  len1 <- length(ang1)
  len2 <- length(ang2)
  if(len1 != len2)
    stop("joint angles length not the same")
  v1_d <- diff(ang1)
  v2_d <- diff(ang2)
  v_mag <- sqrt(v1_d ^ 2 + v2_d ^ 2)
  cosang <- v1_d / v_mag
  sinang <- v2_d / v_mag
  rad <- 180 / 3.14159  # rad = deg / pi
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
# pa <- phase_angle(v1, v2)


########### plot the angle-angle plot############
#' angle-angle plot
#' @title ang_ang_plot
#'
#' @param ang1 Hip angle vector.
#' @param ang2 Knee angle vector.
#' @returns A angle_angle figure.
#'
#' @importFrom grDevices rainbow
#' @importFrom graphics boxplot
#' @importFrom stats time ts.plot
#' @importFrom ggplot2 ggplot aes geom_point theme_bw scale_colour_gradientn
#' @importFrom tidyr gather
#'
#' @export
#' @examples
#'
#' v1 <- sample$hip
#' v2 <- sample$knee
#' v3 <- sample$ankle
#' ang_ang_plot(v1, v2)
ang_ang_plot <- function(ang1, ang2) {
  len1 <- length(ang1)
  len2 <- length(ang2)
  if(len1 != len2)
    stop("joint angles length not the same")
  angle <- data.frame(A1 = ang1,
                      A2 = ang2,
                      time = 1:length(ang1)) # use 'ang1' to replace v1, otherwise, shape doesn't match in examples # nolint: line_length_linter.
  ang_l <- gather(angle, angle, "joint", -time) #ignore time
  # print(ang_l)
  ggplot(angle, aes(y = angle$A1, x = angle$A2)) + geom_point(aes(col = time), size = 4) +
    scale_colour_gradientn(colours = rainbow(7)) + theme_bw()
}
# ang_ang_plot(v1, v2)


###get the ratio of phases #####
#' phase-ratio statistics
#'
#' @title phase_ratio
#'
#' @param pa phase-angle vector.
#' @returns A phase-ratio dataframe.
#' @export
#'
#' @examples
#' data(sample)
#' v1 <- sample$hip
#' v2 <- sample$knee
#' v3 <- sample$ankle
#' pa <- phase_angle(v1, v2)
#' phase_ratio(pa)
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
# phase_ratio(pa)


###get the ratio of phases for multiple trials/ subject and provide a boxplot #####

# phase_ratio_multi <- function(df) {
#  P_angs <- apply(angle, 2, phase_ratio)
#  P_angs_df <- do.call(rbind, a)
#  boxplot(P_angs_df)
#  return(P_angs_df)
# }
# df <- sample
# phase_ratio_multi(df)

############calculate the variability ###########
#' CAV plot
#'
#' @title CAV
#'
#' @param df hip, ankle, knee dataframe
#' @returns A variability plot
#'
#' @importFrom dplyr %>%
#' @importFrom stats ts.plot
#'
#' @export
#'
#' @examples
#' data(sample)
#' v1 <- sample$hip
#' v2 <- sample$knee
#' v3 <- sample$ankle
#' df <- sample
#' CAV(df)
#' ts.plot(CAV(df))
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

# df <- sample
# CAV(df)
# ts.plot(CAV(df))
