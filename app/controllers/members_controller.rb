class MembersController < MastersController
  def new
    @member = Member.new
    @member.build_address
  end

  def edit
    @member.build_address unless @member.address
  end

private

  def master_params
    params.require(:member).permit(:membership_id, :code, :name, :kind, :gender, :age_group, :notes,
                                   address_attributes: [:id, :line_1, :line_2, :landmark, :city,
                                                        :state, :country, :postal_code, :mobile,
                                                        :phone_1, :phone_2, :email_1, :email_2])
  end
end
