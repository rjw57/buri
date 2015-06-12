# Image files

These files are used by the documentation as figures, etc. Some of the PNGs are
generated from the SVGs using commands like:

{% highlight console %}
$ inkscape -b white -d 300 -e foo.png foo.svg
{% endhighlight %}

# Thumbnails

Thumbnails are generated via imagemagick:

{% highlight console %}
$ convert foo.jpg -thumbnail 800x thumb/foo.jpg
{% endhighlight %}
