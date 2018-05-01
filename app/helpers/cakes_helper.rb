module CakesHelper
    def decorationImgURLMethod(cake)
        src=cake.decorationImgURL
        if cake.gallery==true then
            src="previousCake/"+cake.decorationImgURL
        end
        return src
    end
end
