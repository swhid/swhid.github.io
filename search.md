---
title: Search
layout: page
permalink: /search/
description: Search SWHID.org for information about software artifact identification, ISO standards, and related topics.
---

<div class="search-container">
  <h1>Search SWHID.org</h1>
  <p>Find information about SWHID, software artifact identification, and related topics.</p>
  
  <div class="search-box">
    <form action="/search/" method="get">
      <div class="search-input-group">
        <input type="text" name="q" id="search-input" placeholder="Search for SWHID, ISO standards, software identification..." value="{{ page.query | escape }}" autocomplete="off" autofocus>
        <button type="submit" class="search-button">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <path d="m21 21-4.35-4.35"></path>
          </svg>
          Search
        </button>
      </div>
    </form>
  </div>

  {% if page.query %}
    <div class="search-results">
      <h2>Search Results for "{{ page.query | escape }}"</h2>
      
      <div id="search-results-content">
        <div class="search-loading">
          <p>Searching...</p>
        </div>
      </div>
    </div>
  {% else %}
    <div class="search-suggestions">
      <h3>Popular Searches</h3>
      <div class="suggestion-tags">
        <a href="/search/?q=ISO+18670" class="suggestion-tag">ISO 18670</a>
        <a href="/search/?q=software+identification" class="suggestion-tag">Software Identification</a>
        <a href="/search/?q=merkle+tree" class="suggestion-tag">Merkle Tree</a>
        <a href="/search/?q=content+hash" class="suggestion-tag">Content Hash</a>
        <a href="/search/?q=software+preservation" class="suggestion-tag">Software Preservation</a>
        <a href="/search/?q=cybersecurity" class="suggestion-tag">Cybersecurity</a>
        <a href="/search/?q=specification" class="suggestion-tag">Specification</a>
        <a href="/search/?q=FAQ" class="suggestion-tag">FAQ</a>
      </div>
    </div>
  {% endif %}
</div>

<script>
// Simple client-side search functionality
document.addEventListener('DOMContentLoaded', function() {
  const searchInput = document.getElementById('search-input');
  const searchResults = document.getElementById('search-results-content');
  
  if (searchInput && searchResults) {
    const query = new URLSearchParams(window.location.search).get('q');
    if (query) {
      performSearch(query);
    }
  }
  
  function performSearch(query) {
    // Simple search implementation
    const searchableContent = [
      {
        title: "SWHID Specification",
        url: "/specification/",
        content: "The official SWHID specification document describing the Software Hash Identifier standard for software artifact identification.",
        type: "Specification"
      },
      {
        title: "Frequently Asked Questions",
        url: "/faq/",
        content: "Common questions and answers about SWHID, software identification, and the ISO/IEC 18670:2025 standard.",
        type: "FAQ"
      },
      {
        title: "ISO/IEC 18670:2025 Standard",
        url: "https://www.iso.org/standard/89985.html",
        content: "The official ISO international standard for Software Hash Identifier (SWHID) specification.",
        type: "Standard"
      },
      {
        title: "News and Updates",
        url: "/news/",
        content: "Latest news and announcements about SWHID, including the ISO standardization milestone.",
        type: "News"
      },
      {
        title: "Publications",
        url: "/publications/",
        content: "Academic papers, white papers, and technical publications related to SWHID and software identification.",
        type: "Publications"
      },
      {
        title: "Core Team",
        url: "/coreteam/",
        content: "Meet the SWHID working group members and core team responsible for the standard.",
        type: "Team"
      },
      {
        title: "Governance",
        url: "/governance/",
        content: "Information about SWHID governance, decision-making processes, and community participation.",
        type: "Governance"
      }
    ];
    
    const results = searchableContent.filter(item => 
      item.title.toLowerCase().includes(query.toLowerCase()) ||
      item.content.toLowerCase().includes(query.toLowerCase()) ||
      item.type.toLowerCase().includes(query.toLowerCase())
    );
    
    displayResults(results, query);
  }
  
  function displayResults(results, query) {
    const searchResults = document.getElementById('search-results-content');
    
    if (results.length === 0) {
      searchResults.innerHTML = `
        <div class="no-results">
          <h3>No results found for "${query}"</h3>
          <p>Try searching with different keywords or browse our <a href="/faq/">FAQ</a> for common questions.</p>
        </div>
      `;
      return;
    }
    
    let html = `<div class="results-summary">Found ${results.length} result${results.length === 1 ? '' : 's'} for "${query}"</div>`;
    
    results.forEach(result => {
      const isExternal = result.url.startsWith('http');
      const target = isExternal ? ' target="_blank" rel="noopener"' : '';
      
      html += `
        <div class="search-result-item">
          <h3><a href="${result.url}"${target}>${result.title}</a></h3>
          <div class="result-meta">
            <span class="result-type">${result.type}</span>
            ${isExternal ? '<span class="external-link">External</span>' : ''}
          </div>
          <p class="result-excerpt">${result.content}</p>
        </div>
      `;
    });
    
    searchResults.innerHTML = html;
  }
});
</script>
