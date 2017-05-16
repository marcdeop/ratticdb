#!/usr/bin/env ruby
require 'json'

def quote_block(text)
  puts '```'
  puts text
  puts '```'
end

def single_line(text)
  puts text
  puts
end

def write_docstring_summary(docstring)
  summary_tag = get_docstring_elems_with_tag(docstring, 'summary')
  return if summary_tag.empty?
  puts '### Summary'
  summary_tag.each do |summ|
    remove_docstring_elem_with_tag(docstring, 'summary')
    single_line(summ['text'])
  end
end

def write_docstring_overview(docstring)
  overview = docstring['text']
  return if overview.empty?
  puts '### Overview'
  single_line(overview)
end

def write_docstring_examples(docstring)
  example_tag = get_docstring_elems_with_tag(docstring, 'example')
  return if example_tag.empty?
  example_tag.each do |example|
    remove_docstring_elem_with_tag(docstring, 'example')
    puts '#### ' + example['name']
    quote_block(example['text'])
  end
end

def write_params_table_header
  puts '### Parameters'
  puts '| Name | Description | Default |'
  puts '| --- | --- | --- |'
end

def write_params_table_row(name, text, default_value)
  puts '| ' + name + ' | ' + text + ' | ' + default_value + ' |'
end

def remove_docstring_elem_with_tag(docstring, tag_to_del)
  docstring['tags'].delete_if { |element| element['tag_name'].eql?tag_to_del }
end

def get_docstring_elems_with_tag(docstring, tag_to_get)
  docstring['tags'].select { |tag| tag['tag_name'].eql?tag_to_get }
end

def write_docstring_params(docstring, defaults)
  param_tag = get_docstring_elems_with_tag(docstring, 'param')
  return if param_tag.empty?
  write_params_table_header
  param_tag.each do |param|
    name = param['name']
    remove_docstring_elem_with_tag(docstring, 'param')
    write_params_table_row(name, param['text'], defaults.fetch(name))
  end
  puts
end

def write_docstring_see(docstring)
  see_tag = get_docstring_elems_with_tag(docstring, 'see')
  return if see_tag.empty?
  puts '### See'
  see_tag.each do |see|
    remove_docstring_elem_with_tag(docstring, 'see')
    name = see['name']
    single_line('[' + name + '](' + name + ')')
  end
  puts
end

def write_docstring_authors(docstring)
  author_tag = get_docstring_elems_with_tag(docstring, 'author')
  return if author_tag.empty?
  puts '### Authors'
  author_tag.each do |author|
    remove_docstring_elem_with_tag(docstring, 'author')
    puts author['text']
  end
  puts
end

def write_docstring_extratags(docstring)
  ((docstring['tags'].select { |s| s['tag_name'] })
    .uniq { |r| r['tag_name'] }).each do |tag|
    puts tag['tag_name'] + ': ' + tag['text']
  end
end

def write_docstring(docstring, defaults)
  write_docstring_summary(docstring)
  write_docstring_overview(docstring)
  write_docstring_examples(docstring)
  write_docstring_params(docstring, defaults)
  write_docstring_see(docstring)
  write_docstring_authors(docstring)
  write_docstring_extratags(docstring)
end

def write_header_name(puppetclass)
  name = puppetclass['name']
  return unless name.is_a?(String)
  puts '## ' + name
end

def write_file(puppetclass)
  file = puppetclass['file']
  return unless file.is_a?(String)
  puts '### Source code'
  single_line('[' + file + '](' + file + ')')
end

def write_inherits(puppetclass)
  inherits = puppetclass['inherits']
  return unless inherits.is_a?(String)
  puts '### Inherits from'
  single_line(inherits)
end

def document_class(puppetclass)
  write_header_name(puppetclass)
  write_file(puppetclass)
  write_inherits(puppetclass)
  docstring = puppetclass['docstring']
  write_docstring(docstring, puppetclass['defaults'])
end

def document_defined_type(defined_type)
  puts 'Not supported yet'
end

def document_resource_type(resource_typ)
  puts 'Not supported yet'
end

def document_provider(provider)
  puts 'Not supported yet'
end

def document_function(function)
  puts 'Not supported yet'
end

def document_classes(puppet_classes)
  return if puppet_classes.empty?
  puts '# Puppet Classes'
  puppet_classes.each do |puppet_class|
    document_class(puppet_class)
  end
end

def document_defined_types(defined_types)
  return if defined_types.empty?
  puts '# Defined Types'
  defined_types.each do |defined_type|
    document_class(defined_type)
  end
end

def document_resource_types(resource_types)
  return if resource_types.empty?
  puts '# Resource Types'
  resource_types.each do |resource_type|
    document_class(resource_type)
  end
end

def document_providers(providers)
  return if providers.empty?
  puts '# Providers'
  providers.each do |provider|
    document_class(provider)
  end
end

def document_functions(puppet_functions)
  return if puppet_functions.empty?
  puts '# Functions'
  puppet_functions.each do |puppet_function|
    document_class(puppet_function)
  end
end

doc = JSON.parse(ARGF.read)

document_classes(doc['puppet_classes'])
document_defined_types(doc['defined_types'])
document_resource_types(doc['resource_types'])
document_providers(doc['providers'])
document_functions(doc['puppet_functions'])
