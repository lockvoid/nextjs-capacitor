#!/bin/bash

# Step 1: Install dependencies
echo "Installing dependencies..."
npm install || yarn install

# Step 2: Build LockvoidCapacitorNativeNavigation plugin
echo "Building LockvoidCapacitorNativeNavigation plugin..."
npm run build -w packages/capacitor-native-navigation

# Step 3: Switch to NextJS application directory
echo "Switching to NextJS application directory..."
cd packages/nextjs-app

# Step 4: Install Pods
echo "Installing Pods..."
npx cap sync

# Step 5: Run NextJS application
echo "Running NextJS application..."
npm run dev &

# Step 6: Open ios/App/App.xcworkspace
echo "Opening ios/App/App.xcworkspace..."
open ios/App/App.xcworkspace

echo "All steps completed successfully! LFG!"
