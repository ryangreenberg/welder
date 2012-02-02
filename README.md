# welder #

## Overview ##

This Ruby gem is a collection of classes to model the popular iOS game [W.E.L.D.E.R.](http://weldergame.com/) I'm trying to learn some AI techniques, so I thought I would start with a game that I've been playing.

## Usage ##

To start a game and detect words on the pre-populated board, run

    welder <dictionary_file>

where `dictionary_file` is a newline-separated list of words.

## Classes ##

- `Welder::Tile` is an individual letter tile
- `Welder::Board` represents a grid of tiles
- `Welder::Word` is a collection of tiles on the board
- `Welder::Dictionary` provides methods to access the loaded word list
- `Welder::Game` has a `Dictionary` and a `Board` and drives gameplay

## Development ##

Tests can be run with `rake spec`.