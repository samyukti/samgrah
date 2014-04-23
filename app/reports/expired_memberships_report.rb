class ExpiredMembershipsReport
  def initialize(params)
    @params = params
  end

  def report
    { members: members }
  end

  private

  def members
    Member.where("renewal_date < '#{Date.today}'").page(@params[:page]).page(@params[:per])
  end
end
