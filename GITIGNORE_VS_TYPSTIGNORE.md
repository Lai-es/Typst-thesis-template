# .gitignore vs .typstignore: What You Need to Know

## TL;DR

**For this template: You only need `.gitignore`, not `.typstignore`.**

## What is .gitignore?

`.gitignore` tells Git which files to exclude from version control. This keeps your repository clean by preventing temporary, generated, and platform-specific files from being committed.

### Current .gitignore for this template:

```gitignore
# Test artifacts
test_document.typ
test_output.pdf
test_functions.pdf

# Build artifacts
typst.tar.xz
typst-x86_64-unknown-linux-musl/

# Editor artifacts
.vscode/
.idea/
*.swp
*.swo
*~

# OS artifacts
.DS_Store
Thumbs.db
```

### Why we need .gitignore:

1. **Test artifacts** - Generated PDFs and temporary test files
2. **Build artifacts** - Downloaded compiler binaries
3. **Editor files** - IDE configuration directories
4. **OS files** - System-generated thumbnails and metadata

These files are not needed in the repository and would cause clutter and merge conflicts.

## What is .typstignore?

`.typstignore` would tell Typst which files to ignore during compilation and package operations. However, **Typst doesn't currently have a `.typstignore` file** as a standard feature.

### Why .typstignore is NOT needed for this template:

1. **Package Publishing**
   - When you submit to the Typst package repository, you explicitly specify which files to include
   - The repository doesn't automatically package your entire Git repo
   - Only the files you declare are distributed to users

2. **Local Compilation**
   - Typst only processes files that are explicitly imported in your documents
   - Having extra files in your directory doesn't slow down compilation
   - Typst won't accidentally compile or include unrelated `.typ` files

3. **Template Distribution**
   - When users "Start from template", they only get the `template/` directory contents
   - The `.gitignore` file is not distributed to users
   - Test files and build artifacts are already excluded by Git

### When you MIGHT want something like .typstignore:

If Typst implements a `.typstignore` feature in the future, it would be useful for:

- **Large binary files** that slow down file watching
- **Conflicting .typ files** that might be accidentally imported
- **Build directories** when using file watching features
- **Test directories** with many test documents

## Current Best Practices

For this template repository:

1. ✅ **Use .gitignore** to keep the Git repository clean
2. ✅ **Structure matters** - Keep template files in `template/` directory
3. ✅ **Test isolation** - Test files in `testing/` directory
4. ✅ **Package metadata** - `typst.toml` specifies what gets published

## File Organization Strategy

```
typst-thesis-template-ut/
├── .gitignore              # Excludes build/test artifacts from Git
├── source/
│   └── lib.typ             # Package entrypoint (for package import)
├── template/
│   ├── lib.typ             # Local copy (for standalone template)
│   ├── main.typ
│   └── chapters/
└── testing/
    ├── test.sh             # Not distributed to users
    └── example.typ         # Not distributed to users
```

When users install the package: They get `source/lib.typ`  
When users start from template: They get `template/` contents (including `template/lib.typ`)  
When developers clone the repo: They get everything except `.gitignore` exclusions

## Conclusion

The `.gitignore` file is **necessary and sufficient** for this template project. A `.typstignore` file is **not needed** because:

- Git already handles version control exclusions
- Typst package publishing uses explicit file inclusion
- Local compilation only processes imported files
- Template distribution only copies the template directory

If you're maintaining this template, just keep the `.gitignore` file updated with any new test artifacts or build outputs.
