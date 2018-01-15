require 'test_helper'

def ansible_fixture_file(filename)
  File.join(
    ForemanAnsible::Engine.root, 'test', 'fixtures', filename
  )
end

def sample_facts_file
  File.read(
    ansible_fixture_file('sample_facts.json')
  )
end

def facts_json
  HashWithIndifferentAccess.new(JSON.parse(sample_facts_file))
end

plugin_factories_path = File.join(File.dirname(__FILE__), 'factories')
FactoryBot.definition_file_paths << plugin_factories_path
FactoryBot.reload
