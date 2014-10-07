echo "start pm2"
. $ENKETO_EXPRESS_NODE_ENV/bin/activate

pm2 describe enketo || pm2 start $ENKETO_EXPRESS_REPO_DIR/app.js -n enketo
