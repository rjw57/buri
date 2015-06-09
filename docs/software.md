---
layout: page
title: Software
permalink: /software/
menuorder: 2
menu: top
---
{% assign pages = site.pages | sort: 'priority' %}
{% for page in pages %}{% if page.categories contains 'software' %}
<h1 class="page-heading">
  <a href="{{ page.permalink | prepend: site.baseurl }}">{{ page.title }}</a>
</h1>
{{ page.excerpt }}
{% endif %}{% endfor %}
