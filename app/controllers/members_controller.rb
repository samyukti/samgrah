class MembersController < MastersController
  def new
    @master = Member.new
    @master.build_address
  end

  def edit
    @master.build_address unless @master.address
  end

  def photo
    @master = Member.where(id: params[:member_id]).first
    version = params[:version]

    if File.file?(@master.photo_url(version).to_s)
      photo = @master.photo_url(version).to_s
    else
      photo = @master.photo.versions[version.to_sym].default_url
    end

    expires_in 24.hours, public: false
    send_file(photo, disposition: 'inline', x_sendfile: true)
  end

private

  def member_params
    params.require(:member).permit(:membership_id, :code, :name, :kind, :gender, :age_group, :photo, :notes,
                                   address_attributes: [:id, :line_1, :line_2, :landmark, :city,
                                                        :state, :country, :postal_code, :mobile,
                                                        :phone_1, :phone_2, :email_1, :email_2])
  end
end
