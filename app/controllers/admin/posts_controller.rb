class Admin::PostsController < ApplicationController
 
 before_filter :authenticate_user!
 layout 'admin_layout'
  
  # GET /posts
  # GET /posts.json
  def index
    @post = Post.search(params) #defined in the model
    @attachment =Attachment.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    if request.path!= admin_post_path(@post)
      redirect_to admin_post_path(@post), :status =>:moved_permanently
    end
    # respond_to do |format|
    #   format.html # show.html.erb
    #   format.json { render :json => @post }
    # end
  end
  
    
  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    
    4.times {@post.attachments.build} #attachments
    @post.citations.build #citations
    @post.categories.build

    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end



  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    
    respond_to do |format|
      if @post.save
        if params[:commit] == 'Save as Draft' # hook to save draft, in addition to the post.
          @post.instantiate_draft! 
          format.html { redirect_to admin_posts_url, :notice => 'Draft saved' }
        else  
          #@post.categories.create(params[:post_category_id]) 
          format.html { redirect_to admin_posts_url, :notice => 'Post was successfully created.' }
          format.json { render :json => @post, :status => :created, :location => @post }
        end
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      case params[:commit]
        when 'Update Draft' 
          # TODO: need to be able to change and update the nested attributes too.
          @post.draft.update_attributes(:content => params[:post][:content], :title => params[:post][:title])
          format.html { redirect_to admin_posts_url, :notice => 'Draft was successfully updated.' }
          format.json { head :ok }
        
        when 'Update Post'
          #@post.replace_with_draft! #investigate this
          @post.update_attributes(params[:post])
          @post.destroy_draft!
          format.html { redirect_to admin_posts_url, :notice => 'Post was successfully published.' }
          format.json { head :ok }
        
        when 'Save as Draft'
          @post.instantiate_draft!
          format.html { redirect_to admin_posts_url, :notice => 'Post saved as a draft.' }
        else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :ok }
    end
  end
  
  
  
  
  
end

