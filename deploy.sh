#!/bin/bash

echo "🎬 OpenFlix - GitHub Pages Deployment"
echo "========================================"

# Build the Flutter web app
echo "🏗️  Building Flutter web app..."
flutter build web --release --base-href "/openflix-client/"

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
    
    # Navigate to build directory
    cd build/web
    
    # Initialize git in build directory
    echo "📦 Preparing deployment..."
    git init
    git add -A
    git commit -m "Deploy OpenFlix to GitHub Pages - $(date '+%Y-%m-%d %H:%M:%S')"
    git branch -M gh-pages
    
    # Push to gh-pages branch
    echo "🚀 Deploying to GitHub Pages..."
    git remote add origin git@github.com:anisha1594/openflix-client.git 2>/dev/null || git remote set-url origin git@github.com:anisha1594/openflix-client.git
    git push -f origin gh-pages
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Deployment successful!"
        echo "🌐 Your app will be live at: https://anisha1594.github.io/openflix-client/"
        echo "⏳ It may take a few minutes for changes to appear"
    else
        echo "❌ Deployment failed. Please check your git credentials."
    fi
else
    echo "❌ Build failed. Please fix errors and try again."
fi

