require 'rails_helper'

RSpec.describe MyMovie, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:movie) }

  it { should validate_presence_of(:watched) }
  it { should validate_presence_of(:to_watch) }
end
