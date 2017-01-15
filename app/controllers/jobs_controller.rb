class JobsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]
  before_action :validate_search_key, only: [:search]
  def index
    @jobs = case params[:order]
    when 'by_lower_bound_DESC'
      Job.published.order('wage_lower_bound DESC')
    when 'by_lower_bound_ASC'
      Job.published.order('wage_lower_bound ASC')
    when 'by_upper_bound_DESC'
      Job.published.order('wage_upper_bound DESC')
    when 'by_upper_bound_ASC'
      Job.published.order('wage_upper_bound ASC')
    when 'by_created_DESC'
      Job.published.order('created_at DESC')
    when 'by_created_ASC'
      Job.published.order('created_at ASC')

    else
      Job.published.recent
    end
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.find(params[:id])
    if @job.is_hidden
      flash[:warning] = "This Job already archivevd"
      redirect_to root_path
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path, notice: '创建成功'
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: '删除成功'
  end

  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
    end
  end


  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden)
  end

end
