require 'spec_helper'

describe Region do
  it 'slugs should be unique' do
    @region1 = FactoryGirl.create(:region, slug: 'cincinnati')
    @region2 = FactoryGirl.create(:region)

    expect(@region1.slug).to eq('cincinnati')
    expect(@region2.slug).to eq('cincinnati--2')
  end
end
