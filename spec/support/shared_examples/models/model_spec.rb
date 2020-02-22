# frozen_string_literal: true

shared_examples_for 'a mongoid_document' do |klass|
  it { expect(klass).to be_mongoid_document }
end

shared_examples_for 'number attributes on class' do |klass, attributes_number|
  it { expect(klass.attribute_names.length).to eq(attributes_number) }
end

shared_examples_for 'number relations on class' do |klass, relations_number|
  it { expect(klass.relations.length).to eq(relations_number) }
end
