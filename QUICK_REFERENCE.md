# Quick Reference Card

## Testing Commands

```bash
# Test everything (from repository root)
bash testing/test.sh
bash testing/test_template_standalone.sh

# Sync lib.typ files after editing
bash testing/sync_lib.sh

# Full compilation test (requires internet)
cd template && typst compile main.typ output.pdf
```

## Key Files to Know

| File | Purpose |
|------|---------|
| `source/lib.typ` | Package entrypoint (for import) |
| `template/lib.typ` | Standalone template copy (must match source/) |
| `typst.toml` | Package metadata |
| `testing/test.sh` | Repository structure test |
| `testing/test_template_standalone.sh` | Standalone template test |

## Critical Reminders

⚠️ **Always keep `source/lib.typ` and `template/lib.typ` identical**
- Use `bash testing/sync_lib.sh` to synchronize them

⚠️ **Template files must use relative paths**
- ✅ `#import "lib.typ": *` (in main.typ)
- ✅ `#import "../lib.typ": *` (in chapters/)
- ❌ `#import "source/lib.typ": *` (breaks standalone)

⚠️ **Test both scenarios before releases**
- Repository test: `bash testing/test.sh`
- Standalone test: `bash testing/test_template_standalone.sh`

## Pre-Release Checklist

- [ ] Run `bash testing/test.sh` - passes ✓
- [ ] Run `bash testing/test_template_standalone.sh` - passes ✓
- [ ] Check lib.typ files are identical: `diff source/lib.typ template/lib.typ`
- [ ] Update version in `typst.toml`
- [ ] Test compilation with network
- [ ] Review generated PDF
- [ ] Create git tag: `git tag v0.X.Y`
- [ ] Push tag: `git push origin v0.X.Y`

## Publication Steps

1. **Local Testing**
   ```bash
   bash testing/test.sh
   bash testing/test_template_standalone.sh
   cd template && typst compile main.typ output.pdf
   ```

2. **Create Release**
   ```bash
   git tag v0.1.0
   git push origin v0.1.0
   ```

3. **Submit to Typst**
   - Visit: https://github.com/typst/packages
   - Follow CONTRIBUTING.md
   - Create pull request

## Common Issues

**Problem:** Template doesn't work standalone
**Solution:** Check import paths don't reference `source/`

**Problem:** lib.typ files out of sync
**Solution:** Run `bash testing/sync_lib.sh`

**Problem:** Tests fail
**Solution:** Ensure running from repository root, not testing/ directory

**Problem:** Network errors during compilation
**Solution:** Normal on first run; Typst downloads external packages

## Documentation Files

| File | What It Answers |
|------|-----------------|
| `ANSWER_TO_QUESTIONS.md` | All original questions |
| `FINAL_SUMMARY.md` | Complete overview of everything |
| `TESTING_SUMMARY.md` | Testing details |
| `TEMPLATE_PUBLICATION_GUIDE.md` | Publication process |
| `GITIGNORE_VS_TYPSTIGNORE.md` | .gitignore explanation |

## External Dependencies

- `@preview/hydra:0.6.2` - Document headers
- `@preview/subpar:0.2.2` - Subfigure support

Auto-downloaded by Typst on first compilation (requires internet).

## Template Status

✅ **READY FOR PUBLICATION**

All tests passing, all issues fixed, documentation complete.

---

*Keep this file as quick reference for template maintenance*
