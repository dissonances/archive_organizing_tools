## Folder Parameterization & Obsidian Transformation Tool

### Introduction

This Ruby script assists users in:

1. Parameterizing folder and file names within specified directories.
2. Generating tree outputs for given directories.
3. Cleaning up duplicates with the assistance of `rdfind`.
4. Creating a difference report between two directory trees.
5. Converting the directory tree into an Obsidian-friendly format, transforming folders and files into Markdown links.

### Prerequisites

1. Ensure Ruby is installed on your system.
2. The `activesupport` gem should be installed. You can install it using:
   ```bash
   gem install activesupport
   ```
3. The utilities `tree` and `rdfind` should be present on your system.

### Usage

1. Clone this repository or download the script.
2. Modify the paths in the script (`folder1`, `folder2`, `rdfind_report`, `diff_output`, `obsidian_output1`, `obsidian_output2`) to suit your directory structure.
3. Run the script using:
   ```bash
   ruby main.rb
   ```

### How It Works

1. **Parameterization**: The script starts by standardizing the names of files and folders. Names are converted into a URL-friendly format, ensuring a standardized naming convention.
   
2. **Tree Generation**: The tree structure of the specified folders is generated and saved into a file.
   
3. **Duplicate Cleanup**: Utilizing `rdfind`, the script identifies duplicates within and across the specified directories. A report is generated for reference.
   
4. **Diff Generation**: A difference report between the trees of the two directories is created to identify disparities.
   
5. **Obsidian Transformation**: The tree structure is converted into an Obsidian-friendly format, enabling users to visualize folder structures as interlinked Markdown files.

### Limitations

- The current implementation assumes certain tree formatting and may need adjustments based on the specific `tree` version or OS.
- Parameterization is based on `ActiveSupport`, which handles a wide range of characters, but specific edge cases might need additional handling.

### Contributions

Feedback and pull requests are welcome. If you encounter any issues or have suggestions for improvements, please open an issue.
