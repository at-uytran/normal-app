class FormatRuleValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    rule_type = options[:rule] || attribute
    return if value.blank? || value.to_s.match?(Settings.regexp[rule_type])
    record.errors.add(attribute, (options[:message] || :wrong_format))
  end
end