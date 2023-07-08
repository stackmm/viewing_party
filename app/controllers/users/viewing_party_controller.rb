class Users::ViewingPartyController < ApplicationController
  def new
    @movie = MovieFacade.new(params).search
    @user = User.find(params[:user_id])
    @users = User.where.not(id: @user.id)
  end

  def create
    @user = User.find(params[:user_id])
    party = Party.new(party_params)
    if party.save
      PartyUser.create(user_id: @user.id , party_id: party.id)

      params[:selected_users].each do |user_id|
        PartyUser.create(user_id: user_id, party_id: party.id)
      end

      redirect_to user_path(@user)
    else
      flash[:notice] = party.errors.full_messages.to_sentence
      redirect_to user_viewing_party_path(@user, params[:movie_id])
    end
    ## elsif runtime > party duration "after fixing runtime format"
  end

  private

  def party_params
    params[:host_id] = params[:user_id]
    params.permit(:date, :start_time, :duration, :movie_id, :host_id)
  end

  
end