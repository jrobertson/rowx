#!/usr/bin/env ruby

# file: rowx.rb

require 'line-tree'
require 'rexle'

class Array
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

class RowX

  attr_reader :to_a, :to_xml

  def initialize(txt)

    a3 = txt.split(/(?:\n|^\-+$)\n/)
    # get the fields
    a4 = a3.map{|x| x.scan(/\w+(?=:)/)}.flatten(1).uniq
    a5 = a3.map do |xlines|

      missing_fields = a4 - xlines.scan(/^\w+(?=:)/)
      r = xlines.lines.map(&:strip)
      r += missing_fields.map{|x| x + ":"}
      r.sort.join("\n")

    end
    a6 = a5.join("\n\n")

    a = LineTree.new(a6).to_a
     
    keyfield = a[0][0][/\w+/]; i = 0

    while a.select {|x| x[0][/#{keyfield}/]}.length <= 1 and i < a.length
      i += 1
      keyfield = a[i][0][/\w+/] 
    end  

    keyfield = a[0][0][/\w+/] if i == a.length - 1
    records = a[i..-1].collate { |x| x.first =~ /^#{keyfield  }/ }
    summary = scan_a a.slice!(0,i)

    summary[0] = 'summary'
    @to_a = ['root', '', {}] + [summary] + scan_records(records)    
    @to_xml = Rexle.new(@to_a).xml pretty: true

  end

  private

  def scan_a(row)

    a = row.map do |field|

      s = field.is_a?(Array) ? field[0] : field
      value, name = s.split(':',2).reverse
      name ||= 'description'

      children = scan_a(field[1..-1]) if field[-1] .is_a?(Array) 
      value = value.to_s.strip
      value = ['![', value, {}] if value[/[<>]/] 
        
      result = [name, value, {}]
      result << children if children
      result
    end

    ['item', '', {}]  + a
  end

  def scan_records(row)
    row.map {|x| scan_a x }
  end

end
