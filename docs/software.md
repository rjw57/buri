---
layout: page
title: Software
permalink: /software/
menuorder: 2
menu: top
---

{% assign pages = site.pages | where: "categories", "software" | sort: "priortity" %}

{% for page in pages %}
<h1 class="page-heading">
  <a href="{{ page.permalink | prepend: site.baseurl }}">{{ page.title }}</a>
</h1>

{{ page.excerpt }}
{% endfor %}
