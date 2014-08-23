//
//  PositionTest.m
//  Stockfish
//
//  Created by Daylen Yang on 1/8/14.
//  Copyright (c) 2014 Daylen Yang. All rights reserved.
//

#import <XCTest/XCTest.h>

#include "Constants.h"
#include "../Chess/position.h"
#include "../Chess/bitboard.h"
#include "../Chess/direction.h"
#include "../Chess/mersenne.h"
#include "../Chess/movepick.h"

using namespace Chess;

@interface PositionTest : XCTestCase

@end

@implementation PositionTest

- (void)setUp
{
    [super setUp];
    init_mersenne();
    init_direction_table();
    init_bitboards();
    Position::init_zobrist();
    Position::init_piece_square_tables();
    MovePicker::init_phase_table();
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPositionClass
{
    Position *p = new Position;
    p->from_fen([FEN_START_POSITION UTF8String]);
    XCTAssertTrue(p->is_ok(), @"You probably didn't do chess init");
}

- (void)testValidFen
{
    NSString *fen = @"rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3";
    XCTAssertTrue(Position::is_valid_fen([fen UTF8String]));
}

- (void)testValidFenNoEp
{
    NSString *fen = @"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq";
    XCTAssertTrue(Position::is_valid_fen([fen UTF8String]));
}

- (void)testValidFenNoCastlingRights
{
    NSString *fen = @"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w";
    XCTAssertTrue(Position::is_valid_fen([fen UTF8String]));
}

@end
