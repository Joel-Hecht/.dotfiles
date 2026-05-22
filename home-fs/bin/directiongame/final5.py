#!/usr/bin/env python
# Author: Allen Han 

import pygame
import random
import time
import sys
import os

# Initialize Pygame display
WIDTH = 800
HEIGHT = 600
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Arrow Game")
clock = pygame.time.Clock()

pygame.init()
pygame.mixer.init()
# Sfx and sounds and all that
button_sound = pygame.mixer.Sound(os.path.dirname(__file__) + "/button.mp3")
wrong_sound = pygame.mixer.Sound(os.path.dirname(__file__) + "/wrong.mp3")
right_sound = pygame.mixer.Sound(os.path.dirname(__file__) + "/right.mp3")
over_sound = pygame.mixer.Sound(os.path.dirname(__file__) + "/joever.mp3")
bgm = pygame.mixer.Sound(os.path.dirname(__file__) + "/bgm.mp3")

game_over_sad = pygame.image.load(os.path.dirname(__file__) + "/sadge.png")
pygame.transform.scale(game_over_sad, (60, 40))

def draw_text(text, font, color, surface, x, y):
    text_surface = font.render(text, True, color)
    text_rect = text_surface.get_rect()
    text_rect.topleft = (x, y)
    surface.blit(text_surface, text_rect)

directions = ['LEFT', 'RIGHT', 'UP', 'DOWN']
live_directions = []
other_directions = []

def compare_lists(list1, list2, opts):
    for i, (elem1, elem2) in enumerate(zip(list1, list2)):
        if elem1 != elem2:
            if "mute" not in opts: wrong_sound.play()
            list1.clear()
            list2.clear()
            for i in range(random.randint(3, 6)):
                list1.append(directions[random.randrange(0, 3)])
        else:
            print("",end="")
            
def main(argv): 
    def show_opening_screen(screen):
        screen.fill((0, 0, 0))
        draw_text("Welcome to the Direction Matching Game!", pygame.font.Font(None, 36), (255, 255, 255), screen, 150, 200)
        draw_text("Match the directions with arrow keys.", pygame.font.Font(None, 36), (255, 255, 255), screen, 150, 250)
        draw_text("Press any key to start...", pygame.font.Font(None, 36), (255, 255, 255), screen, 200, 300)
        pygame.display.flip()
        wait_for_key()

    def show_game_over(screen, opts):
        screen.fill((0, 0, 0))
        pygame.mixer.music.set_volume(0)
        screen.blit(game_over_sad, (150, 60))
        draw_text("Game Over!", pygame.font.Font(None, 72), (255, 0, 0), screen, 250, 200)
        draw_text("Play again? Y/N: ", pygame.font.Font(None, 36), (0, 0, 0), screen, 290, 400)
        draw_text("Your Score: " + str(score), pygame.font.Font(None, 36), (0, 0, 0), screen, 310, 300)
        pygame.display.flip()
        joever = True
        while joever:
            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:
                        if event.key == pygame.K_y:
                            main(argv)
                            if "mute" not in opts: button_sound.play()
                        if event.key == pygame.K_n:
                            if "mute" not in opts: button_sound.play()
                            pygame.quit
                            sys.exit()
        pygame.time.wait(2000)  # Wait for 2 seconds before quitting

    score = 0

    def wait_for_key():
        waiting = True
        while waiting:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    quit()
                if event.type == pygame.KEYDOWN:
                    waiting = False
                    if "mute" not in opts: button_sound.play()

    def parse_args(argv):
        opts = set()
        for arg in argv:
            opts.add(arg)
        return opts

    opts = parse_args(argv)

    # Show opening screen
    show_opening_screen(screen)


    # Start game loop
    game_over = False
    while not game_over:
        # Reset variables
        score = 0
        countdown_time = 100
        live_directions.clear()
        other_directions.clear()
        # Play music indefinitely
        pygame.mixer.music.load(os.path.dirname(__file__) + "/bgm.mp3")
        pygame.mixer.music.play(-1)
        pygame.mixer.music.set_volume(0 if "mute" in opts else 1)

        # Generate initial directions
        for _ in range(random.randint(3, 6)):
            live_directions.append(directions[random.randrange(0, 4)])

        # Start timeif "mute" not in opts: r
        start_time = pygame.time.get_ticks()

        # Main game loop
        while not game_over:
            clock.tick(30)
            screen.fill((0, 0, 0))

            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    game_over = True
                if event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_LEFT:
                        other_directions.append(directions[0])
                        if "mute" not in opts: button_sound.play()
                    elif event.key == pygame.K_RIGHT:
                        other_directions.append(directions[1])
                        if "mute" not in opts: button_sound.play()
                    elif event.key == pygame.K_UP:
                        other_directions.append(directions[2])
                        if "mute" not in opts: button_sound.play()
                    elif event.key == pygame.K_DOWN:
                        other_directions.append(directions[3])
                        if "mute" not in opts: button_sound.play()
                    if live_directions == other_directions:
                        score += 10
                        if "mute" not in opts: right_sound.play()
                        countdown_time += len(live_directions)*2+10
                        other_directions.clear()
                        live_directions.clear()
                        for _ in range(random.randint(3, 6)):
                            live_directions.append(directions[random.randrange(0, 4)])
                    compare_lists(live_directions, other_directions, opts)

            # Draw directions and score
            draw_text(str(', '.join(map(str, live_directions))), pygame.font.Font(None, 36), (255, 255, 255), screen, 10, 100)
            draw_text(str(', '.join(map(str, other_directions))), pygame.font.Font(None, 36), (255, 255, 255), screen, 10, 200)
            draw_text("Score: " + str(score), pygame.font.Font(None, 36), (255, 255, 255), screen, 10, 300)

            # Calculate time remaining
            elapsed_time = (pygame.time.get_ticks() - start_time) // 100
            time_remaining = countdown_time - elapsed_time

            # Game over condition
            if time_remaining <= 0:
                if "mute" not in opts: over_sound.play()
                show_game_over(screen, opts)
                game_over = True

            # Draw timeeeeeeeeee
            color = (255, time_remaining*2, time_remaining*2) if time_remaining < 127 else (255, 255, 255)
            draw_text('|' * time_remaining, pygame.font.Font(None, 30), color, screen, 10, 50)
            pygame.display.flip()

    pygame.quit()
main(sys.argv)
