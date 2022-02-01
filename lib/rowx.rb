#!/usr/bin/env ruby

# file: rowx.rb

require 'line-tree'


class RowXException < Exception
end

# for an example of ArrayCollate
# see http://www.jamesrobertson.eu/snippets/2014/jun/08/collating-items-in-an-array.html

module ArrayCollate
  refine Array do
    def collate(pattern=nil)
      a = self.inject([[]]) do |r,x|
        if block_given? then
          yield(x) ? r << [x] : r[-1] << x
        else
          x =~ pattern ? r << [x] : r[-1] << x
        end # block
        r
      end
      a.shift if a.first.empty?
      a
    end
  end
end

class RowX

  using ArrayCollate
  using ColouredText

  attr_reader :to_a, :to_xml, :to_lines

  def initialize(txt, level: nil, ignore_blank_lines: false,
                 abort_1_row: false, debug: false, name: 'item',
                 allow_lonely_keyfield: false)

    @name, @debug = name, debug

    # auto indent any multiline values

    indent = ''

    lines = txt.gsub(/^-+$/m,'').lines.map do |line|

      if not line[/^ *\w+:|^ +/] then
        indent + '  ' + line
      else
        indent = line[/^ +/] || ''
        line
      end

    end

    puts 'lines: ' + lines.inspect if @debug

    a = LineTree.new(lines.join, level: level,
                     ignore_blank_lines: ignore_blank_lines, debug: debug).to_a
    puts ('a: ' + a.inspect).debug if @debug

    keyfield = a[0][0][/\w+:/]; i = 0
    puts ('keyfield: ' + keyfield.inspect).debug if @debug

    if not allow_lonely_keyfield then

      # find the keyfield. if there's only 1 keyfield in all of the rows it's
      # not a keyfield. Keep searching until all rows have been searched
      while a.select {|x| x[0][/^#{keyfield}/]}.length <= 1 and \
                                                        i < a.length and a[i+1]

        i += 1
        keyfield = a[i][0][/\w+/]

      end

    end

    keyfield = a[0][0][/\w+/] if i == a.length - 1

    if a.flatten(1).grep(/^#{keyfield}/).length == 1 then # only 1 record
      i = 0
      raise RowXException, 'Expected more than 1 row' if abort_1_row
    end

    records = a[i..-1].collate { |x| x.first =~ /^#{keyfield  }/ }

    summary = scan_a a.slice!(0,i)
    summary[0] = 'summary'

    @rexle_a = scan_records(records, level)
    @to_a = ['root', {}] + [summary] + @rexle_a
    @to_xml = Rexle.new(@to_a).xml pretty: true

  end

  def to_lines(delimiter: ' # ')
    @rexle_a.map {|x| x[3..-1].map {|y| y[2]}.join(delimiter)}.join("\n").lines
  end

  private


  def scan_a(row)

    a = row.map do |field|

      puts 'field: ' + field.inspect if @debug
      s = field.is_a?(Array) ? field[0] : field

      return if s.empty?
      puts 's: ' + s.inspect if @debug
      found = s.match(/^(\w+)(?:\:$|\:\s*)(.*)/m)

      value, name = found ? found.captures.reverse : s
      name ||= 'description'

      children = scan_a(field[1..-1]) if field[-1] .is_a?(Array)
      value = value.to_s.strip.gsub('<','&lt;').gsub('>','&gt;')

      # it's a line which has been commented out?
      if name[0] == '#' then
        value = name[1..-1] + ': ' + value
        name = '!-'
      end

      result = [name, {}, value]
      result << children if children
      result
    end

    [@name, {}, '' ]  + a
  end

  def scan_records(rows, level)

    rows.map {|x| scan_a x }

  end

end
