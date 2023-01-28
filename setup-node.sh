#!/bin/sh

if [ $# -ne 1 ]; then
  echo "指定された引数は$#個です。" 1>&2
  exit 1
fi

mkdir $1
cd $1
npm init -y
npm install --save-dev husky prettier eslint @typescript-eslint/eslint-plugin @typescript-eslint/parser esbuild dotenv 
touch .eslintignore .eslintrc.json .prettierrc .env .gitignore README.web_modules
mkdir src
touch src/index.ts

cat <<EOF > README.md
# $1
GetStart

```bash
gh repo create
```
EOF
cat <<EOF > .eslintignore
node_modules
EOF

cat <<EOF > .eslintrc.json
{
    "parser": "@typescript-eslint/parser",
    "parserOptions": { "ecmaVersion": "latest", "sourceType": "module" },
    "extends": ["plugin:@typescript-eslint/recommended"],
    "env": {
        "node": true
    },
    "rules": {}
}
EOF

cat <<EOF > .prettierrc
{
  "semi": false,
  "trailingComma": "all",
  "singleQuote": false,
  "printWidth": 120,
  "tabWidth": 4
}
EOF


cat <<EOF > .gitignore
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*

# Diagnostic reports (https://nodejs.org/api/report.html)
report.[0-9]*.[0-9]*.[0-9]*.[0-9]*.json

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov

# Coverage directory used by tools like istanbul
coverage
*.lcov

# nyc test coverage
.nyc_output

# Grunt intermediate storage (https://gruntjs.com/creating-plugins#storing-task-files)
.grunt

# Bower dependency directory (https://bower.io/)
bower_components

# node-waf configuration
.lock-wscript

# Compiled binary addons (https://nodejs.org/api/addons.html)
build/Release

# Dependency directories
node_modules/
jspm_packages/

# Snowpack dependency directory (https://snowpack.dev/)
web_modules/

# TypeScript cache
*.tsbuildinfo

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Optional stylelint cache
.stylelintcache

# Microbundle cache
.rpt2_cache/
.rts2_cache_cjs/
.rts2_cache_es/
.rts2_cache_umd/

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variable files
.env
.env.development.local
.env.test.local
.env.production.local
.env.local

# parcel-bundler cache (https://parceljs.org/)
.cache
.parcel-cache

# Next.js build output
.next
out

# Nuxt.js build / generate output
.nuxt
dist

# Gatsby files
.cache/
# Comment in the public line in if your project uses Gatsby and not Next.js
# https://nextjs.org/blog/next-9-1#public-directory-support
# public

# vuepress build output
.vuepress/dist

# vuepress v2.x temp and cache directory
.temp
.cache

# Docusaurus cache and generated files
.docusaurus

# Serverless directories
.serverless/

# FuseBox cache
.fusebox/

# DynamoDB Local files
.dynamodb/

# TernJS port file
.tern-port

# Stores VSCode versions used for testing VSCode extensions
.vscode-test

# yarn v2
.yarn/cache
.yarn/unplugged
.yarn/build-state.yml
.yarn/install-state.gz
.pnp.*
EOF


# esbuildの準備
npm pkg set scripts.dev="esbuild src/index.ts --bundle --platform=node --outfile=index.js && node index.js"
npm pkg set scripts.build="esbuild src/index.ts --bundle --platform=node --outfile=index.js"
npm pkg set scripts.format="eslint src/**/*.ts --fix"
npm pkg set scripts.pretty="prettier --write \"src/**/*.ts\""

git init --initial-branch main

# huskyの準備
npm pkg set scripts.prepare="husky install"
npm run prepare
npx husky add .husky/pre-commit "npm run format && npm run pretty"
