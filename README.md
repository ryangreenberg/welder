# welder #

## Overview ##

This Ruby gem is a collection of classes to model the popular iOS game [W.E.L.D.E.R.](http://weldergame.com/) I'm trying to learn some AI techniques, so I thought I would start with a game that I've been playing.

## Usage ##

To start a game and detect words on the pre-populated board, run

    welder --dictionary <dictionary_file>

where `dictionary_file` is a newline-separated list of words. If you are looking for dictionary files, check out the [Word List](http://wordlist.sourceforge.net/) project.

To see additional options, run `welder --help`

## Classes ##

- `Welder::Tile` is an individual letter tile. There are subclasses of `Welder::Tile` for different types of tiles.
- `Welder::Board` represents a grid of tiles.
- `Welder::Word` is a collection of tiles on the board.
- `Welder::Dictionary` provides methods to access a loaded word list.
- `Welder::TileGenerator` creates random tiles based on provided weights for each tile. It uses `Welder::WeightedArray`.
- `Welder::Game` has a `Board`, a `Dictionary`, and a `TileGenerator` and drives gameplay.

## Development ##

Tests can be run with `rake spec`.
