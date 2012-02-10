require 'spec_helper'

describe 'fill in date ranges' do
  before do
    @user = Kameleon::User::Guest.new(self)
    @user.debug.visit('/form_elements.html')
  end

  it 'should fill by label' do
    pending 'does not implemented in kameleon dsl'
    @user.will do
      start_time = Time.now
      end_time = Time.now
      see :empty => 'Data ranges'
      fill_in :data_ranges => { :start_date => start_time, :end_date => end_time }
    end
  end

  it 'should fill by id'

  context 'data ranges fields are disabled' do
    it 'should not fill'
  end
end
