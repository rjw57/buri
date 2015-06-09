---
layout: page
title: Hardware
permalink: /hardware/
menuorder: 1
menu: top
---
{% assign pages = site.pages | sort: 'priority' %}
{% for page in pages %}{% if page.categories contains 'hardware' %}
<h1 class="page-heading">
  <a href="{{ page.permalink | prepend: site.baseurl }}">{{ page.title }}</a>
</h1>
{{ page.excerpt }}
{% endif %}{% endfor %}
