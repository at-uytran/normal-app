class User::VideosController < User::BaseController
  def index
    page ||= 1
    per_page ||= 10
    @videos = Video.all.page(page).per(per_page)
  end

  def show
  end

  def create
    @video = Video.new(video_params)    
    ActiveRecord::Base.transaction do
      @video.save!
    end
  rescue ActiveRecord::RecordInvalid
    @video.valid?
  end

  def new
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :file)
  end

  def load_video
    @video = Video.find_by(id: params[:id])
  end
end
