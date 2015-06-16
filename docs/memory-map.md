---
priority: 2
layout: page
title: Memory map
permalink: /misc/memory-map/
categories: hardware software
excerpt: >
  Details on where the various I/O devices are exposed in Búri's memory and
  which sections are reserved for what purposes.
---

This page gives the (current) memory map for Búri. As I add/tweak hardware, this
is likely to change. Of course you're free to re-order I/O as you see fit but
this memory map encodes what the <em>Operating System</em> thinks the I/O
arrangement is.

<table class="mem-map">
<thead>
  <tr class="mem-map-heading">
    <th>Range</th>
    <th>Description</th>
  </tr>
</thead>
<tbody>
  <tr class="mem-map-entry">
    <td class="mem-map-01">
      <div class="mem-map-top">$0000</div>
      <div class="mem-map-bottom">$00FF</div>
    </td>
    <td class="mem-map-description">
      <p>Zero page.</p>
      <p>$D0--$FF are reserved for the OS. The rest is yours.</p>
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-01">
      <div class="mem-map-top">$0100</div>
      <div class="mem-map-bottom">$01FF</div>
    </td>
    <td class="mem-map-description">
      Hardware stack page.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$0200</div>
      <div class="mem-map-bottom">$0205</div>
    </td>
    <td class="mem-map-description">
      <p>OS vector table.</p>
      <p>
        Each 2-byte entry gives the little-endian address to jump
        to for various entry points. The entry points are:
      </p>
      <table>
        <tr><td>$0200&ndash;$0201:</td><td>Put character (<code>putc</code>)</td></tr>
        <tr><td>$0202&ndash;$0203:</td><td>Get character (<code>getc</code>)</td></tr>
        <tr><td>$0204&ndash;$0205:</td><td>Is input available? (<code>hasc</code>)</td></tr>
      </table>
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-02">
      <div class="mem-map-top">$0206</div>
      <div class="mem-map-bottom">$02FF</div>
    </td>
    <td class="mem-map-description">
      Operating system reserved RAM space.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-02">
      <div class="mem-map-top">$0300</div>
      <div class="mem-map-bottom">$03FF</div>
    </td>
    <td class="mem-map-description">
      <p>Conventional area for RAM-patched OS vectors.</p>
      <p>
        If you patch the OS vector table at <code>$0200</code> by convention
        the routines can live in this page. At the moment the OS needs only one
        page of RAM but this may change in future. You should try and keep the
        OS vector patches position-independent since it may be neat to add an OS
        "patch" routine at a later date which chooses where to copy the routine.
      </p>
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-80">
      <div class="mem-map-top">$0400</div>
      <div class="mem-map-bottom">$7FFF</div>
    </td>
    <td class="mem-map-description">
      <p>Userspace code RAM area.</p>
      <p>
        Programs are free to use this RAM as they see fit although conventially,
        code is loaded from address $5000 up and addresses $0400 to $4FFF are
        used for data storage.
      </p>
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-40">
      <div class="mem-map-top">$8000</div>
      <div class="mem-map-bottom">$DF7F</div>
    </td>
    <td class="mem-map-description">
      Unallocated space.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DF80</div>
      <div class="mem-map-bottom">$DF8F</div>
    </td>
    <td class="mem-map-description">
      I/O area 0.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DF90</div>
      <div class="mem-map-bottom">$DF9F</div>
    </td>
    <td class="mem-map-description">
      I/O area 1.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFA0</div>
      <div class="mem-map-bottom">$DFAF</div>
    </td>
    <td class="mem-map-description">
      I/O area 2.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFB0</div>
      <div class="mem-map-bottom">$DFBF</div>
    </td>
    <td class="mem-map-description">
      I/O area 3.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFC0</div>
      <div class="mem-map-bottom">$DFCF</div>
    </td>
    <td class="mem-map-description">
      I/O area 4.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFD0</div>
      <div class="mem-map-bottom">$DFDF</div>
    </td>
    <td class="mem-map-description">
      I/O area 5.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFE0</div>
      <div class="mem-map-bottom">$DFEF</div>
    </td>
    <td class="mem-map-description">
      I/O area 6.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$DFF0</div>
      <div class="mem-map-bottom">$DFFF</div>
    </td>
    <td class="mem-map-description">
      <p>I/O area 7.</p>
      <p>Within this I/O area, the following hardware registers are assumed to
      be exposed.</p>
      <table>
        <tr><td>$DFFC:</td><td>ACIA receive register (read) / transmit register (write)</td></tr>
        <tr><td>$DFFD:</td><td>ACIA status register (read) / programmed reset (write)</td></tr>
        <tr><td>$DFFE:</td><td>ACIA command register</td></tr>
        <tr><td>$DFFF:</td><td>ACIA control register</td></tr>
      </table>
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-20">
      <div class="mem-map-top">$E000</div>
      <div class="mem-map-bottom">$FFF9</div>
    </td>
    <td class="mem-map-description">
      Operating system ROM. (8KB minus processor vectors.)
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$FFFA</div>
      <div class="mem-map-bottom">$FFFB</div>
    </td>
    <td class="mem-map-description">
      Processor jumps to the address stored here on non-maskable interrupt.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$FFFC</div>
      <div class="mem-map-bottom">$FFFD</div>
    </td>
    <td class="mem-map-description">
      Processor jumps to the address stored here on reset.
    </td>
  </tr>
  <tr class="mem-map-entry">
    <td class="mem-map-00">
      <div class="mem-map-top">$FFFE</div>
      <div class="mem-map-bottom">$FFFF</div>
    </td>
    <td class="mem-map-description">
      Processor jumps to the address stored here on interrupt when
      interrupt-disable status flag is clear.
    </td>
  </tr>
</tbody>
</table>

