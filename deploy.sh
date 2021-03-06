#!/bin/bash
set -x

yarn build

# Configure Git to only push the current branch
git config --global push.default simple

# Remove .gitignore and replace with the production version
rm -f .gitignore
cp prodignore .gitignore
cat .gitignore

# Add the Linode production server as a remote repository
git remote add production ssh://travisci@45.79.35.9:/root/travisExample.git

# Add and commit all the static files generated by the Gatsby build
git add . && git commit -m "React build"

# Push all changes to the Linode production server
git push -f production HEAD:refs/heads/master