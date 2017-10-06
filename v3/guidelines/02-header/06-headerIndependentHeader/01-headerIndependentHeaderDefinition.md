---
sectionid: headerIndependentHeaderDefinition
title: Definition and Principles for Encoders
---


<h3 id="headerIndependentHeaderDefinition">
   <span class="headingNumber">2.6.1</span>
   <span class="head">Definition and Principles for Encoders</span>
</h3>
An independent header is an MEI metadata header that can be exchanged as an independent
document between libraries, archives, collections, projects, and individuals.

The structure of an independent header is exactly the same as that of an header attached
to
a document. This means that an 
<a class="link_odd_elementSpec" href="/v3/elements/meiHead">meiHead</a> can be extracted from an MEI
document and sent to a receiving institution with little or no change.

<!--However, some fields that are
        listed as ‘optional’ in the header are listed as ‘recommended’ for the independent header.
        For this reason, this section should be consulted in connection with any plan to provide
        headers as independent documents.-->

When deciding which information to include in the independent header, and the format
or
structure of that information, the following should be kept in mind:


<span class="list">
   
   <span class="item">The independent header should provide full bibliographic information about the encoded
      text, its sources, where the text can be located, and any restrictions governing its
      use.
   </span>
   
   <span class="item">The independent header should contain useful information about the encoding of the
      text itself. In this regard, it is highly recommended that the encoding description
      be as
      complete as possible. The Guidelines do not require that the encoding description
      be
      included in the header (since some simple transcriptions of small items may not require
      it), but in practice the use of a header without an encoding description would be
      severely
      limited.
   </span>
   
   <span class="item">The independent header should be amenable to automatic processing, particularly for
      loading into databases and for the creation of publications, indexes, and finding
      aids,
      without undue editorial intervention on the part of the receiving institution. For
      this
      reason, two recommendations are made regarding the format or structure of the header:
      first, where there is a choice between a prose content model and one that contains
      a
      formal series of specialized elements, wherever possible and appropriate the specialized
      elements should be preferred to unstructured prose. Second, with respect to corpora,
      information about each of the texts within a corpus should be included in the overall
      corpus-level 
      <a class="link_odd_elementSpec" href="/v3/elements/meiHead">meiHead</a>. That is, source information, editorial
      practices, encoding descriptions, and the like should be included in the relevant
      sections
      of the corpus 
      <a class="link_odd_elementSpec" href="/v3/elements/meiHead">meiHead</a>, with pointers to them from the headers of the
      individual texts included in the corpus. There are three reasons for this recommendation:
      first, the corpus-level header will contain the full array of bibliographic and
      documentary information for each of the texts in a corpus, and thus be of great benefit
      to
      remote users, who may have access only to the independent header; second, such a layout
      is
      easier for the coder to maintain than searching for information throughout a text;
      and
      third, generally speaking, this practice results in greater overall consistency,
      especially with respect to bibliographic citations.
   </span>
   
</span>