class UnavailableCopiesReport
  def initialize(params)
    @params = params
  end

  def report
    { copies: copies }
  end

  private

  def copies
    Copy.unavailable.page(@params[:page]).page(@params[:per])
  end
end
