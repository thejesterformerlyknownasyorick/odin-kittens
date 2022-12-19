class KittensController < ApplicationController

    def index
        @kittens = Kitten.all

        respond_to do |format|
            format.html
            format.json { render :json => @kittens }
        end
    end
    
    def new
        @kitten = Kitten.new
    end

    def create
        @kitten = Kitten.create(kitten_params)

        if @kitten.save
            redirect_to @kitten
        else
            flash[:notice] = "Uh-oh. You failed to create a cat."
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @kitten = Kitten.find(params[:id])

        respond_to do |format|
            format.html
            format.json { render :json => @kitten }
        end
    end

    def destroy
        @kitten = Kitten.find(params[:id])
        if @kitten.present?
            @kitten.destroy
        end
        flash[:notice] = "You destroyed a kitten?? You're going to internet jail."
        redirect_to root_path
    end

    def edit
        @kitten = Kitten.find(params[:id])
    end

    def update
        @kitten = Kitten.find(params[:id])
        if @kitten.update(kitten_params)
            flash[:alert] = "Kitten updated"
            redirect_to @kitten
        else
            flash[:notice] = "Could not update kitten. Maybe it's had all its shots."
            render :new, status: :unprocessable_entity
        end
    end

    private

    def kitten_params
        params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end

end
