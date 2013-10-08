require 'spec_helper'

describe Study do

  context 'validations' do
    context 'for survey_required_votes' do

      it 'should only be required if has_survey or limit_vote' do
        study = FactoryGirl.build(:study, has_survey: false, limit_votes: false, survey_required_votes: '' )
        expect(study).to be_valid
      end

      it 'should not allow non-numeric values' do
        study = FactoryGirl.build(:study, survey_required_votes: 'blahblah')
        expect(study).to_not be_valid
      end

      it 'should be valid when greater than zero' do
        study = FactoryGirl.build(:study, survey_required_votes: 5)
        expect(study).to be_valid
      end

      it 'should be invalid when equal zero' do
        study = FactoryGirl.build(:study, survey_required_votes: 0)
        expect(study).to_not be_valid
      end

    end
  end

end