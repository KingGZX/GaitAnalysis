# Load required packages
library(circstats)
library(circular)
library(ggplot2)

# Read in hip-knee joint angle data from a CSV file
joint_angles <- read.csv("hip_knee_angles.csv")

# Convert angles to radians
angles_radians <- joint_angles * pi / 180

# Convert angles to complex numbers
angles_complex <- exp(1i * angles_radians)

# Compute the mean resultant vector
mean_resultant <- mean(angles_complex)

# Compute the circular standard deviation
circular_sd <- sd.circular(angles_complex)

# Compute the circular variance
circular_var <- var.circular(angles_complex)

# Compute the circular-linear correlation
corr <- cor.circular(angles_complex, seq(0, 1, length.out = length(joint_angles)))

# Compute the phase angle
phase_angle <- angle(mean_resultant)

# Plot the phase angle
ggplot(data.frame(t = joint_angles$Time, angle = angles_radians), aes(x = t, y = angle)) +
  geom_point(size = 0.5) +
  geom_hline(yintercept = phase_angle, linetype = "dashed") +
  xlab("Time (s)") +
  ylab("Phase angle (radians)") +
  ggtitle("Hip-Knee Joint Phase Angle") +
  theme_bw()