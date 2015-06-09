---
layout: page
title: Peripherals
permalink: /peripherals/
menu: top
menuorder: 3
---
{% assign pages = site.pages | sort: 'priority' %}
{% for page in pages%}{% if page.categories contains 'peripheral' %}
<h1 class="page-heading">
  <a href="{{ page.permalink | prepend: site.baseurl }}">{{ page.title }}</a>
</h1>
{{ page.excerpt }}
{% endif %}{% endfor %}
