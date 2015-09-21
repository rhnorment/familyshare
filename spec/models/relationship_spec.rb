# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  relative_id :integer          not null
#  pending     :boolean          default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

describe Relationship, type: :model do

  it 'has a valid factory' do
    expect(build(:relationship)).to be_valid
  end

  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:relative_id) }
  it { is_expected.to validate_presence_of(:user_id) }

  it { is_expected.to have_db_column(:user_id).of_type(:integer) }
  it { is_expected.to have_db_column(:relative_id).of_type(:integer) }
  it { is_expected.to have_db_column(:pending).of_type(:boolean).with_options(default: true) }

  it { is_expected.to have_db_index([:user_id, :relative_id]).unique(:true) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:user).class_name('User') }

  it 'should callback to create_activity on create'

  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:relative_id) }
  it { is_expected.to respond_to(:pending) }

  it { is_expected.to respond_to(:approved?) }
  it { is_expected.to respond_to(:pending?) }

  let(:relationship) { create(:relationship) }

      describe '#approved?' do
        it 'should return false if the relationship is not approved' do
          expect(relationship.approved?).to be_falsey
        end

        it 'should return true if the relationship is approved' do
          relationship.pending = false
          expect(relationship.approved?).to be_truthy
        end
      end

      describe '#pending?' do
        it 'should return true if the relationship is pending' do
          expect(relationship.pending?).to be_truthy
        end

        it 'should return false if the relationship is not pending' do
          relationship.pending = false
          expect(relationship.pending?).to be_falsey
        end
      end

end

