require 'rails_helper'

RSpec.describe MyMovie, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:movie) }

  it { should have_valid(:watched).when(true, false) }
  it { should have_valid(:to_watch).when(true, false) }
end
