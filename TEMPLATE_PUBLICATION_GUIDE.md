# Template Publication Guide

This guide explains how to test the template locally and prepare it for publication to the Typst package repository.

## Local Testing

### Prerequisites

1. **Install Typst** (version 0.13.1 or later)
   - Download from: https://github.com/typst/typst/releases
   - On Linux:
     ```bash
     curl -fsSL https://github.com/typst/typst/releases/download/v0.13.1/typst-x86_64-unknown-linux-musl.tar.xz -o typst.tar.xz
     tar -xf typst.tar.xz
     sudo mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/
     typst --version
     ```

2. **Internet connectivity** for downloading external packages

### Running Tests

From the repository root, run:

```bash
bash testing/test.sh
```

This script will:
- ✓ Verify Typst installation and version
- ✓ Check all required template files are present
- ✓ List external package dependencies
- ✓ Create and compile a test document
- ✓ Test all custom functions (caption, todo, subfigure)
- ✓ Generate a PDF output

### Manual Testing

You can also test the template manually:

```bash
# Compile the example template
cd template
typst compile main.typ output.pdf
```

Or test from the testing directory:

```bash
cd testing
typst compile example.typ example.pdf
```

## Package Repository Requirements

To publish this template to the Typst package repository, ensure:

### 1. Required Files

- ✅ `typst.toml` - Package manifest with metadata
- ✅ `source/lib.typ` - Main template entrypoint
- ✅ `template/` - Template files for "Start from template" feature
- ✅ `LICENSE` - MIT license file
- ✅ `README.md` - Documentation

### 2. Package Manifest (typst.toml)

The `typst.toml` file must contain:

```toml
[package]
name = "ut-thesis-clean"           # Unique package name
version = "0.1.0"                  # Semantic version
entrypoint = "source/lib.typ"      # Main file path
authors = [...]                     # Author information
license = "MIT"                     # License identifier
repository = "..."                  # GitHub repository URL
keywords = [...]                    # Searchable keywords
categories = ["thesis"]             # Package category
compiler = "0.13.1"                # Minimum Typst version
```

### 3. Template Directory Structure

For the "Start from template" feature in the Typst web app:

```
template/
├── main.typ                 # Main document file
├── chapters/                # Chapter files
│   ├── 1 title-page.typ
│   ├── 2 declaration.typ
│   └── ...
├── bibliography.bib         # Bibliography database
└── nature_squarebrackets.csl # Citation style
```

### 4. External Dependencies

Declare all external packages in `source/lib.typ`:

```typ
#import "@preview/hydra:0.6.2"
#import "@preview/subpar:0.2.2"
```

These will be automatically downloaded by Typst when users install your package.

## .gitignore vs .typstignore

### .gitignore

The `.gitignore` file controls which files Git excludes from version control. Current exclusions:

- Test artifacts (`test_document.typ`, `test_output.pdf`, etc.)
- Build artifacts (`typst.tar.xz`, compiled binaries)
- Editor files (`.vscode/`, `.idea/`, `*.swp`)
- OS files (`.DS_Store`, `Thumbs.db`)

**Purpose**: Keeps the repository clean by excluding temporary, generated, and platform-specific files.

### .typstignore

A `.typstignore` file is **NOT currently necessary** for this template because:

1. **Package Publishing**: When submitting to the Typst package repository, you explicitly specify which files to include. The repository system doesn't package your entire Git repository.

2. **Local Compilation**: Typst only processes files that are explicitly imported or referenced in your documents. Extraneous files don't affect compilation.

3. **Template Usage**: When users install the package with `#import "@preview/ut-thesis-clean:0.1.0"`, they only get the files specified in the package submission.

**When you WOULD need .typstignore**:

- If you have large binary files in your repository that slow down local compilation
- If you have conflicting `.typ` files that might be accidentally imported
- If you're using Typst's built-in file watching features and want to exclude certain directories

For now, the `.gitignore` file is sufficient for this template.

## Publication Steps

### 1. Pre-Publication Checklist

- [ ] All tests pass (`bash testing/test.sh`)
- [ ] Template compiles successfully
- [ ] `README.md` is complete and accurate
- [ ] `LICENSE` file is present
- [ ] `typst.toml` metadata is correct
- [ ] Version number follows semantic versioning
- [ ] All custom functions are documented
- [ ] Example template works correctly

### 2. Prepare for Submission

1. **Clean the repository**:
   ```bash
   git status
   # Ensure no uncommitted test artifacts
   ```

2. **Test the package locally**:
   ```bash
   # Create a test directory outside the repo
   mkdir /tmp/test-template
   cd /tmp/test-template
   
   # Create a test document that imports the package
   # (This tests the package structure)
   ```

3. **Verify package structure**:
   - `source/lib.typ` exports all necessary functions
   - `template/` contains a complete working example
   - No absolute paths in imports

### 3. Submit to Package Repository

1. **Create a Git tag**:
   ```bash
   git tag v0.1.0
   git push origin v0.1.0
   ```

2. **Submit via the Typst package submission process**:
   - Visit: https://github.com/typst/packages
   - Follow the contribution guidelines
   - Create a pull request to add your package

3. **Package Review**:
   - The Typst team will review your submission
   - Address any feedback or requested changes
   - Once approved, your package will be published

### 4. After Publication

Users can then use your template in two ways:

**Method 1: Import as a package**
```typ
#import "@preview/ut-thesis-clean:0.1.0": *
// Use template functions
```

**Method 2: Start from template** (in Typst web app)
- Click "Start from template"
- Search for "ut-thesis-clean"
- All template files are copied to the new project

## Updating the Template

When making updates:

1. Increment version in `typst.toml` (follow semantic versioning)
2. Update `README.md` changelog
3. Run all tests
4. Create a new Git tag
5. Submit updated package

## Additional Resources

- Typst Package Repository: https://github.com/typst/packages
- Typst Documentation: https://typst.app/docs
- Package Guidelines: https://github.com/typst/packages/blob/main/CONTRIBUTING.md
