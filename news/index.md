---
title: News
---

# News

<div class="news-container">
  {% for post in site.posts %}
    <article class="news-entry">
      <div class="news-date">{{ post.date | date: "%B %d, %Y" }}</div>
      <h3 class="news-title">{{ post.title }}</h3>
      {% if post.excerpt %}
        <div class="news-excerpt">{{ post.excerpt | strip_html | truncate: 150 }}</div>
      {% endif %}
      <a href="{{ post.url | relative_url }}" class="news-read-more">Read more →</a>
    </article>
  {% endfor %}
  
  {% if site.posts.size == 0 %}
    <div class="news-empty">
      <p>No news posts yet. Check back soon for updates!</p>
    </div>
  {% endif %}
</div>
