class Parser
rule

  document
    : relation
    | attribute
    | instance
    | comment
    ;
  relation
    : '@relation' string { @document = Arff::Document.new(val[1]) }
    | '@RELATION' string { @document = Arff::Document.new(val[1]) }
    ;
  attributes
    : attribute attributes | attribute
    ;
  attribute
    : '@attribute' string type { @document.add_attribute(name: val[1], type: val[2] =~ /{/ ? val[2].sub('{','').sub('}', '').split(",") : val[2]) }
    | '@ATTRIBUTE' string type { @document.add_attribute(name: val[1], type: val[2] =~ /{/ ? val[2].sub('{','').sub('}', '').split(",") : val[2]) }
    ;
  type
    : 'real'
    | 'REAL'
    | 'numeric'
    | 'NUMERIC'
    | normalized
    ;
  normalized
    : '{' normals '}'
    ;
  normals
    : string ',' normals
    | string
    ;
  comment
    : '%' string
    ;
  instance
    : string ',' instance
    | string
    | numeric
    ;
  numeric
    | NUMERIC { val[0] =~ /./ ? val[0].to_f : val[0].to_i }
    ;
  string
    : STRING { val[0].gsub(/^"|"$/, '') }
    ;
end

def next_token
  @tokenizer.next_token
end

def parse(file)
  @document = nil
  File.open(file).each do |line|
    parse_line(line)
  end
end

def parse_line(line)
  @tokenizer = Arff::Tokenizer.new(line)

  do_parse
end
