require 'rails_helper'

RSpec.describe CalendarsEvent, type: :model do
  it { should belong_to(:calendar) }
  it { should belong_to(:event) }
end
