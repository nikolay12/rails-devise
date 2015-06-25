class CreatePlan
  def self.call(options={})
    Rails.logger.info "creating the new plan.."
    plan = Plan.new(stripe_id: options[:stripe_id], amount: options[:amount])
    Rails.logger.info "done creating the new plan.."

    if !plan.valid?
      Rails.logger.info "plan not valid.."
      plan.errors.full_messages
      return plan
    end

    begin
      Stripe::Plan.create(
          id: options[:stripe_id],
          amount: options[:amount],
          currency: options[:currency],
          interval: options[:interval],
          trial_period_days: options[:trial_period_days],
          name: options[:name]
      )
      Rails.logger.info "stripe insert went well.."
    rescue Stripe::StripeError => e
      Rails.logger.info "stripe insert did not go well.."
      if e.message != "Plan already exists."
        Rails.logger.info e.to_s
        Rails.logger.error e.message
        plan.errors[:base] << e.message
        return plan
      end
    end

    plan.save

    return plan
  end
end