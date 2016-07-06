
build:
	npm run build
	rm -rf dist
	mkdir -p dist
	NODE_ENV=development ./node_modules/.bin/browserify index.js --standalone=dva -u react -u react-dom -g browserify-shim -t envify > dist/dva.js
	NODE_ENV=development ./node_modules/.bin/browserify router.js --standalone=dva.router -u react -u react-dom -g browserify-shim -t envify > dist/router.js
	NODE_ENV=development ./node_modules/.bin/browserify fetch.js --standalone=dva.fetch -u react -u react-dom -g browserify-shim -t envify > dist/fetch.js
	NODE_ENV=development ./node_modules/.bin/browserify effects.js --standalone=dva.effects -u react -u react-dom -g browserify-shim -t envify > dist/effects.js
	./node_modules/.bin/uglifyjs -o dist/dva-min.js dist/dva.js
	./node_modules/.bin/uglifyjs -o dist/router-min.js dist/router.js
	./node_modules/.bin/uglifyjs -o dist/fetch-min.js dist/fetch.js
	./node_modules/.bin/uglifyjs -o dist/effects-min.js dist/effects.js

publish:
	make build
	npm publish

publish-sync: publish
	cnpm sync dva
	tnpm sync dva
