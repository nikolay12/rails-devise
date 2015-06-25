class PlansController < ApplicationController

  def create
    @plan = Plan.new(plan_params)
  end

  private

  def plan_params
    #params.require(:plan).permit!
    params.require(:plan).(Plan.fields.keys)
  end

end


