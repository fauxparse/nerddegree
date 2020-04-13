class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[show edit update destroy]
  before_action :presign_post, only: %i[new edit]

  http_basic_authenticate_with(
    name: ENV['ADMIN_USERNAME'],
    password: ENV['ADMIN_PASSWORD'],
    except: %i[index show]
  )

  def index
    respond_to do |format|
      format.html do
        @episodes = Episode.latest_first
        render :coming_soon unless @episodes.any?
      end

      format.rss do
        @episodes = Episode.with_audio.latest_first
      end
    end
  end

  def show; end

  def new
    @episode = Episode.new
  end

  def edit; end

  def create
    @episode = Episode.new(episode_params)

    respond_to do |format|
      if @episode.save
        format.html do
          redirect_to root_path, notice: 'Episode was successfully created.'
        end
        format.json { render :show, status: :created, location: @episode }
      else
        format.html { render :new }
        format.json do
          render json: @episode.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @episode.update(episode_params)
        format.html do
          redirect_to root_path, notice: 'Episode was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit }
        format.json do
          render json: @episode.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @episode.destroy
    respond_to do |format|
      format.html do
        redirect_to root_path, notice: 'Episode was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:title, :date, :url, :content, :size)
  end

  def presign_post
    @presigned_post = S3_BUCKET.presigned_post(
      key: 'episodes/${filename}',
      success_action_status: 201,
      acl: :public_read
    )
  end
end
