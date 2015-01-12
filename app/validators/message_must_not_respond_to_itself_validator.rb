class MessageMustNotRespondToItselfValidator < ActiveModel::Validator
  def validate(record)
    if record.responds_to == record
      record.errors.add(:responds_to, "can't refer to itself")
    end
  end
end
