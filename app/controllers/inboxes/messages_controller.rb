class Inboxes::MessagesController < ApplicationController
  before_action :set_inbox
  before_action :set_message, only: %i[destroy, upvote ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = @inbox.messages.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = @inbox.messages.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @inbox, notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to @inbox, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upvote
    flash[:notice] = 'upvoted'
    if current_user.voted_up_on? @message
        @message.downvote_from current_user
    elsif current_user.voted_down_on? @message
        @message.liked_by current_user
    else
      @message.liked_by current_user
    end 
    redirect_to @inbox
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @inbox.messages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:body).merge(user: current_user)
    end
    def set_inbox
      @inbox = Inbox.find(params[:inbox_id])
    end
end
