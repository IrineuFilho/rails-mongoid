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

shared_examples_for 'embedded_in' do |klass, embeded_object|
  it { expect(klass).to be_embedded_in(embeded_object) }
end

shared_examples_for 'embed one object' do |klass, embeded_object|
  it { expect(klass).to embed_one embeded_object }
end

shared_examples_for 'embeds maby object' do |klass, embeded_object|
  it { expect(klass).to embed_many embeded_object }
end
