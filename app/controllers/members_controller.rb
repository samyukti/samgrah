class MembersController < MastersController
  def new
    @master = Member.new
    @master.build_address
  end

  def edit
    @master.build_address unless @master.address
  end

  def copy
    original = @master
    @master  = @master_class.new(original.attributes)
    @master.build_address unless @master.address
    render :new
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

  def select
    @masters = Member.where(id: "#{params[:id]}") if params[:id].present?
    respond_to do |format|
      format.json { render json: MembersSelect.new(@masters, params) }
    end
  end

  private

  def member_params
    params.require(:member).permit(:membership_id, :code, :name, :kind, :gender, :age_group, :photo, :notes,
                                   address_attributes: [:id, :line_1, :line_2, :landmark, :city,
                                                        :state, :country, :postal_code, :mobile,
                                                        :phone_1, :phone_2, :email_1, :email_2])
  end
end
