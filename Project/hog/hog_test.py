from dice import six_sided,make_test_dice
from ucb import main,trace,interact

GOAL=100

def roll_dice(num_rolls,dice=six_sided):
    pig_out=0
    dice_result=[dice() for i in range(num_rolls)]
    if 1 in dice_result:pig_out=1
    return 1 if pig_out else sum(dice_result)

def boar_brawl(player_score,opponent_score):
    return max(1,3*abs(player_score%10-(opponent_score%100)//10))

def take_turn(num_rolls, player_score, opponent_score, dice=six_sided):
    if num_rolls==0:return boar_brawl(player_score, opponent_score)
    else:return roll_dice(num_rolls, dice)

def prime_judge(n):
    if n==1:return False
    for k in range(2,n):
        if n%k==0:return False
    return True

def num_factors(n):
    factors_num=0
    for i in range(1,n+1):
        if n%i==0:factors_num+=1
    return factors_num

def sus_points(score):
    factors_num=num_factors(score)
    if factors_num==3 or factors_num==4:
        new_score=score+1
        while not prime_judge(new_score):new_score+=1
        return new_score
    else:return score

def simple_update(num_rolls, player_score, opponent_score, dice=six_sided):
    return player_score + take_turn(num_rolls, player_score, opponent_score, dice)

def sus_update(num_rolls, player_score, opponent_score, dice=six_sided):
    return sus_points(take_turn(num_rolls, player_score, opponent_score, dice))+player_score

def play(strategy0, strategy1, update,score0=0, score1=0, dice=six_sided, goal=GOAL):
    who=0
    while score0<goal and score1<goal:
        if who==0:
            strategy=strategy0
            num_rolls=strategy(score0,score1)
            score0=update(num_rolls,score0,score1,dice)
        else:
            strategy=strategy1
            num_rolls=strategy(score1,score0)
            score1=update(num_rolls,score1,score0,dice)
        who=1-who

def always_roll(n):
    def strategy(score, opponent_score):
        return n
    return strategy


def catch_up(score, opponent_score):
    return 6 if score<opponent_score else 5

def is_always_roll(strategy, goal=GOAL):
    temp=strategy(0,0)
    for i in range(goal):
        for j in range(goal):
            if temp!=strategy(i,j):return False
    return True

def make_averaged(original_function, samples_count=1000):
    def average_function(*args):
        sample=[original_function(*args) for i in range(samples_count)]
        return sum(sample)/samples_count
    return average_function

def max_scoring_num_rolls(dice=six_sided, samples_count=1000):
    average_dice=make_averaged(roll_dice,samples_count)
    max_roll_num,max_roll_score=1,average_dice(1,dice)
    for i in range(2,11):
        roll_score=average_dice(i,dice)
        if roll_score>max_roll_score:
            max_roll_num=i
            max_roll_score=roll_score
    return max_roll_num

def winner(strategy0, strategy1):
    score0,score1=play(strategy0,strategy1,sus_update)
    return 0 if score0 > score1 else 1

def average_win_rate(strategy, baseline=always_roll(6)):
    win_rate_as_player_0 = 1 - make_averaged(winner)(strategy, baseline)
    win_rate_as_player_1 = make_averaged(winner)(baseline, strategy)
    return (win_rate_as_player_0 + win_rate_as_player_1) / 2

def run_experiments():
    six_sided_max = max_scoring_num_rolls(six_sided)
    print('Max scoring num rolls for six-sided dice:', six_sided_max)
    print('always_roll(6) win rate:', average_win_rate(always_roll(6))) # near 0.5
    print('catch_up win rate:', average_win_rate(catch_up))
    print('always_roll(3) win rate:', average_win_rate(always_roll(3)))
    print('always_roll(8) win rate:', average_win_rate(always_roll(8)))
    print('boar_strategy win rate:', average_win_rate(boar_strategy))
    print('sus_strategy win rate:', average_win_rate(sus_strategy))
    print('final_strategy win rate:', average_win_rate(final_strategy))

def boar_strategy(score, opponent_score, threshold=11, num_rolls=6):
    return 0 if boar_brawl(score,opponent_score)>threshold else num_rolls

def sus_strategy(score, opponent_score, threshold=11, num_rolls=6):
    return 0 if sus_update(0,score,opponent_score)-score>threshold else num_rolls

def final_strategy(score, opponent_score):
    """Write a brief description of your final strategy.

    *** YOUR DESCRIPTION HERE ***
    """
    # BEGIN PROBLEM 12
    return 6  # Remove this line once implemented.
    # END PROBLEM 12

@main
def run(*args):
    """Read in the command-line argument and calls corresponding functions."""
    import argparse
    parser = argparse.ArgumentParser(description="Play Hog")
    parser.add_argument('--run_experiments', '-r', action='store_true',
                        help='Runs strategy experiments')
    args = parser.parse_args()
    if args.run_experiments:
        run_experiments()