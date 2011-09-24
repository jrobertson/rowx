The RowX gem makes it more convenient to generate XML with minimal syntax.  In the above code a heredoc contains a couple of records which is then passed to the RowX Object to be converted to XML.

    # gem pushed via rvm ruby-1.9.2-180

    require 'rowx'

    txt =<<EOF
    testing 123
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

    rowx = RowX.new(txt)
    xml = rowx.to_xml
    puts xml

    #=>
    <?xml version='1.0' encoding='UTF-8'?>
    <root>
      <summary>
        <description>testing 123</description>
      </summary>
      <item>
        <path>1</path>
        <type>date only</type>
        <desc></desc>
        <input>
          <item>
            <date>22-Apr-2011 12:34</date>
            <entry>* * * * *</entry>
          </item>
        </input>
        <output>
          <item>
            <date>2011-04-22 12:34<item>

    ...


Notes:

 * Hash-type labels define the element names.
 * Indenting the line of text by 2 spaces will make the row a child element to the row above.
 * Blank lines and separator lines (-------) are disregarded.
 * A row is defined by the first label which is found to be repeated further down the text, or just the first label if there is only 1 row.
 * A summary element is created at the top of the XML for any text preceding the rows.
 * If a line of text contains no label it is automatically given the label 'description'.
 * This gem is experimental.

Resources:
 - <a href="https://github.com/jrobertson/rowx">jrobertson/rowx</a> [github.com]