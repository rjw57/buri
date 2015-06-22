---
layout: page
title: The Búri site, a guided tour
permalink: /guided-tour/
---

Welcome to my website on Búri, my home-build 6502 computer. This page is
intended for new users and provides a historical overview of the site and the
pages.

## What is Búri and why?

Around Christmas 2014 I developed a desire to learn some digital electronics and
discover more about how computers actually work. I'm a fairly proficient
software developer but most of my work starts a) above the OS and b) from C/C++
upwards. (Although I spend the majority of my time in Python these days.) I had
only theoretical knowledge of how an OS works, how to drive hardware and
low-level programming without a standard library to help you.

I had played with an [Arduino] a bit over the past few months and though it was
all very fun but that I wanted a big, ambitious long-term project. The Búri
project is it.

Find out more on the motivations and aims of the project on the [about] page.
{: .see-also }

## Timeline

If you're interested in the history of the project, I've put some brief progress
notes below in rough chronological order.

### January 2014

A bare bones wiring of ROM, RAM and processor onto the same address and data
busses. No address decode circuitry and so ROM/RAM hard-wired into "disable"
state and data bus hard-wired into NOP instruction ($EA).

<figure>
  <a href="{{ site.imageurl }}/free-running.jpg">
    <img src="{{ site.imageurl }}/free-running.jpg">
  </a>
  <figcaption>The first "free running" protoptype.</figcaption>
</figure>

### March 2014

OS up and running. First prototype serial console working. Enhanced BASIC ported
over to Búri in a very limited way.

There's some discussion on the structure of the OS on the [OS
page]({{ site.baseurl }}/software/os/).
{: .see-also }

### April 2014

CPU board design done, PCB manufactured and debugged. Búri lives on something
other than a breadboard for the first time.

Find out more about on the [CPU board]({{ site.baseurl }}/hardware/cpu-board/) page.
{: .see-also }

<figure>
  <a href="{{ site.imageurl }}/cpu-board.jpg">
    <img src="{{ site.imageurl }}/cpu-board.jpg">
  </a>
  <figcaption>Búri assembled onto the first CPU board.</figcaption>
</figure>

### May 2014

Serial port module created. The first peripheral for Búri! Not much more than a
convenience to make adding a 6551 to the bus less error prone.

See all the gory details on the [Serial port]({{ site.baseurl }}/hardware/serial-port/) page.
{: .see-also }

[Arduino]: http://www.arduino.cc/
[about]: {{site.baseurl}}/about/
