---
layout: page
title: Peripherals
permalink: /peripherals/
menu: top
menuorder: 3
---

{% assign pages = site.pages | where: "categories", "peripherals" | sort: "priortity" %}

{% for page in pages %}
<h1 class="page-heading">
  <a href="{{ page.permalink | prepend: site.baseurl }}">{{ page.title }}</a>
</h1>

{{ page.excerpt }}
{% endfor %}
