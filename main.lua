
-- Première Raquette --
pad = {}
pad.x = 0
pad.y = 0
pad.largeur = 20
pad.hauteur = 80

-- Deuxième Raquette --
pad2 = {}
pad2.x = 0
pad2.y = 0
pad2.largeur = 20
pad2.hauteur = 80

-- Balle --
balle = {}
balle.x = 400
balle.y = 300
balle.largeur = 20
balle.hauteur = 20
balle.vitesse_x = 2
balle.vitesse_y = 2

-- Score --
score_joueur1 = 0
score_joueur2 = 0

function CentreBalle()
    balle.x = love.graphics.getWidth()/2 - balle.largeur/2
    balle.y = love.graphics.getHeight()/2 - balle.hauteur/2
    balle.vitesse_x = 2
    balle.vitesse_y = 2
end

function love.load()
   CentreBalle()  
   
   pad.x = 0
   pad.y = 0

   pad2.x = love.graphics.getWidth() - pad2.largeur
   pad2.y = love.graphics.getHeight() - pad2.hauteur
end

function love.update()
    -- Raquette Gauche --
    if love.keyboard.isDown("z") and pad.y + pad.hauteur< love.graphics.getHeight() then
        pad.y = pad.y + 3
    end
    if love.keyboard.isDown("s") and pad.y > 0 then
        pad.y = pad.y - 3
    end

 -- Raquette Droite --
    if love.keyboard.isDown("down") and pad2.y + pad2.hauteur< love.graphics.getHeight() then
        pad2.y = pad2.y + 3
    end
    if love.keyboard.isDown("up") and pad.y > 0 then
        pad2.y = pad2.y - 3
    end

    -- Balle --
    balle.x = balle.x + balle.vitesse_x
    balle.y = balle.y + balle.vitesse_y

    -- Rebond sur les murs
    if balle.y > love.graphics.getHeight() - balle.hauteur then
       balle.vitesse_y = - balle.vitesse_y
    end

    if balle.x > love.graphics.getWidth() - balle.largeur then
        -- Perdu pour le joueur de droite
        CentreBalle()
        score_joueur1 = score_joueur1 + 1
    end

    if balle.y < 0 then
       balle.vitesse_y = - balle.vitesse_y
    end

    if balle.x < 0 then
        -- Perdu pour le joueur de gauche ?
        CentreBalle()
        score_joueur2 = score_joueur2 + 1
    end 

    -- La balle a atteint la raquette ? --
    if balle.x <= pad.x + pad.largeur then
        if balle.y + balle.hauteur > pad.y and balle.y < pad.y + pad.hauteur then
            balle.vitesse_x = - balle.vitesse_x
            balle.x = pad.x + pad.largeur
        end
    end

-- La balle a atteint la raquette de droite ?
    if balle.x + balle.largeur > pad2.x then
-- Tester si la balle est sur la raquette
        if balle.y + balle.hauteur > pad2.y and balle.y < pad2.y + pad2.hauteur then
            -- Perdu pour le joueur de droite
        end
    end
end

function love.draw()
    --- Première raquette---
    love.graphics.rectangle("fill",pad.x,pad.y,pad.largeur,pad.hauteur)
    
    --- Deuxième raquette---
    love.graphics.rectangle("fill",pad2.x,pad2.y,pad2.largeur,pad2.hauteur)

    -- Balle--
    love.graphics.rectangle("fill",balle.x,balle.y,balle.largeur,balle.hauteur)

    -- Score --
    local score = score_joueur1.." - "..score_joueur2
    love.graphics.print(score, 400, 0)

end