
# ==========================================
# UNITED KINGDOM CO2 EMISSIONS ANALYSIS
# Study Period: 1990-2024
# Data Source: Our World in Data
# ==========================================

# Clear environment
rm(list = ls())

# Load the filtered dataset
UK_data <- read.csv("data/GBR_co2.csv")

# Arrange data by year
UK_data <- UK_data[order(UK_data$year), ]

# ==========================================
# 1. ANNUAL CO2 EMISSIONS GRAPH
# ==========================================

png("figures/GBR_annual_co2.png",
    width = 1200, height = 800, res = 120)

plot(UK_data$year, UK_data$co2,
     type = "l",
     lwd = 2,
     main = "Annual CO2 Emissions - United Kingdom (1990-2024)",
     xlab = "Year",
     ylab = "CO2 Emissions (Million Tonnes)",
     col = "blue")

dev.off()

# ==========================================
# 2. CO2 EMISSIONS PER CAPITA GRAPH
# ==========================================

png("figures/GBR_per_capita.png",
    width = 1200, height = 800, res = 120)

plot(UK_data$year, UK_data$co2_per_capita,
     type = "l",
     lwd = 2,
     main = "CO2 Emissions Per Capita - United Kingdom (1990-2024)",
     xlab = "Year",
     ylab = "CO2 Per Capita (Tonnes per Person)",
     col = "darkgreen")

dev.off()

# ==========================================
# 3. ANNUAL PERCENTAGE CHANGE GRAPH
# ==========================================

UK_data$annual_change_percent <- c(
  NA,
  diff(UK_data$co2) / head(UK_data$co2, -1) * 100
)

png("figures/GBR_annual_change.png",
    width = 1200, height = 800, res = 120)

plot(UK_data$year, UK_data$annual_change_percent,
     type = "l",
     lwd = 2,
     main = "Annual Percentage Change in CO2 Emissions - United Kingdom",
     xlab = "Year",
     ylab = "Annual Change (%)",
     col = "red")

abline(h = 0, lty = 2)

dev.off()

# ==========================================
# 4. SUMMARY RESULTS
# ==========================================

summary_results <- data.frame(
  country = "United Kingdom",
  iso_code = "GBR",
  first_year = min(UK_data$year),
  last_year = max(UK_data$year),
  first_co2_mt = UK_data$co2[1],
  last_co2_mt = UK_data$co2[nrow(UK_data)],
  endpoint_change_percent =
    (UK_data$co2[nrow(UK_data)] - UK_data$co2[1]) /
    UK_data$co2[1] * 100,
  peak_year = UK_data$year[which.max(UK_data$co2)],
  peak_co2_mt = max(UK_data$co2, na.rm = TRUE),
  latest_co2_per_capita_t =
    UK_data$co2_per_capita[nrow(UK_data)]
)

print(summary_results)

write.csv(
  summary_results,
  "results/GBR_summary.csv",
  row.names = FALSE
)

# ==========================================
# 5. YEARLY CHANGES TABLE
# ==========================================

write.csv(
  UK_data,
  "results/GBR_yearly_changes.csv",
  row.names = FALSE
)

# ==========================================
# 6. SAVE SESSION INFORMATION
# ==========================================

writeLines(
  capture.output(sessionInfo()),
  "results/session_info.txt"
)

# ==========================================
# COMPLETION MESSAGE
# ==========================================

cat("\nANALYSIS COMPLETED SUCCESSFULLY!\n")
cat("Country: United Kingdom\n")
cat("Study Period: 1990-2024\n")
