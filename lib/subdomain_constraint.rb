# frozen_string_literal: true

class SubdomainConstraint
  attr_reader :prefix

  def initialize(prefix)
    @prefix = prefix
  end

  def matches?(request)
    return unless request.subdomain.present?
    request.subdomain((ENV['TLD_LENGTH'] || 1).to_i) == prefix
  end
end
