echo "build static files"
cd $ENKETO_EXPRESS_REPO_DIR
grunt symlink
grunt compile
