#!/bin/bash
# Script to sync source/lib.typ with template/lib.typ
# Run this after making changes to either file

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

SOURCE_LIB="source/lib.typ"
TEMPLATE_LIB="template/lib.typ"

echo "========================================="
echo "Syncing lib.typ files"
echo "========================================="

# Check if files exist
if [ ! -f "$SOURCE_LIB" ]; then
    echo -e "${RED}ERROR: $SOURCE_LIB not found!${NC}"
    exit 1
fi

if [ ! -f "$TEMPLATE_LIB" ]; then
    echo -e "${RED}ERROR: $TEMPLATE_LIB not found!${NC}"
    exit 1
fi

# Check if files are different
if diff -q "$SOURCE_LIB" "$TEMPLATE_LIB" > /dev/null; then
    echo -e "${GREEN}✓ Files are already synchronized${NC}"
    exit 0
fi

# Files are different, show diff and ask which to use as source
echo -e "${YELLOW}Files differ! Here's the difference (first 50 lines):${NC}"
echo ""
diff -u "$SOURCE_LIB" "$TEMPLATE_LIB" | head -50
echo ""
echo -e "${YELLOW}(Use 'diff -u source/lib.typ template/lib.typ' to see full difference)${NC}"
echo ""

# Determine which was modified more recently
if [ "$SOURCE_LIB" -nt "$TEMPLATE_LIB" ]; then
    NEWER="$SOURCE_LIB"
    OLDER="$TEMPLATE_LIB"
    DEFAULT_CHOICE="1"
else
    NEWER="$TEMPLATE_LIB"
    OLDER="$SOURCE_LIB"
    DEFAULT_CHOICE="2"
fi

echo -e "${YELLOW}Which version should be used?${NC}"
echo "1) Use $SOURCE_LIB (package entrypoint)"
echo "2) Use $TEMPLATE_LIB (standalone template)"
echo "3) Cancel"
echo ""
echo -e "Most recently modified: ${GREEN}$NEWER${NC}"
echo -n "Choice [${DEFAULT_CHOICE}]: "

read CHOICE
CHOICE=${CHOICE:-$DEFAULT_CHOICE}

case $CHOICE in
    1)
        echo -e "${YELLOW}Copying $SOURCE_LIB to $TEMPLATE_LIB...${NC}"
        cp "$SOURCE_LIB" "$TEMPLATE_LIB"
        echo -e "${GREEN}✓ Synchronized! template/lib.typ now matches source/lib.typ${NC}"
        ;;
    2)
        echo -e "${YELLOW}Copying $TEMPLATE_LIB to $SOURCE_LIB...${NC}"
        cp "$TEMPLATE_LIB" "$SOURCE_LIB"
        echo -e "${GREEN}✓ Synchronized! source/lib.typ now matches template/lib.typ${NC}"
        ;;
    3)
        echo "Cancelled."
        exit 0
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

echo ""
echo "Don't forget to test both scenarios:"
echo "  bash testing/test.sh"
echo "  bash testing/test_template_standalone.sh"
