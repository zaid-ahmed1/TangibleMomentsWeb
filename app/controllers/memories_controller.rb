class MemoriesController < ApplicationController
  before_action :authenticate_user! # Ensure only logged-in users can access
  before_action :set_memory, only: %i[ show edit update destroy ]

  # GET /memories or /memories.json
  def index
    @memories = current_user.memories
  end
  
  def show
    @memory = current_user.memories.find(params[:id])
  end
  
  

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit
  end

  # POST /memories or /memories.json
  def create
    @memory = current_user.memories.build(memory_params)

    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: "Memory was successfully created." }
        format.json { render :show, status: :created, location: @memory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memories/1 or /memories/1.json
  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: "Memory was successfully updated." }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memories/1 or /memories/1.json
  def destroy
    @memory.destroy!

    respond_to do |format|
      format.html { redirect_to memories_path, status: :see_other, notice: "Memory was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def download_qr_code
    memory = Memory.find(params[:id])
    blob_key = memory.video.blob.key # Adjust this to get the correct blob key
    qr_code_url = "https://zaid-ahmed.me/#{blob_key}" # Format the URL

    # Generate the QR code
    require 'rqrcode'
    qr_code = RQRCode::QRCode.new(qr_code_url)

    # Sanitize the memory title to be a valid filename
    sanitized_title = memory.title.parameterize

    send_data qr_code.as_svg(module_size: 6, standalone: true), type: 'image/svg+xml', disposition: 'attachment', filename: "#{sanitized_title}.svg"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memory
      @memory = Memory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def memory_params
      params.require(:memory).permit(:title, :video, :qr_code, :visibility)
    end
end
