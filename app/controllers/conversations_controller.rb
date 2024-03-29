class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show destroy ]

  # GET /conversations or /conversations.json
  def index
    @conversations = Conversation.all
  end

  # GET /conversations/1 or /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # POST /conversations or /conversations.json
  def create
    @conversation = current_user.conversations.build(conversation_params)

    respond_to do |format|
      if @conversation.save
        TwilioTextMessenger.new(@conversation.text_message, @conversation.phone).call

        format.html { redirect_to @conversation, notice: "Text message sent to friend." }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: "Conversation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.fetch(:conversation, {}).permit(:name, :phone, :text_message)
    end
end
