# Data Visualization Course Work Directory

## Project Organization

This directory is your personal workspace for all course work. You are responsible for keeping it organized and following the naming conventions.

### Directory Structure

We use a flat structure in the `work/` directory to avoid path complexity:

```
work/
├── data/             # Data directory (gitignored)
├── example_*         # Learning examples
├── ps1_*             # Problem set 1
├── ps2_*             # Problem set 2
├── ps3_*             # Problem set 3
├── final_project_*   # Final project
└── shared_*          # Shared resources
```

### Naming Conventions

* `example_*`: Learning examples and practice
* `ps1_*`, `ps2_*`, `ps3_*`: Problem sets
* `final_project_*`: Final project work
* `shared_*`: Resources shared between problem sets and final project

### File Management

* All data files should be stored in the `data/` directory
* The `data/` directory is gitignored to protect sensitive information
* Use the `here` package for file paths:
  ```r
  library(here)
  read_csv(here("data", "file.csv"))
  ```

### Version Control

* The `.gitignore` file prevents sensitive data from being committed
* Never commit:
  * Raw data files
  * Personal information
  * Large binary files
  * Temporary files

### Best Practices

1. Keep your work organized
2. Follow the naming conventions
3. Document your structure
4. Use relative paths with `here`
5. Never commit sensitive data 