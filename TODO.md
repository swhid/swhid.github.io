# SWHID Monorepo - TODO List

## 🎯 High Priority Items


### Pagefind Search Integration
**Goal:** Implement local Pagefind search without section selector

**Tasks:**
- [ ] Research Pagefind integration options
- [ ] Configure Pagefind to index all content locally
- [ ] Create search results page that shows all results
- [ ] Add section-based filtering (Specification, News, Publications, etc.)
- [ ] Implement search UI without the dropped search selector
- [ ] Ensure search works across all monorepo content
- [ ] Test search functionality and performance

**Files to create/modify:**
- Search configuration files
- `overrides/partials/search-results.html`
- `overrides/assets/javascripts/search.js`
- Update `mkdocs.yml` for search integration

---


### Styling and UX Enhancements
**Goal:** Improve visual consistency and user experience

**Tasks:**
- [ ] Ensure SWH color scheme is consistently applied
- [ ] Test responsive design across devices
- [ ] Optimize loading performance
- [ ] Improve accessibility features
- [ ] Test version selector functionality
- [ ] Verify navigation works correctly

---

## 📋 Implementation Notes

### Search Implementation:
- Local Pagefind index (no external dependencies)
- Global search across all content
- Section-based filtering for refined results
- Clean, intuitive search interface

---

## 🎯 Success Criteria

- [ ] Search works locally with section filtering
- [ ] Site builds and serves without errors
- [ ] Responsive design works on all devices

---

## 📝 Notes

- Maintain clean git history with descriptive commits
