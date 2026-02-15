#!/bin/bash
set -e

echo "Deploying _site to gh-pages branch..."

# Build the site if _site doesn't exist
if [ ! -d "_site" ]; then
    echo "_site directory not found. Please run ./scripts/build.sh first."
    exit 1
fi

# Create a temporary directory for deployment
DEPLOY_DIR=$(mktemp -d)
cp -r _site/* "$DEPLOY_DIR"

# Initialize a new git repo in the deploy directory
cd "$DEPLOY_DIR"
git init
git add .
git commit -m "Deploy site updates"

# Force push to the gh-pages branch of the remote repo
# Assuming 'origin' and the current repo URL. You might need to adjust this.
REMOTE_URL=$(git -C "$PROJECT_ROOT" config --get remote.origin.url)
git push --force "$REMOTE_URL" master:gh-pages

echo "Deployed to gh-pages!"
rm -rf "$DEPLOY_DIR"
