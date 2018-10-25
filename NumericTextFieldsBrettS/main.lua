-- Title: Numeric TextField
-- Name: Brett Shango
-- Course: ICS20/3C
-- This program displays a math question and asks the user to answer in a numeric textfield.
-------------------------------------------------------------------------------------------------------


-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the background color
display.setDefault( "background", 67/255, 34/255, 234/255 )
--------------------------------------------------------
-- LOCAL VARIABLES
--------------------------------------------------------
--create variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer
local gameOver
local lives = 4

local heart1
local heart2
local heart3
local heart4

--create other local variables 
local questionObject
local correctObject
local wrongObject
local numericField
local randomNumber1
local randomNumber2
local randomOperator
local wrongAnswer
local correctAnswer
local pointsTextObject
local numberOfPoints = 0

--------------------------------------------------------
-- SOUNDS
--------------------------------------------------------
--correct sound
local correctSound = audio.loadSound("Sounds/correctSound.mp3")
local correctSoundChannel

--Incorrect Sound
local wrongSound = audio.loadSound("Sounds/wrongSound.mp3")
local wrongSoundChannel



--------------------------------------------------------
-- LOCAL FUNCTIONS
--------------------------------------------------------
local function UpdateHearts()
 if (lives == 4) then
      heart1.isVisible = true
      heart2.isVisible = true
      heart3.isVisible = true
      heart4.isVisible = true

     elseif (lives == 3) then
      heart1.isVisible = true
      heart2.isVisible = true
      heart3.isVisible = true
      heart4.isVisible = false
  
     elseif (lives == 2) then
      heart1.isVisible = true
      heart2.isVisible = true
      heart3.isVisible = false
      heart4.isVisible = false

     elseif (lives == 1) then
      heart1.isVisible = true
      heart2.isVisible = false
      heart3.isVisible = false
      heart4.isVisible = false

     elseif (lives == 0) then
      heart1.isVisible = false
      heart2.isVisible = false
      heart3.isVisible = false
      heart4.isVisible = false
      gameOver.isVisible = true
      numericField.isVisible = false
      pointsTextObject.isVisible = false
      questionObject.isVisible = false
     end
end
-------------------------------------------------------------
local function UpdateTime()
 -- decrement the number of sounds left
 secondsLeft = secondsLeft - 1
 --display the number of seconds left in the
 --clock object
 clockText.text = secondsLeft .. ""
 if (secondsLeft == 0 ) then
  --reset the  number of seconds left 
  secondsLeft = totalSeconds
  -- restart the game when all lives are lost.
  lives = lives - 1

  --***IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND,
  --SHOW A "YOU LOSE IMAGE AND CANCEL THE TIMER, REMOVE
  --REMOVE THE THIRD HEART BY MAKIND IT INVISIBLE
     UpdateHearts()
  --*** CALL THE FUNCTION TO ASK A NEW QUESTION
 end
end
------------------------------------------------------------------------
-- function that calls the timer
local function StartTime()
 -- create a countdown timer that loops infinitely
 countDownTimer = timer.performWithDelay( 2000, UpdateTime, 0)
end

-- local functions 
local function AskQuestion()
 --generate 2 random numbers between a max. and a min. number
 randomOperator = math.random(1,3)
 randomNumber1 = math.random(10,20)
 randomNumber2 = math.random(10,20)
 
  if (randomOperator == 1) then
   correctAnswer = randomNumber1 + randomNumber2
 
  --create question in text object
 questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
 
 elseif (randomOperator == 2) then
   correctAnswer = randomNumber1 - randomNumber2
  
  -- create question in text object
  questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
 
 elseif (randomOperator == 3) then
   correctAnswer = randomNumber1 * randomNumber2
  --create question in text object
  questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
 end 
end


local function HideCorrect()
 correctObject.isVisible = false
 AskQuestion()
end
local function HideIncorrect()
 incorrectObject.isVisible = false 
 AskQuestion()
end


local function NumericFieldListener( event )
 
 --User begins editing "numericFeild"
 if ( event.phase == "began" ) then
 
  --clear text field 
  event.target.text = ""
 
 elseif event.phase == "submitted" then
  -- when the answer is submitted (enter key is pressed) set user input bto user's answer
 
  userAnswer = tonumber(event.target.text)
  
    -- if the user's answer and the correct answer and the correct answer are the same:
   
  if  (userAnswer == correctAnswer) then
    correctObject.isVisible = true 
    correctSoundChannel = audio.play(correctSound)
    incorrectObject.isVisible = false
    timer.performWithDelay(2000,HideCorrect)
    numberOfPoints = numberOfPoints + 1
    event.target.text = ""
        

    -- create increasing points in the text object
    pointsTextObject.text = "Points = ".. numberOfPoints

-- if useranswer and adn the correct answer are not the s
elseif (userAnswer ~= IncorrectAnswer) then
    incorrectObject.isVisible = true
    wrongSoundChannel = audio.play(wrongSound)
    lives = lives - 1
    UpdateHearts()
    incorrectObject.isVisible = true
    timer.performWithDelay(2000,HideIncorrect)
    event.target.text = ""   
  end
 end
end
------------------------------------------------------------
-- OBJECTS CREATION
------------------------------------------------------------
-- create the lives to display on the screen
heart1 = display.newImageRect("Images/heart.png", 100,100)
heart1.x = display.contentWidth * 7 / 8
heart1.y = display.contentHeight * 1 / 7
heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6 / 8
heart2.y = display.contentHeight * 1 / 7
heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5 / 8
heart3.y = display.contentHeight * 1 / 7
heart4 = display.newImageRect("Images/heart.png", 100, 100)
heart4.x = display.contentWidth * 4 / 8
heart4.y = display.contentHeight * 1 / 7

-- display the timer on the screen
clockText = display.newText(secondsLeft, 520, 680, nil, 190)
clockText:setFillColor( 144/255, 234/255, 86/255 )

 
--create and display game over on the screen
gameOver = display.newImageRect("Images/gameOver.png", display.contentWidth, display.contentHeight)
gameOver.anchorX = 0
gameOver.anchorY = 0
gameOver.isVisible = false



-- create points box and make it visible
pointsTextObject = display.newText( "Points = ".. numberOfPoints, 800, 385, nil, 50 )
pointsTextObject:setTextColor(24/255, 119/255, 25/255)

-- display a question and sets the color 
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 80)
questionObject:setTextColor(56/255, 234/255, 100/255)

-- create the correct text object and make it invisible
 correctObject = display.newText("Correct MY Guy", display.contentWidth/2, display.contentHeight/2, 250, 60)
correctObject:setTextColor(34/255, 56/255, 226/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText("Incorrect My Guy", display.contentWidth/2, 250, nil, 50)
incorrectObject:setTextColor(135/255, 34/255, 195/255)
incorrectObject.isVisible = false
-----------------------------------------------------------
-- CREATE THE NUMERIC FIELD 
------------------------------------------------------------
numericField = native.newTextField(display.contentWidth/3, display.contentHeight*2/3, 150, 150)
numericField.inputType = "default"
--add the event listener fo the numeric field
numericField:addEventListener( "userInput", NumericFieldListener)
---------------------------------------------------------
-- FUNCTION CALLS
----------------------------------------------------------
-- call the function to ask the Question
AskQuestion()
StartTime()

