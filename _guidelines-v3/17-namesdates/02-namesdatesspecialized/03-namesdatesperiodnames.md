---
sectionid: namesdatesPeriodNames
title: "Time Period Names"
version: "v3"
---

{% include desc elem="periodName" %} 

The {% include link elem="periodName" %} element is for names which describe a particular period of time, for example, those which characterize obvious similarities in style, such as ‘Baroque’ or ‘3rd Style Period’:

{% include mei example="namesDates/namesDates-sample286.xml" valid="true" %}

The date sub-element is available within {% include link elem="periodName" %} in order to record any dates associated with the name that should be captured in the text, for example, start and end dates of the named period:

{% include mei example="namesDates/namesDates-sample287.xml" valid="true" %}

Recording start and end points of a certain period using the **@startdate** and **@enddate** attributes may prove to be better for machine processing:

{% include mei example="namesDates/namesDates-sample288.xml" valid="true" %}

If a controlled value is used, the list from which it is taken should be recorded. In this case the following attributes are relevant:

{:.gloss}
**authority**: to record the list from which a controlled value is taken,

{:.gloss}
**authURI (authority URI)**: to record the web-accessible location of the controlled vocabulary from which the value is taken,

{:.gloss}
**dbkey (database key)**: to record a value which serves as a primary key in an external database.

