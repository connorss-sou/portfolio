# Lab 3 (10/16/20)
# Sean Connors

# Global conditions:

firstQ = ['Take left fork', 'Take right fork', 'Investigate sign']
option1 = ['Walk rest of the way', 'Force car down rough road']
option2 = ['Hike down hillside', 'Follow road the rest of the way']
option3 = ['Hike trail', 'Follow most direct road to river']
finalLine = 'Stepping into the frigid water, you take a cast into the blue water.'

# Introduction ----------------------------------------------------------*

print('____________________________________________________________________________________')
print('\n')
print('A long muddy cattle road lies in front of you with little to be seen for a destination.')
print('You did not anticipate the drive to the river to be such a agonizing road in such poor shape.')
print('After several hours of arduous, slow driving, you reach a a fork in the road.')
print('The road splits in two with one side going towards where the river is.')
print('The other side looks in much better shape, but goes in the opposite direction of where you are going (will it lead back?).')
print('You also notice a sign in the forks of the road that is too small to see inside the vehicle.')
print('\n')
# First question:

print('What would you like to do?\n')
secondA = input(firstQ)

# First path ----------------------------------------------------------*

if secondA == firstQ[0]:

    print('\n')
    print('Following your gut, you follow the road leading towards the river, and find the road is getting worse.')
    print('Below you can see the river, but your car can\'t make it down the rest of the way')
    print('\n')
    print('What would you like to do?')
    print('\n')
    nest1 = input(option1)

    if nest1 == option1[0]:
        print('Deciding on stretching your legs, you grab your fishing rod and head to the river.')
        print('It is a long hike but after 15 minutes of hiking, you make it to the water.')
        print('\n',finalLine)    

    if nest1 == option1[1]:
        print('Against your better judgement, you push your car to it\'s limits, and continue onward.')
        print('After 5 minutes of terrifying cliff driving, you make it to the riverbank.')
        print('When you leave your vehicle, you notice your car has 2 flat tires.')
        print('Disgruntled by the problem, you make the decision to follow through with your plans, and go fish anyway.')
        print('You grab the rod and waders out of your car and get rigged up.')
        print('\n',finalLine)

# Second path ----------------------------------------------------------*

if secondA == firstQ[1]:

    print('\n')
    print('Veering to the right, the road becomes significantly easier to manuver.')
    print('You realize after a while however that the road is not decending to the river the way you imagined.')
    print('It quickly becomes apparent that you have 2 options.')
    print('\n')
    print('What would you like to do?')
    print('\n')
    nest2 = input(option2)

    if nest2 == option2[0]:
        print('Having decided on hiking, you grab your fishing rod and make for the hillside')
        print('You follow a rough game trail and make your way towards the river.')
        print('However it turns out to be a relatively short hike to the river, and you prep your rod.')
        print('\n',finalLine)

    if nest2 == option2[1]:
        print('You decide to push on, and find the road to be long but very smooth.')
        print('Eventually after an hour of driving, the road meanders its way towards the basin')
        print('Having made it to the bottom, you park the truck in a gravel lot next to the river and grab your fly rod.')
        print('\n',finalLine)

# Third path ----------------------------------------------------------*

if secondA == firstQ[2]:

    print('\n')
    print('Stopping for a moment, you park the truck on the side of the muddy road.')
    print('You try to not get your flip flops muddy as you walk to the sign.')
    print('The sign reads: \"Take maintained trail or left turn on road to river access\"')
    print('\n')
    print('What would you like to do?')
    print('\n')
    nest3 = input(option3)

    if nest3 == option3[0]:
        print('Having decided on taking the maintained trail, you hike with all of your fishing gear along the trail.')
        print('The trail is well maintained, and you even see some elk at a viewpoint before making it to the river.')
        print('After the unexpected nature walk, you gather your fishing supplies and head towards the water.')
        print('\n',finalLine)

    if nest3 == option3[1]:
        print('You walk back to your truck and head down the left turn to make it to the river.')
        print('The road is very rough, but having wasted so much time you have to push on to have time to fish.')
        print('Having made it to the bottom, you leave your vehicle in a pullout and notice you have a flat tire.')
        print('You realize you might as well fish since you are here, so you grab your fly rod.')
        print('\n',finalLine)
