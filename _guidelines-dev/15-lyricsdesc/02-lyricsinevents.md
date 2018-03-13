---
sectionid: lyricsInEvents
title: "Vocally Performed Text Encoded Within Notes"
version: "dev"
---

Each lyric syllable can be encoded directly within an associated note, either by using
the
**@syl** attribute on {% include link elem="note" %} or the {% include link elem="verse" %}
element.

Using the **@syl** attribute on notes is the simplest way of encoding vocally performed
text and is recommended only for simple situations or for those encodings which do
not focus
on vocally performed text.

The following example from Handel's *Messiah* (HWV 56) shows the use of
**@syl**:

<figure class="figure"><img src="{{ site.baseurl }}/Images/modules/lyrics/ex_syl_att.png" class="img-responsive"><figcaption class="figure-caption">Figure 50. Handel, Messiah HWV 56, Halleluja</figcaption>
</figure>{% include mei example="lyricsDesc/lyricsDesc-sample263.xml" valid="true" %}
When there are multiple lines of vocally performed text, or the encoder wishes to
be more
specific about connectors, etc., the use of {% include link elem="verse" %} and {% include link elem="syl" %} is recommended.



{% include desc elem="verse" %}
{% include desc atts="att.verse.log/rhythm" %}




The following example from Handel's *Messiah* (HWV 56) shows the use of {% include link elem="verse" %}:

{% include mei example="lyricsDesc/lyricsDesc-sample264.xml" valid="true" %}
As it is common practice in written text, it is assumed that a space separates words.
Many
vocal texts, however, introduce elisions and connect two syllables into one unit.
For example,
the vocal text from Mozart's *Don Giovanni* sung by Don Giovanni in Finale II,
<span class="q">Ho fermo il core in petto</span> introduces an elision between the word <span class="q">fermo</span> and
<span class="q">il</span> and between <span class="q">core</span> and <span class="q">in</span>. An elision can be indicated by placing both
syllables within the same {% include link elem="note" %} and setting the {% include link elem="syl" %}
element's **@con** attribute value to 't':

{% include mei example="lyricsDesc/lyricsDesc-sample265.xml" valid="true" %}
When there is more than one line of text, more than one {% include link elem="verse" %} element
can be used. The following example from a piano reduction of Wagner's *Rheingold*
has two lines of text, with an English translation on the second line. Note the use
of the
**@xml:lang** attribute to differentiate the two languages:


<figure class="figure"><img src="{{ site.baseurl }}/Images/modules/lyrics/ex_verse_m.png" class="img-responsive"><figcaption class="figure-caption">Figure 51. Example from Wagner's Rheingold with translated text.</figcaption>
</figure>{% include mei example="lyricsDesc/lyricsDesc-sample266.xml" valid="false" %}
Optionally, it is possible to include an {% include link elem="lb" %} element within {% include link elem="verse" %} to explicitly encode line and line group endings. This is
specifically meant to facilitate karaoke applications.

Finally, the **@rhythm** attribute can be used to specify a rhythm for the syllable
that differs from that of the notes on the staff.
