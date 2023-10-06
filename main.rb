#!/usr/bin/env ruby
# Folder Parameterization & Obsidian Transformation Tool

require 'fileutils'
require 'active_support/core_ext/string'

# Parameterize the directory names using ActiveSupport
def parameterize_directory(directory)
  Dir.glob("#{directory}/**/*").each do |f|
    next if File.basename(f)[0] == '.'  # Skip hidden files/dirs
    parameterized_name = File.basename(f).parameterize
    next if parameterized_name == File.basename(f)

    FileUtils.mv(f, File.join(File.dirname(f), parameterized_name))
  end
end

# Generate a tree from the directory
def generate_tree(directory)
  output_file = "#{directory}_tree.txt"
  system("tree #{directory} > #{output_file}")
  output_file
end

# Convert the tree output to Obsidian-friendly format
def transform_to_obsidian_format(tree_path, output_directory)
  current_dir = nil
  File.readlines(tree_path).each do |line|
    # Assuming tree lines look like: |-- filename or |-- foldername/
    match = line.match(/|-- (.+)/)
    next unless match

    name = match[1].strip

    if name.end_with?("/")
      # It's a directory
      current_dir = name.chomp("/")
      FileUtils.mkdir_p(File.join(output_directory, current_dir.parameterize))
    else
      # It's a file
      content = "[[#{current_dir}]]"
      File.write(File.join(output_directory, "#{name.parameterize}.md"), content)
    end
  end
end

# Paths
folder1 = "/path/to/folder1"
folder2 = "/path/to/folder2"
rdfind_report = "/path/to/rdfind_report.txt"

# 1. Parameterize and Generate Trees
parameterize_directory(folder1)
tree1 = generate_tree(folder1)

parameterize_directory(folder2)
tree2 = generate_tree(folder2)

# Install dependencies (TODO: Improve by OS)
system("sudo apt install tree rdfind")

# 2. Cleanup duplicates using rdfind
system("rdfind -dryrun true #{folder1} > #{rdfind_report}")
system("rdfind -dryrun true #{folder2} >> #{rdfind_report}")
system("rdfind -dryrun true #{folder1} #{folder2} >> #{rdfind_report}")

# 3. Diff trees
diff_output = "/path/to/tree_diff.txt"
system("diff #{tree1} #{tree2} > #{diff_output}")

# 4. Transform to Obsidian-friendly format
obsidian_output1 = "/path/to/obsidian_output1"
obsidian_output2 = "/path/to/obsidian_output2"
transform_to_obsidian_format(tree1, obsidian_output1)
transform_to_obsidian_format(tree2, obsidian_output2)

puts "All steps completed. Check rdfind report at #{rdfind_report} and diff output at #{diff_output}."
