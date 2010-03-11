class HomeController < ApplicationController
  include ActionView::Helpers::TextHelper
  #caches_page :about, :tour, :privacy
  before_filter :authenticate, :only => [:admin]
  before_filter :admin_only, :only => [:no_google_tracking]

  def index
  end

  def no_google_tracking
  end

 # def login
 #   if request.post?
 #     set_user(params[:email], params[:password])
 #     if user_account?
 #       flash.now[:notice] = t('session.logged_in_successfully')
 #       redirect_to users_path
 #     else
 #       reset_user
 #       flash.now[:error] = t('session.no_account')
 #     end
 #   end
 # end
#
#  def logout
#    reset_user
#    redirect_to root_path
#  end
#
#  def forgot_password
#    if request.post?
#      user = User.first(:conditions => { :email => params[:email] })
#      if user
#        Mailer.deliver_password(user)
#        flash[:notice] = t('user.retrieve_success')
#        redirect_to login_path
#      else
#        flash[:error] = t('user.no_email')
#      end
#    end
#  end

  def about
    #about_question = Question.find(1)#Const::ABOUT_QUESTION_ID)
    # set_pairwise_user(about_question.user.email, about_question.user.decoded_password)
    # @id, @question, @items, @votes = Pairwise.get_question(about_question.pairwise_id)
    # @url1 = named_url_for_question(about_question)
  end

#  def tour
#    demo_vars
#  end

#  def privacy
#  end
  
  def admin
    @questions_hash = {}
    if current_user.admin?
	@earls = Earl.find(:all)
	@questions = Question.find(:all, :order => 'votes_count')
	@recent_votes_by_question_id = Question.get(:recent_votes_by_question_id)
	@user_submitted_idea_info = Question.get(:object_info_totals_by_question_id)


	if @recent_votes_by_question_id == "\n" #no data
		@recent_votes_by_question_id = {}
        end
	
	@questions.each do |q|
		@questions_hash[q.id.to_s] = q
		if !@recent_votes_by_question_id.has_key?(q.id.to_s)
			@recent_votes_by_question_id[q.id.to_s] = 0
		end
		if !@user_submitted_idea_info.has_key?(q.id.to_s)
			@user_submitted_idea_info[q.id.to_s] = {}
			@user_submitted_idea_info[q.id.to_s]["total_ideas"] = 0
			@user_submitted_idea_info[q.id.to_s]["active_ideas"] = 0
		end
		if !@user_submitted_idea_info[q.id.to_s].has_key?("active_ideas")
			@user_submitted_idea_info[q.id.to_s]["active_ideas"] = 0
		end

	end


        @available_charts = {}
        @available_charts['votes'] = { :title => "Number of all votes over time"}
        @available_charts['user_submitted_ideas'] = { :title => "Number of all submitted ideas over time"}
        @available_charts['user_sessions'] = { :title => "Number of all user sessions per day"}
        @available_charts['unique_users'] = { :title => "Number of all unique users per day"}
    else
    	@earls = current_user.earls.sort_by {|x| [(!x.active).to_s, x.name]}
	@recent_votes_by_question_id = Question.get(:recent_votes_by_question_id, :creator_id => current_user.id)

	if @recent_votes_by_question_id == "\n" #no data
		@recent_votes_by_question_id = {}
        end

	@earls.each do|e|
		if !@recent_votes_by_question_id.has_key?(e.question_id.to_s)
			@recent_votes_by_question_id[e.question_id.to_s] = 0
		end
	end
    end


  end

#  private
#    def demo_vars
#      question = Question.find(1)#Const::TOUR_DEMO_QUESTION_ID)
#      #set_pairwise_user(question.user.email, question.user.decoded_password)
#      #@id, @question, @items, @votes = Pairwise.get_question(question.pairwise_id)
#      #@url1 = named_url_for_question(question)
#    end
end
