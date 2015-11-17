class ListCreator
  attr_reader :params, :user

  def initialize(user, params)
    @user = user
    @params = params
  end

  def list
    list = List.new(user_id: user.id,
      possibility_id: params[:possibility][:possibility_id],
      list_type: params[:possibility][:type]
    )
    if list.save
      list
    end
  end
end
