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

# Authenticate with GitHub CLI
#gh auth login

# Navigate to the repository
cd $REPO_PATH || { echo "Repository path not found!"; exit 1; }
gh repo set-default KishoreKumar77/Github-Examproco

# Create the pull request
PR_URL=$(gh pr create --base $BASE_BRANCH --head $COMPARE_BRANCH --title "$PR_TITLE" --body "$PR_BODY" --assignee @me)

if [ -z "$PR_URL" ]; then
    echo "Failed to create the pull request"
    exit 1
fi

# Extract the PR number from the URL
PR_NUMBER=$(basename $PR_URL)

# Approve the pull request
gh pr review $PR_NUMBER --approve

# Merge the pull request
gh pr merge $PR_NUMBER --merge

echo "Pull request #$PR_NUMBER has been created, approved, and merged successfully."
