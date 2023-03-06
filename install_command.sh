#!/bin/bash

# Set the path to the idea.sh script
IDEA_SH="$(pwd)/idea.sh"

# Create the alias to open the current directory in IntelliJ IDEA
alias ideadir="$IDEA_SH ."

# Create the alias to open a file or directory in IntelliJ IDEA
alias openjava="ideafile > /dev/null 2>&1 &"

# Define the function to open a file or directory in IntelliJ IDEA
function ideafile() {
    # Get the absolute path to the file or directory
    if [ $# -eq 0 ]; then
        file_path=$(realpath ".")
    else
        file_path=$(realpath "$1")
    fi

    # Check if it's a directory or a file
    if [ -d "$file_path" ]; then
        "$IDEA_SH" "$file_path"
    elif [ -f "$file_path" ]; then
        # Open the file in IntelliJ IDEA
        "$IDEA_SH" "$file_path"
    else
        echo "File or directory not found: $file_path"
    fi
}

# Save the aliases and function to the .bashrc file
echo "alias ideadir='$IDEA_SH .'" >> ~/.bashrc
echo "alias openjava='ideafile > /dev/null 2>&1 &'" >> ~/.bashrc
echo "function ideafile() {
    if [ \$# -eq 0 ]; then
        file_path=\$(realpath \".\")
    else
        file_path=\$(realpath \"\$1\")
    fi

    if [ -d \"\$file_path\" ]; then
        $IDEA_SH \"\$file_path\"
    elif [ -f \"\$file_path\" ]; then
        $IDEA_SH \"\$file_path\"
    else
        echo \"File or directory not found: \$file_path\"
    fi
}" >> ~/.bashrc

# Reload the .bashrc file
source ~/.bashrc

echo "The ideadir and openjava commands have been added to your shell environment."
