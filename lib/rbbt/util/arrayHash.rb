
class ArrayHash

  def self.make_case_insensitive(hash)
    new = {}
    hash.each{|k,v|
      new[k.to_s.downcase] = v
    }

    class << new; self; end.instance_eval{
      alias_method :old_get, :[]
      define_method(:[], proc{|key| old_get(key.to_s.downcase)})
    }

    new
  end

  # Take two strings of elements separated by the character sep_char and join them
  # into one, removing repetitions.
  def self.merge_values_string(list1, list2, sep_char ='|')
    elem1 = list1.to_s.split(sep_char)
    elem2 = list2.to_s.split(sep_char)
    (elem1 + elem2).select{|e| e.to_s != ""}.uniq.join(sep_char)
  end

  # Merge two lists of elements. Elements could be strings of elements
  # separated by the character sep_char, or arrays of lists of such strings.
  def self.merge_values(list1, list2, sep_char = "|")
    if String === list1 || String === list2
      return merge_values_string(list1, list2)
    end

    if list1.nil?
      list1 = [''] * list2.length
    end

    if list2.nil?
      list2 = [''] * list1.length
    end

    new = []
    list1.each_with_index{|elem, i|
      new << merge_values_string(elem, list2[i], sep_char)
    }
    new
  end

  
  # Take an hash of arrays and a position and use the value at that position
  # of the arrays to build a new hash with that value as key, and the original
  # key prepended to the arrays. The options hash accepts the following keys
  # :case_insensitive, which defaults to true, and :index, which indicates that
  # the original key should be the value of the hash entry, instead of the
  # complete array of values.
  def self.pullout(hash, pos, options = {})
    index = options[:index]; index = false if index.nil?
    case_insensitive = options[:case_insensitive]; case_insensitive = true if case_insensitive.nil?

    new = {}
    hash.each{|key,values|
      code = values[pos].to_s
      next if code == ""
      
      if index
        list = key
      else
        list = [key] + values
        list.delete_at(pos + 1)
      end
      
      code.split("|").each{|c|
        c = c.downcase if case_insensitive
        new[c] = merge_values(new[c], list)
      }
    }

    new = make_case_insensitive new if case_insensitive

    new
  end

  # Merge one hash of arrays into another. Each hash contains a number of fields for each
  # entry. The pos1 and pos2 indicate what fields should be used to match
  # entries, the values for pos1 and pos2 can be an integer indicating the
  # position in the array or the symbol :main to refer to the key of the hash.
  # The options hash accepts the key :case_insensitive, which defaults to true.
  def self.merge(hash1, hash2, pos1 = :main, pos2 = :main, options = {})
    case_insensitive = options[:case_insensitive]; case_insensitive = true if case_insensitive.nil?

    raise "Key #{ pos1 } should be an Interger or :main" unless Fixnum === pos1 || pos1.to_s.downcase == 'main'
    raise "Key #{ pos2 } should be an Interger or :main" unless Fixnum === pos2 || pos2.to_s.downcase == 'main'


    # Pullout if pos2 is not :main
    hash2 = pullout(hash2, pos2) unless pos2.to_s.downcase == 'main'

    # Translate if pos1 is not :main
    if pos1.to_s.downcase != 'main'
      index = pullout(hash1, pos1, options.merge(:index => true))
      new = {}
      hash2.each do |key, list|
        next unless index[key]
        new[index[key]] = list
      end
      hash2 = new
    end

    # Get the lengths of the arrays on each hash (they should
    # be the same for every entry)
    length1 = hash1.values.first.length
    length2 = hash2.values.first.length
    
    if case_insensitive
      hash1 = make_case_insensitive hash1
      hash2 = make_case_insensitive hash2
    end

    new = {}
    (hash1.keys + hash2.keys).uniq.each do |key|
      if hash2[key].nil?
        list2 = [''] * length2
      else
        list2 = hash2[key]
      end

      if hash1[key].nil?
        list1 = [''] * length1
      else
        list1 = hash1[key]
      end

      new[key] = list1 + list2
    end

    new
  end

  # For a given hash of arrays, filter the position pos of each array with the
  # block of code.
  def self.process(hash, pos, &block)
    new = {}
    hash.each{|key, values|
      v = values
      v[pos] = v[pos].to_s.split("|").collect{|n| block.call(n)}.join("|")
      new[key] = v
    }
    new
  end

  # Clean structure for repeated values. If the same value appears two times 
  # eliminate the one that appears latter on the values list (columns of the
  # ArrayHash are assumed to be sorted for importance) if the appear on the
  # same position, remove the one with the smaller vale of the code after
  # turning it into integer.
  def self.clean(hash, options = {})
    case_sensitive = options[:case_sensitive]

    found = {}

    hash.each{|k, list|
      list.each_with_index{|values,i|
        (String === values ? values.split("|") : values).each{|v|
          v = v.downcase if case_sensitive
          if found[v].nil?
            found[v] = [k,i]
          else
            last_k, last_i = found[v].values_at(0,1)
            if last_i > i || (last_i == i && last_k.to_i > k.to_i)
              found[v] = [k,i]
            end
          end
        }
      }
    }

    new_hash = {}
    hash.each{|k,list|
      new_list = []
      list.each_with_index{|values,i|
        new_values = []
        (String === values ? values.split("|") : values).each{|v|
          found_k, found_i = found[(case_sensitive ? v.downcase : v )].values_at(0,1)
          if found_i == i && found_k == k
            new_values << v
          end
        }
        new_list << (String === values ? new_values.join("|") : values)
      }
      new_hash[k] = new_list
    }
    new_hash
  end

  attr_reader :main, :fields, :data
  def initialize(hash, main, fields = nil)
    @data = hash
    @main = main.to_s
    
    if fields.nil? || fields.empty?
      l = hash.values.first.length
      fields = []
      l.times{|i| fields << "F#{i}"}
    end
    
    @fields = fields.collect{|f| f.to_s}
  end

  # Wrapper
  def process(field, &block)
    pos = self.field_pos(field)
    @data = ArrayHash.process(self.data, pos, &block)
    self
  end

  # Returns the position of a given field in the value arrays
  def field_pos(field)
    return :main if field == :main
    if field.to_s.downcase == self.main.to_s.downcase
      return :main
    else
      @fields.collect{|f| f.downcase }.index(field.to_s.downcase)
    end
  end


  # Merge two ArrayHashes using the specified field
  def merge(other, field = :main, options = {} )
    field = self.main  if field == :main

    pos1 = self.field_pos(field)
    pos2 = other.field_pos(field)

    raise "Field #{ field } not found in target hash" if pos1.nil?
    raise "Field #{ field } not found in added hash" if pos2.nil?

    new = ArrayHash.merge(self.data, other.data, pos1, pos2, options)
    @data = new
    if pos2 == :main
      new_fields = other.fields
    else
      new_fields = other.fields
      new_fields.delete_at(pos2)
      new_fields.unshift(other.main)
    end
    @fields += new_fields
    self
  end

  # Remove a field from the ArrayHash
  def remove(field)
    pos = self.field_pos(field)
    return if pos.nil?
    @data = self.data.each{|key,values| values.delete_at(pos)}
    @fields.delete_at(pos)
    self
  end

  def clean
    @data = ArrayHash.clean(@data)
    self
  end
end




