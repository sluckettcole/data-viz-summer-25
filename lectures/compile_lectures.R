#!/usr/bin/env Rscript

# Configuration
OUTPUT_DIR <- "slides"  # Change this to your desired output directory

# List of required packages
required_packages <- c(
  "quarto",    # For rendering Quarto documents
  "fs",        # For file system operations
  "glue",      # For string interpolation
  "cli",       # For command-line interface
  "here"       # For path handling
)

# Function to install packages if they're not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    message(sprintf("Installing %s...", pkg))
    install.packages(pkg, repos = "https://cloud.r-project.org")
  }
}

# Install all required packages
message("Checking and installing required packages...")
for (pkg in required_packages) {
  install_if_missing(pkg)
}

# Load required packages
library(quarto)
library(fs)
library(glue)
library(cli)
library(here)

# Function to compile a single lecture
compile_lecture <- function(lecture_file, output_dir) {
  # Get the day number from the path
  day_num <- path_file(path_dir(lecture_file))
  
  # Create output directory if it doesn't exist
  dir_create(here(output_dir), recurse = TRUE)
  
  # Store original working directory
  old_wd <- getwd()
  
  cli_alert_info("Compiling {lecture_file}")
  tryCatch({
    # Change to the directory containing the lecture file
    setwd(path_dir(lecture_file))
    
    # Create _site directory if it doesn't exist
    dir_create("../_site", recurse = TRUE)
    
    # Render the file
    quarto_render(
      path_file(lecture_file),
      output_format = "html"
    )
    
    # Define source and target paths
    source_path <- path("..", "_site", day_num, paste0(day_num, "_lecture.html"))
    target_path <- path(here(output_dir), paste0(day_num, ".html"))
    
    # Check if source file exists
    if (!file_exists(source_path)) {
      cli_alert_danger("Source file not found at {source_path}")
      return()
    }
    
    # Copy the file from _site to the final output directory
    file_copy(
      source_path,
      target_path,
      overwrite = TRUE
    )
    
    # Copy site_libs directory if it exists
    site_libs_source <- path("..", "_site", "site_libs")
    site_libs_target <- path(here(output_dir), "site_libs")
    
    if (dir_exists(site_libs_source)) {
      dir_create(site_libs_target, recurse = TRUE)
      file_copy(
        site_libs_source,
        path_dir(site_libs_target),
        overwrite = TRUE,
        recursive = TRUE
      )
    }
    
    cli_alert_success("Successfully compiled {lecture_file} to {target_path}")
  }, error = function(e) {
    cli_alert_danger("Failed to compile {lecture_file}: {e$message}")
  }, finally = {
    # Restore the original working directory
    setwd(old_wd)
  })
}

# List of lecture files to compile
lecture_files <- c(
  here("lectures", "day_1", "day_1_lecture.qmd"),
  here("lectures", "day_2", "day_2_lecture.qmd"),
  here("lectures", "day_3", "day_3_lecture.qmd")
)

# Create main output directory if it doesn't exist
dir_create(here(OUTPUT_DIR), recurse = TRUE)

# Compile each lecture
cli_h1("Compiling Lectures")
for (file in lecture_files) {
  compile_lecture(file, OUTPUT_DIR)
}

cli_h1("Compilation Complete")
cli_alert_info("All lectures have been compiled to the {OUTPUT_DIR} directory")
