# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_class' do
    it "returns 'success' class" do
      expect(helper.flash_class('notice')).to eql('success')
    end

    it "returns 'danger' class" do
      expect(helper.flash_class('alert')).to eql('danger')
    end

    it "returns 'default' class" do
      expect(helper.flash_class('foo')).to eql('default')
    end
  end
end
