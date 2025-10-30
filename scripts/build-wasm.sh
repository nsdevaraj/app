#!/bin/bash

# Build all Rust WASM modules
# This script builds each module and places the output in the frontend wasm directory

set -e

echo "🚀 Building Rust WASM modules..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Root directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUST_DIR="$ROOT_DIR/rust-modules"
FRONTEND_WASM_DIR="$ROOT_DIR/frontend/src/wasm"

# Create wasm directory if it doesn't exist
mkdir -p "$FRONTEND_WASM_DIR"

# Array of modules to build
MODULES=("data-engine" "chart-renderer" "query-optimizer" "parallel-compute")

# Build each module
for module in "${MODULES[@]}"; do
    echo -e "${BLUE}Building $module...${NC}"
    
    cd "$RUST_DIR/$module"
    
    # Build with wasm-pack
    wasm-pack build --target web --out-dir "$FRONTEND_WASM_DIR/$module"
    
    echo -e "${GREEN}✓ $module built successfully${NC}"
done

echo ""
echo -e "${GREEN}✓ All WASM modules built successfully!${NC}"
echo ""
echo "Output directory: $FRONTEND_WASM_DIR"
echo ""
echo "Next steps:"
echo "  cd frontend"
echo "  yarn start"
