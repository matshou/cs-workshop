#!/bin/bash
target=Projects
echo "Copying xcf project files..."
find Sunday -name '*.xcf' -exec cp --parents {} $target \;
echo "Copying blend project files..."
find Sunday -name '*.blend' -exec cp --parents {} $target \;
