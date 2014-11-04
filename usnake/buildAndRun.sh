#!/bin/bash
echo "Building micro snake"
javac USnake.java
if [ $? -eq 0 ]; then
    echo "Successful! :)"
    java -cp . USnake
else
    echo "Build failed."
    exit 1
fi
