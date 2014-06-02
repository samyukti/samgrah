class MembersController < MastersController
  def table
    @members = Member.all.includes(:membership)
    respond_to do |format|
      format.json { render json: MembersDatatable.new(view_context, @members) }
    end
  end

  def new
    @member = Member.new
    @member.build_address
  end

  def edit
    @member.build_address unless @member.address
  end

  def copy
    original = @member
    @member  = Member.new(original.attributes)
    @member.build_address unless @member.address
    render :new
  end

  def photo
    @member = Member.where(id: params[:member_id]).first
    version = params[:version]

    if File.file?(@member.photo_url(version).to_s)
      photo = @member.photo_url(version).to_s
    else
      photo = @member.photo.versions[version.to_sym].default_url
    end

    expires_in 24.hours, public: false
    send_file(photo, disposition: 'inline', x_sendfile: true)
  end

  def select
    @members = Member.where(id: "#{params[:id]}") if params[:id].present?
    respond_to do |format|
      format.json { render json: MembersSelect.new(@members, params) }
    end
  end

  private

  def member_params
    params.require(:member).permit(:membership_id, :code, :name, :kind, :gender, :age_group,
                                   :join_date, :renewed_date, :renewal_date, :closed_date,
                                   :photo, :notes,
                                   address_attributes: [:id, :line_1, :line_2, :landmark, :city,
                                                        :state, :country, :postal_code, :mobile,
                                                        :phone_1, :phone_2, :email_1, :email_2])
  end
end
