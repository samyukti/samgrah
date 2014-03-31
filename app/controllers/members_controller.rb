class MembersController < MastersController
  def new
    @master = Member.new
    @master.build_address
  end

  def edit
    @master.build_address unless @master.address
  end

private

  def member_params
    master_params
  end

  def master_params
    params.require(:member).permit(:membership_id, :code, :name, :kind, :gender, :age_group, :notes,
                                   address_attributes: [:id, :line_1, :line_2, :landmark, :city,
                                                        :state, :country, :postal_code, :mobile,
                                                        :phone_1, :phone_2, :email_1, :email_2])
  end
end
