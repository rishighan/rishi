class Admin::VariantsController < ApplicationController

before_filter :authenticate_user!
layout 'admin_layout'

  def index
    @variant = Variant.find(:all)
  end

  def new
    @product = Product.find(params[:product_id])
    @variant = Variant.new(params[:product])
    attribution = @variant.attributions.build.build_trait
    #file uploads
     @variant.digitalfiles.new
    
   
   respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @variant }
    end
  end
  
  def create
    @variant = Variant.new(params[:variant])
    pid = params[:product_id]
    @variant.product_id = pid
       
    #@attribution = @variant.attributions.new(params[:attribution])
    
         respond_to do |format|
      if @variant.save
        format.html { redirect_to admin_products_url, :notice => 'Variant successfully created.' }
        format.json { render :json => @variant, :status => :created, :location => @variant }
      else
        format.html { render :action => "new" }
        format.json { render :json => @variant.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  def who_bought
    @variant = Variant.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml {render :xml => @variant}
    end
  end

  def update
  end

   def destroy
    @variant = Variant.find(params[:id])
    @variant.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url }
      format.json { head :ok }
    end
  end

end
