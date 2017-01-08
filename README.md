# Introducing the RowX gem

    require 'rowx'

    txt =<<EOF
    title: testing 123

    -----------------------------
    path: 1
    type: date only
    desc:

    input:
      date: 22-Apr-2011 12:34
      entry: * * * * *

    output:
      date: 2011-04-22 12:34

    ------------------------------

    path: 2
    type: date only
    desc:

    input:
      date: 22-Apr-2011 12:34
      entry: * * * * *

    output:
      date: 2011-04-22 12:34

    ------------------------------

    EOF



Output:

<pre>
irb(main):214:0&gt; puts xml
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;root&gt;
  &lt;summary&gt;
    &lt;title&gt;testing 123&lt;/title&gt;
  &lt;/summary&gt;
  &lt;item&gt;
    &lt;path&gt;1&lt;/path&gt;
    &lt;type&gt;date only&lt;/type&gt;
    &lt;desc/&gt;
    &lt;input&gt;
      &lt;item&gt;
        &lt;date&gt;22-Apr-2011 12:34&lt;/date&gt;
        &lt;entry&gt;* * * * *&lt;/entry&gt;
      &lt;/item&gt;
    &lt;/input&gt;
    &lt;output&gt;
      &lt;item&gt;
        &lt;date&gt;2011-04-22 12:34&lt;/date&gt;
      &lt;/item&gt;
    &lt;/output&gt;
  &lt;/item&gt;
  &lt;item&gt;
    &lt;path&gt;2&lt;/path&gt;
    &lt;type&gt;date only&lt;/type&gt;
    &lt;desc/&gt;
    &lt;input&gt;
      &lt;item&gt;
        &lt;date&gt;22-Apr-2011 12:34&lt;/date&gt;
        &lt;entry&gt;* * * * *&lt;/entry&gt;
      &lt;/item&gt;
    &lt;/input&gt;
    &lt;output&gt;
      &lt;item&gt;
        &lt;date&gt;2011-04-22 12:34&lt;/date&gt;
      &lt;/item&gt;
    &lt;/output&gt;
  &lt;/item&gt;
&lt;/root&gt;
</pre>

The RowX gem makes it more convenient to generate XML with minimal syntax.  In the above code a heredoc contains a couple of records which is then passed to the RowX Object to be converted to XML.

Notes:

 * Hash-type labels define the element names.
 * Indenting the line of text by 2 spaces will make the row a child element to the row above.
 * Blank lines and separator lines (-------) are disregarded.
 * A row is defined by the first label which is found to be repeated further down the text, or just the first label if there is only 1 row.
 * A summary element is created at the top of the XML for any text preceding the rows.
 * If a line of text contains no label it is automatically given the label 'description'.
 * The named keyword *level* can be used to define how many levels the tree should be parsed. The lowest level is 0.

Resources:

* rowx https://github.com/jrobertson/rowx

gem parse rowx ruby text
