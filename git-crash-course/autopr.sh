#!/bin/bash

# Variables - Customize these as needed
REPO_PATH="/workspaces/Github-Examproco"
BASE_BRANCH="main"
COMPARE_BRANCH="test"
PR_TITLE="Updated file"
PR_BODY="Updated file"

# Ensure GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) could not be found. Installing..."
    sudo apt update
    sudo apt install -y gh
fi

# Navigate to the repository
cd $REPO_PATH || { echo "Repository path not found!"; exit 1; }
git checkout test
git add . ; git commit -m "updated pr script"; git push -u origin test
gh repo set-default KishoreKumar77/Github-Examproco

# Create the pull request
PR_URL=$(gh pr create --base $BASE_BRANCH --head $COMPARE_BRANCH --title "$PR_TITLE" --body "$PR_BODY")

if [ -z "$PR_URL" ]; then
    echo "Failed to create the pull request"
    exit 1
fi

# Extract the PR number from the URL
PR_NUMBER=$(awk -F/ '{print $NF}' <<< $PR_URL)

# Merge the pull request
gh pr merge $PR_NUMBER --merge

echo "Pull request #$PR_NUMBER has been created, and merged successfully."
