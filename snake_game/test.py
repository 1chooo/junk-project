# -*- coding: utf-8 -*-

import pygame
import random
from enum import Enum
from collections import namedtuple
import SnakeGame


if __name__ == '__main__':
    game = SnakeGame()

    # game loop
    while True:
        gameOver, score = game.play_step()

        if gameOver == True:
            break

    print('Final Score', score)

    pygame.quit()